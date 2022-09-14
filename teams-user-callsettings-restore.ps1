connect-microsoftteams
$users = Import-Csv -Path $env:userprofile\teams-user-call-settings.csv

foreach($user in $users){
    if($user.IsUnansweredEnabled -eq 'TRUE'){$unanswered = $true}
    if($user.IsUnansweredEnabled -eq 'FALSE'){$unanswered = $false}
    if($user.DelegateMakeCalls -eq 'TRUE'){$DelegateMakeCalls = $true}
    if($user.DelegateMakeCalls -eq 'FALSE'){$DelegateMakeCalls = $false}
    if($user.DelegateManageSettings -eq 'TRUE'){$DelegateManageSettings = $true}
    if($user.DelegateManageSettings -eq 'FALSE'){$DelegateManageSettings = $false}
    if($user.DelegateReceiveCalls -eq 'TRUE'){$DelegateReceiveCalls = $true}
    if($user.DelegateReceiveCalls -eq 'FALSE'){$DelegateReceiveCalls = $false}
    Set-CsUserCallingSettings -Identity $user.UserPrincipalName -IsUnansweredEnabled $unanswered -UnansweredDelay $user.UnansweredDelay -UnansweredTargetType $user.UnansweredTargetTypem 
    try{
        Set-CsUserCallingDelegate -Identity $user.UserPrincipalName -Delegate $user.Delegates -MakeCalls $DelegateMakeCalls -ManageSettings $DelegateManageSettings -ReceiveCalls $DelegateReceiveCalls
} 
    catch{
        new-CsUserCallingDelegate -Identity $user.UserPrincipalName -Delegate $user.Delegates -MakeCalls $DelegateMakeCalls -ManageSettings $DelegateManageSettings -ReceiveCalls $DelegateReceiveCalls
    }}
