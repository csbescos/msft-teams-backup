#connect-microsoftteams
$users = get-csonlineuser -ResultSize 10000

foreach($user in $users){
    if($user.AccountEnabled -eq 'TRUE'){
    try{
    $callsettings = get-csusercallingsettings -Identity $user.UserPrincipalName 
        }
    catch{}   
    }
    else{}
    $callvalues = New-Object psobject
    $callvalues | add-member -MemberType NoteProperty -Name UserPrincipalName -Value $user.UserPrincipalName
    $callvalues | add-member -MemberType NoteProperty -Name SipUri -Value $callsettings.SipUri
    $callvalues | add-member -MemberType NoteProperty -Name IsForwardingEnabled -Value $callsettings.IsForwardingEnabled
    $callvalues | add-member -MemberType NoteProperty -Name ForwardingType -Value $callsettings.ForwardingType
    $callvalues | add-member -MemberType NoteProperty -Name ForwardingTarget -Value $callsettings.ForwardingTarget
    $callvalues | add-member -MemberType NoteProperty -Name ForwardingTargetType -Value $callsettings.ForwardingTargetType
    $callvalues | add-member -MemberType NoteProperty -Name IsUnansweredEnabled -Value $callsettings.IsUnansweredEnabled
    $callvalues | add-member -MemberType NoteProperty -Name UnansweredTarget -Value $callsettings.UnansweredTarget
    $callvalues | add-member -MemberType NoteProperty -Name UnansweredTargetType -Value $callsettings.UnansweredTargetType
    $callvalues | add-member -MemberType NoteProperty -Name UnansweredDelay -Value $callsettings.UnansweredDelay
    $callvalues | add-member -MemberType NoteProperty -Name CallGroupOrder -Value $callsettings.CallGroupOrder
    $callvalues | add-member -MemberType NoteProperty -Name CallGroupTargets -Value $callsettings.CallGroupTargets
    $callvalues | add-member -MemberType NoteProperty -Name Delegates -Value $callsettings.Delegates.Id
    $callvalues | add-member -MemberType NoteProperty -Name DelegateMakeCalls -Value $callsettings.Delegates.MakeCalls
    $callvalues | add-member -MemberType NoteProperty -Name DelegateManageSettings -Value $callsettings.Delegates.ManageSettings
    $callvalues | add-member -MemberType NoteProperty -Name DelegateReceiveCalls -Value $callsettings.Delegates.ReceiveCalls
    $callvalues | add-member -MemberType NoteProperty -Name Delegators -Value $callsettings.Delegators.Id
    $callvalues | add-member -MemberType NoteProperty -Name DelegatorsMakeCalls -Value $callsettings.Delegators.MakeCalls
    $callvalues | add-member -MemberType NoteProperty -Name DelegatorsManageSettings -Value $callsettings.Delegators.ManageSettings
    $callvalues | add-member -MemberType NoteProperty -Name DelegatorsReceiveCalls -Value $callsettings.Delegators.ReceiveCalls
    #$callvalues | add-member -MemberType NoteProperty -Name GroupMembershipDetails -Value $callsettings.GroupMembershipDetails
    #$callvalues | add-member -MemberType NoteProperty -Name GroupNotificationOverride -Value $callsettings.GroupNotificationOverride


    $callvalues | Export-CSV -path $env:userprofile\teams-user-call-settings.csv -Append -NoTypeInformation
    $user | Export-CSV -path $env:userprofile\teams-user-settings.csv -Append -NoTypeInformation
 
} 