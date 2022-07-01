$OtherCleanPathsArr = “C:\Temp\*”, “C:\Windows\Temp\*”, “C:\swsetup”
#системные пути для очистки
$InProfilesCleanPathsArr = “\AppData\Local\Temp\*”, “\AppData\Local\*.auc”, “\AppData\Local\Microsoft\Terminal Server Client\Cache\*”, “\AppData\Local\Microsoft\Windows\Temporary Internet Files\*”, “\AppData\Local\Microsoft\Windows\WER\ReportQueue\*”, “\AppData\Local\Microsoft\Windows\Explorer\*”
#пути в профилях для очистки
$Profiles = Get-ChildItem (Get-ItemProperty -path “HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList”).ProfilesDirectory -Exclude “Администратор”, “Administrator”, “Setup”, “Public”, “All Users”, “Default User”
#извлекли из реестра местоположение профилей, сформировали список

ForEach ($Path in $OtherCleanPathsArr) {
Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue
}
Write-Host 'Системный мусор - пока!' -ForegroundColor Green

ForEach ($Profile in $Profiles) {
ForEach ($Path in $InProfilesCleanPathsArr) {
Remove-Item -Path $Profile$Path -Recurse -Force -ErrorAction SilentlyContinue
}
}
Write-Host 'Профильный мусор - пока!' -ForegroundColor Green
Write-Host 'DONE' -ForegroundColor Magenta
pause