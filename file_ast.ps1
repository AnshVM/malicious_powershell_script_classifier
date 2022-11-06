
$code = Get-Content "../mpsd/powershell_benign_dataset/2.ps1" -Raw
    
$ast = [System.Management.Automation.Language.Parser]::ParseInput($code, [ref]$null, [ref]$null)

$predicate = { $true }

$recurse = $true

$type = @{
    Name       = 'Type'
    Expression = { $_.GetType().Name }
}

# expose the code position:
$position = @{
    Name       = 'Position'
    Expression = { '{0,3}-{1,-3}' -f $_.Extent.StartOffset, $_.Extent.EndOffset, $_.Extent.Text }
}

# expose the text of the code:
$text = @{
    Name       = 'Code'
    Expression = { $_.Extent.Text }
}

$astObjects = $ast.FindAll($predicate, $recurse)

$astObjects | Select-Object -Property $position, $type, $text | ConvertTo-Csv | Out-File output.csv