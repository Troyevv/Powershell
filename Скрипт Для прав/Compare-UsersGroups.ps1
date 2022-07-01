Import-Module ActiveDirectory

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(600,600)
$Form.text                       = "Сравнение доступов"
$Form.TopMost                    = $true

$LabelUser1                   = New-Object system.Windows.Forms.Label
$LabelUser1.text              = "Логин 1:"
$LabelUser1.AutoSize          = $true
$LabelUser1.width             = 64
$LabelUser1.height            = 10
$LabelUser1.location          = New-Object System.Drawing.Point(80,93)
$LabelUser1.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBoxUser1                    = New-Object system.Windows.Forms.TextBox
$TextBoxUser1.multiline          = $false
$TextBoxUser1.width              = 150
$TextBoxUser1.height             = 20
$TextBoxUser1.location           = New-Object System.Drawing.Point(145,91)
$TextBoxUser1.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$LabelUser2                   = New-Object system.Windows.Forms.Label
$LabelUser2.text              = "Логин 2:"
$LabelUser2.AutoSize          = $true
$LabelUser2.width             = 64
$LabelUser2.height            = 10
$LabelUser2.location          = New-Object System.Drawing.Point(300,93)
$LabelUser2.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBoxUser2                    = New-Object system.Windows.Forms.TextBox
$TextBoxUser2.multiline          = $false
$TextBoxUser2.width              = 150
$TextBoxUser2.height             = 20
$TextBoxUser2.location           = New-Object System.Drawing.Point(365,91)
$TextBoxUser2.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)


$CheckBoxIncludeEqual                      = New-Object System.Windows.Forms.CheckBox
$CheckBoxIncludeEqual.AutoSize             = $true
$CheckBoxIncludeEqual.Anchor               = 'Top,Left'
$CheckBoxIncludeEqual.location             = New-Object System.Drawing.Point(135,120)
$CheckBoxIncludeEqual.Text                 = "Включить одинаковые"

$CheckBoxExcludeDifferent                  = New-Object System.Windows.Forms.CheckBox
$CheckBoxExcludeDifferent.AutoSize         = $true
$CheckBoxExcludeDifferent.Anchor           = 'Top,Left'
$CheckBoxExcludeDifferent.location         = New-Object System.Drawing.Point(135,145)
$CheckBoxExcludeDifferent.Text             = "Исключить разные"

$ButtonCompare              = New-Object system.Windows.Forms.Button
$ButtonCompare.text         = "Сравнить"
$ButtonCompare.width        = 149
$ButtonCompare.height       = 30
$ButtonCompare.location     = New-Object System.Drawing.Point(135,165)
$ButtonCompare.Font         = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ListBoxResult                      = New-Object System.Windows.Forms.ListBox
$ListBoxResult.width                = 450
$ListBoxResult.height               = 360
$ListBoxResult.Anchor               = 'Top,Left,Right'
$ListBoxResult.location             = New-Object System.Drawing.Point(135,200)

$ButtonExit                      = New-Object system.Windows.Forms.Button
$ButtonExit.text                 = "Выход"
$ButtonExit.width                = 149
$ButtonExit.height               = 30
$ButtonExit.location             = New-Object System.Drawing.Point(135,565)
$ButtonExit.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Form.controls.AddRange(@($LabelUser1,$TextBoxUser1,$LabelUser2,$TextBoxUser2,$CheckBoxIncludeEqual,$CheckBoxExcludeDifferent,$ButtonCompare,$ListBoxResult,$ButtonExit))

$ButtonCompare.Add_Click({ ButtonCompareClick })
$ButtonExit.Add_Click({ ButtonExitClick })
#$ComboBoxCity.Add_SelectedIndexChanged({ addValueToCheckBoxIncludeEqual })

function CleanForm {
    $ListBoxResult.Items.Clear()
}

function addValueToListBoxResult($array) {
    $ListBoxResult.Items.Clear()
    $array | ForEach-Object { $ListBoxResult.Items.Add($_.InputObject + "`t`t" + $_.SideIndicator) }
}

function ButtonCompareClick {
    try
    {
        if ($CheckBoxIncludeEqual.Checked) {$SuffixIncludeEcual = " -IncludeEqual"} else {$SuffixIncludeEcual = ""}
        if ($CheckBoxExcludeDifferent.Checked) {$SuffixExcludeDifferent = " -ExcludeDifferent"} else {$SuffixExcludeDifferent = ""}
        $a = (Get-ADPrincipalGroupMembership -Identity $TextBoxUser1.Text).SamAccountName | sort
        $b = (Get-ADPrincipalGroupMembership -Identity $TextBoxUser2.Text).SamAccountName | sort
        $command = 'Compare-Object -ReferenceObject $a -DifferenceObject $b' + "$SuffixIncludeEcual $SuffixExcludeDifferent"
        $Difference = Invoke-Expression $command
        #$Difference = (Compare-Object -ReferenceObject $a -DifferenceObject $b | ? {$_.SideIndicator -eq "<="}).InputObject
        $ListBoxResult.Text = addValueToListBoxResult($Difference)
    }
    catch
    {
        [system.windows.forms.messagebox]::show("Неверный логин", "Предупреждение") 
    }
}

function ButtonExitClick {$Form.Close()}


[void]$Form.ShowDialog()