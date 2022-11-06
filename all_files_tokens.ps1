function Get-Token {
    param ( 
        [string] $folderName
    )

    Get-ChildItem "..\mpsd\$folderName" | 
    Foreach-Object {
        $text = Get-Content $_.FullName -Raw
        $fileName = $_.Name

        $errors = $null

        [System.Management.Automation.PSParser]::Tokenize($text, [ref]$errors) | ConvertTo-Csv | Out-File ..\tokens\$folderName\$fileName.csv
    }
}

Get-Token -folderName mixed_malicious
Get-Token -folderName malicious_pure
Get-Token -folderName powershell_benign_dataset