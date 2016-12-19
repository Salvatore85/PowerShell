configuration HTTPSDSCPull {

    [CmdletBinding()]
    param(
        [string[]]$nodeName,

        [string] $certificateThumbPrint,

        [string] $registrationKey
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName xPSDesiredStateConfiguration

    Node $nodeName 
    {

        LocalConfigurationManager
        {
            ActionAfterReboot  = 'ContinueConfiguration'
            ConfigurationMode  = 'ApplyAndAutoCorrect'
            RebootNodeIfNeeded = $true
        }

        WindowsFeature DSCServiceFeature
        {
            Ensure = "Present"
            Name   = "DSC-Service"
        }

        WindowsFeature IISConsole
        {
            Ensure = "Present"
            Name   = "Web-Mgmt-Console"
        }

        xDSCWebService PSDSCPullServer
        {
            Ensure                   = "Present"
            EndpointName             = "PSDSCPullServer"
            Port                     = 8080
            PhysicalPath             = "$env:SystemDrive\inetpub\wwwroot\PSDSCPullServer"
            CertificateThumbPrint    = $certificateThumbPrint
            ModulePath               = "D:\DscService\Modules"
            ConfigurationPath        = "D:\DscService\Configuration"
            State                    = "Started"
            DependsOn                = "[WindowsFeature]DSCServiceFeature"
            UseSecurityBestPractices = $false
        }

        File RegistrationKeyFile
        {
            Ensure          = 'Present'
            Type            = 'File'
            DestinationPath = "$env:ProgramFiles\WindowsPowerShell\DscService\RegistrationKey.txt"
            Contents        = $registrationKey
        }

    }

}

$computerName = 'DSCPull'
$certificateThumbPrint = '8C549B1A16AEE8EE5C46D771CD8B895FA2AC96E2'
$registrationKey = 'ab068a9d-0d8e-4117-a866-4be55389f843'

HTTPSDSCPull -nodeName $computerName -certificateThumbprint $certificateThumbPrint -registrationKey $registrationKey -outputpath "E:\Powershell Scripts\DSC\MOF Files"