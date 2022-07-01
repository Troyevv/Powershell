
if (Test-Path -Path HKLM:\SOFTWARE\ORACLE) {
Remove-Item -Path HKLM:\SOFTWARE\ORACLE -Recurse -ErrorAction Continue
Write-Host 'Раздел в реестре ORACLE удален' -ForegroundColor Green
}
else {
Write-Host 'Путь "HKLM:\SOFTWARE\ORACLE" не найден' -ForegroundColor Red
}

if (Test-Path -Path C:\app) {
Remove-Item -Path C:\app -Recurse -ErrorAction Continue
Write-Host 'Папка "C:\app" удалена' -ForegroundColor Green
}
else {
Write-Host 'Путь "C:\app" не найден' -ForegroundColor Red
}

if (Test-Path -Path C:\oracle) {
Remove-Item -Path C:\oracle -Recurse -ErrorAction Continue
Write-Host 'Папка "C:\oracle" удалена' -ForegroundColor Green
}
else {
Write-Host 'Путь "C:\oracle" не найден' -ForegroundColor Red
}

if (Test-Path -Path 'C:\Program Files\Oracle\') {
Remove-Item -Path 'C:\Program Files\Oracle\' -Recurse -ErrorAction Continue
Write-Host 'Папка "C:\Program Files\Oracle" удалена' -ForegroundColor Green
}
else {
Write-Host 'Путь "C:\Program Files\Oracle" не найден' -ForegroundColor Red
}

if (Test-Path -Path 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\*' -Include 'Ora*', 'OraWeb*') {
Remove-Item -Path 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\*' -Include 'Ora*', 'OraWeb*' -Recurse -ErrorAction Continue
Write-Host 'Папка "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ora*" удалена' -ForegroundColor Green
}
else {
Write-Host 'Путь "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ora*" не найден' -ForegroundColor Red
}

$pathreg = 'HKCU:\SYSTEM\CurrentControlSet\Services\EventLog\Application\Ora*'
if (Test-Path $pathreg -Include 'Ora*' -PathType Container) {
Remove-Item $pathreg -Include 'Ora*' -Recurse -ErrorAction Continue
Write-Host 'Папка "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Application\ora*" удалена' -ForegroundColor Green
}
else {
Write-Host 'Путь "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Application\ora*" не найден' -ForegroundColor Red
}

if (Test-Path -Path HKLM:\ -Include 'Ora*') {
Remove-Item -Path HKLM:\* -Include 'Ora*' -Recurse -ErrorAction Continue
Write-Host 'Папка "HKEY_LOCAL_MACHINE\ora*" удалена' -ForegroundColor Green
}
else {
Write-Host 'Путь "HKEY_LOCAL_MACHINE\ora*" не найден' -ForegroundColor Red
}

Get-Item $pathreg {Name -like 'ora*' } | Remove-Item -Force -ErrorAction Continue


Write-Host 'Oracle удален с данного ПК' -ForegroundColor Green

pause
