Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Función para actualizar el ListBox
function Update-FileList {
    $listBox.Items.Clear() # Limpia el ListBox antes de actualizar
    $files = Get-ChildItem -Path "C:\Temp" -File
    foreach ($file in $files) {
        $listBox.Items.Add($file.Name)
    }
}

# Crea el formulario
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Files in folder'
$form.Size = New-object System.Drawing.Size @(960,400)
$form.StartPosition = 'CenterScreen'

# Crea el ListBox
$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Size = New-Object System.Drawing.Size(920,300)
$listBox.Location = New-Object System.Drawing.Point(10,10)
$form.Controls.Add($listBox)

# Crea un temporizador
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 5000 # Intervalo de tiempo (5 segundos)
$timer.add_Tick({
    Update-FileList
})
$timer.Start()

# Inicializa la lista por primera vez
Update-FileList

# Muestra el formulario
$form.ShowDialog()