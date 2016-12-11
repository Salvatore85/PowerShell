configuration Test1 {

    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node "Test1" 
    {
    
        File CreateDirectory
        {
        
            Ensure = 'Present'
            Type = 'Directory'
            DestinationPath = 'C:\Management'
            
        }

        File CreateTXT
        {
            DestinationPath = 'C:\Management\Test1.txt'
            Type = 'File'
            Ensure = 'Present'
            Contents = 'Test succeeded'
            DependsOn = '[File]CreateDirectory'
        }

        Log Test1
        {
            Message = 'Configuration Test1 applied succesfully'
            DependsOn = '[File]CreateDirectory','[File]CreateTXT'
        }
    }
}