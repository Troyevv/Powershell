Import-Module ActiveDirectory
$user = Read-Host 'Кого ищем?'
if (Get-ADUser $user -properties PasswordExpired, PasswordLastSet, PasswordNeverExpires, lastlogontimestamp)
{
[string]$user
}
else
{
[int]$user
Get-ADUser -Properties ExtensionAttribute9,whencreated,Enabled,city,mail -Filter {ExtensionAttribute9 -eq $user}
}
pause