Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);'

[Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 0)

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(400,400)
$Form.text                       = "Проверка сетевого доступа"
$Form.TopMost                    = $true

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Введите имя сервера"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(131,29)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBox1                        = New-Object system.Windows.Forms.TextBox
$TextBox1.multiline              = $false
$TextBox1.width                  = 100
$TextBox1.height                 = 20
$TextBox1.location               = New-Object System.Drawing.Point(147,55)
$TextBox1.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Введите порт"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(155,112)
$Label2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBox2                        = New-Object system.Windows.Forms.TextBox
$TextBox2.multiline              = $false
$TextBox2.width                  = 100
$TextBox2.height                 = 20
$TextBox2.location               = New-Object System.Drawing.Point(147,144)
$TextBox2.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "Проверить"
$Button1.width                   = 111
$Button1.height                  = 33
$Button1.location                = New-Object System.Drawing.Point(143,202)
$Button1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)


$Form.controls.AddRange(@($Label1,$TextBox1,$Label2,$TextBox2,$Button1))

$Button1.Add_Click({ telnet })

#region Logic 
function telnet {
if ((Test-NetConnection -ComputerName $TextBox1.Text -Port $TextBox2.Text -InformationLevel Quiet))
{
$Text = "Порт открыт"
Write-Host $Text
[System.Windows.Forms.MessageBox]::Show("Сетевой доступ открыт", $Text, 0)
}
else
{
$Text2 = "Порт закрыт"
Write-Host $Text2
[System.Windows.Forms.MessageBox]::Show("Сетевой доступ закрыт", $Text, 0)
}
#pause
}
#endregion


[void]$Form.ShowDialog()