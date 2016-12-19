[DscLocalConfigurationManager()]
Configuration LCMSimple
{
    Node SRV2
    {
        Settings
        {
            RefreshMode = 'Pull'
            RebootNodeIfNeeded = $true
            ConfigurationMode = 'ApplyAndAutoCorrect'        
            ActionAfterReboot = 'ContinueConfiguration'
            AllowModuleOverwrite = $true
            
        }

        ConfigurationRepositoryWeb Pull
        {
            ServerURL = 'https://DSCPULL:8080/PSDSCPullServer.svc'
            ConfigurationNames = 'Test1'
            RegistrationKey = '0455c813-faa7-4b02-bcdf-da6047b36f81'
        }

        ReportServerWeb PullServer
        {
            ServerURL = 'https://DSCPULL:8080/PSDSCPullServer.svc'
            RegistrationKey = '0455c813-faa7-4b02-bcdf-da6047b36f81'
        }
    }
}