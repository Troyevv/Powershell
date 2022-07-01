Set-ExecutionPolicy -Scope CurrentUser
if (Test-Path C:\app\product\11.2.0\client_1\deinstall\) {
Invoke-Item 'C:\app\product\11.2.0\client_1\deinstall\deinstall.bat'
}
else {
Write-Host 'Локальный Оракл 11 не установлен' -ForegroundColor Red
}
Wait-Event -Timeout 3
if (Test-Path C:\app\client\product\12.2.0\client_1\deinstall) {
Invoke-Item 'C:\app\client\product\12.2.0\client_1\deinstall\deinstall.bat'
}
else {
Write-Host 'Локальный Оракл 12 не установлен' -ForegroundColor Red
}
Wait-Event -Timeout 3
if (Test-Path C:\app\client\product\19.0.0\client_1\deinstall) {
Invoke-Item 'C:\app\client\product\19.0.0\client_1\deinstall\deinstall.bat'
}
else {
Write-Host 'Лольный Оракл 19 не установлен' -ForegroundColor Red
}
Write-Host 'Done' -ForegroundColor Green

pause