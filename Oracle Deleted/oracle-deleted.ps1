
if (Test-Path -Path HKLM:\SOFTWARE\ORACLE) {
Remove-Item -Path HKLM:\SOFTWARE\ORACLE -Recurse -ErrorAction Continue
Write-Host '������ � ������� ORACLE ������' -ForegroundColor Green
}
else {
Write-Host '���� "HKLM:\SOFTWARE\ORACLE" �� ������' -ForegroundColor Red
}

if (Test-Path -Path C:\app) {
Remove-Item -Path C:\app -Recurse -ErrorAction Continue
Write-Host '����� "C:\app" �������' -ForegroundColor Green
}
else {
Write-Host '���� "C:\app" �� ������' -ForegroundColor Red
}

if (Test-Path -Path C:\oracle) {
Remove-Item -Path C:\oracle -Recurse -ErrorAction Continue
Write-Host '����� "C:\oracle" �������' -ForegroundColor Green
}
else {
Write-Host '���� "C:\oracle" �� ������' -ForegroundColor Red
}

if (Test-Path -Path 'C:\Program Files\Oracle\') {
Remove-Item -Path 'C:\Program Files\Oracle\' -Recurse -ErrorAction Continue
Write-Host '����� "C:\Program Files\Oracle" �������' -ForegroundColor Green
}
else {
Write-Host '���� "C:\Program Files\Oracle" �� ������' -ForegroundColor Red
}

if (Test-Path -Path 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\*' -Include 'Ora*', 'OraWeb*') {
Remove-Item -Path 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\*' -Include 'Ora*', 'OraWeb*' -Recurse -ErrorAction Continue
Write-Host '����� "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ora*" �������' -ForegroundColor Green
}
else {
Write-Host '���� "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ora*" �� ������' -ForegroundColor Red
}

$pathreg = 'HKCU:\SYSTEM\CurrentControlSet\Services\EventLog\Application\Ora*'
if (Test-Path $pathreg -Include 'Ora*' -PathType Container) {
Remove-Item $pathreg -Include 'Ora*' -Recurse -ErrorAction Continue
Write-Host '����� "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Application\ora*" �������' -ForegroundColor Green
}
else {
Write-Host '���� "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Application\ora*" �� ������' -ForegroundColor Red
}

if (Test-Path -Path HKLM:\ -Include 'Ora*') {
Remove-Item -Path HKLM:\* -Include 'Ora*' -Recurse -ErrorAction Continue
Write-Host '����� "HKEY_LOCAL_MACHINE\ora*" �������' -ForegroundColor Green
}
else {
Write-Host '���� "HKEY_LOCAL_MACHINE\ora*" �� ������' -ForegroundColor Red
}

Get-Item $pathreg {Name -like 'ora*' } | Remove-Item -Force -ErrorAction Continue


Write-Host 'Oracle ������ � ������� ��' -ForegroundColor Green

pause
