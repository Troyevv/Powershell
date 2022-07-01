Set-ExecutionPolicy -Scope CurrentUser
# Импорт модуля Active Directory в сессию PowerShell
import-module activedirectory
# Сначала откройте книгу Excel:
$ExcelObj = New-Object -comobject Excel.Application
$ExcelWorkBook = $ExcelObj.Workbooks.Open("C:\Users\AAleAleksandrov\Desktop\Копия WIFI_Regions.xlsx")
$ExcelWorkSheet = $ExcelWorkBook.Sheets.Item("WIFI_Regions")
# Получаем количество заполненных строк в xlsx файле
$rowcount=$ExcelWorkSheet.UsedRange.Rows.Count
# Перебираем все строки в столбце 1, начиная со второй строки (в этих ячейках указано доменное имя пользователя)
for($i=2;$i -le $rowcount;$i++){
$ADusername=$ExcelWorkSheet.Columns.Item(3).Rows.Item($i).Text
# Получаем значение атрибутов пользователя в AD
$ADuserProp = Get-ADUser $ADusername -properties title,department|select-object title, department
#Заполняем ячейки данными из AD
$ExcelWorkSheet.Columns.Item(4).Rows.Item($i) = $ADuserProp.title
$ExcelWorkSheet.Columns.Item(5).Rows.Item($i) = $ADuserProp.department
}
#Сохраните xls файл и закройте Excel
$ExcelWorkBook.Save()
$ExcelWorkBook.close($true)