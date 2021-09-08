#requires -version 2
<#
.SYNOPSIS
  <Overview of script>
.DESCRIPTION
  <Brief description of script>
.PARAMETER <Parameter_Name>
    <Brief description of parameter input required. Repeat this attribute if required>
.COMPONENT
    The component this cmdlet belongs to
.INPUTS
  <Inputs if any, otherwise state None>
.OUTPUTS
  <Outputs if any, otherwise state None - example: Log file stored in C:\Windows\Temp\<name>.log>
.NOTES
  Version:        1.0
  Author:         <Name>
  Creation Date:  <Date>
  Purpose/Change: Initial script development
  
.EXAMPLE
  <Example goes here. Repeat this attribute for more than one example>
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = "SilentlyContinue"

#Dot Source required Function Libraries
. "C:\Scripts\Functions\Logging_Functions.ps1"

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$sScriptVersion = "1.0"

#Log File Info
$sLogPath = "C:\Windows\Temp"
$sLogName = "<script_name>.log"
$sLogFile = Join-Path -Path $sLogPath -ChildPath $sLogName

#-----------------------------------------------------------[Functions]------------------------------------------------------------

<#
Function <FunctionName>
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
        SupportsShouldProcess=$true, 
        PositionalBinding=$false,
        HelpUri = 'http://www.microsoft.com/',
        ConfirmImpact='Medium')]
    [Alias()]
    [OutputType([String])]
                         
     Param
     (
         # Param1 help description
         [Parameter(Mandatory=$true, 
                    ValueFromPipeline=$true,
                    ValueFromPipelineByPropertyName=$true, 
                    ValueFromRemainingArguments=$false, 
                    Position=0,
                    ParameterSetName='Parameter Set 1')]
         [ValidateNotNull()]
         [ValidateNotNullOrEmpty()]
         [ValidateCount(0,5)]
         [ValidateSet("sun", "moon", "earth")]
         [Alias("p1")] 
         $Param1,
    
         # Param2 help description
         [Parameter(ParameterSetName='Parameter Set 1')]
         [AllowNull()]
         [AllowEmptyCollection()]
         [AllowEmptyString()]
         [ValidateScript({$true})]
         [ValidateRange(0,5)]
         [int]
         $Param2,
    
         # Param3 help description
         [Parameter(ParameterSetName='Another Parameter Set')]
         [ValidatePattern("[a-z]*")]
         [ValidateLength(0,15)]
         [String]
         $Param3
     )
                     
  
  Begin{
    Log-Write -LogPath $sLogFile -LineValue "<description of what is going on>..."
  }
  
  Process{
    Try{
      <code goes here>
    }
    
    Catch{
      Log-Error -LogPath $sLogFile -ErrorDesc $_.Exception -ExitGracefully $True
      Break
    }
  }
  
  End{
    If($?){
      Log-Write -LogPath $sLogFile -LineValue "Completed Successfully."
      Log-Write -LogPath $sLogFile -LineValue " "
    }
  }
}
#>

#-----------------------------------------------------------[Execution]------------------------------------------------------------

#Log-Start -LogPath $sLogPath -LogName $sLogName -ScriptVersion $sScriptVersion
#Script Execution goes here
#Log-Finish -LogPath $sLogFile