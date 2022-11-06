

function Get-Ast {
    param (
        [string]$FolderName
    )
    Get-ChildItem "..\mpsd\$FolderName" | 
    Foreach-Object {
        $code = Get-Content $_.FullName -Raw
        $fileName = $_.Name
    

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
        # $text = @{
        #     Name       = 'Code'
        #     Expression = { $_.Extent.Text }
        # }

        $astObjects = $ast.FindAll($predicate, $recurse)

        $astObjects | Select-Object -Property $position, $type | ConvertTo-Csv | Out-File ..\ast\$FolderName\$fileName.csv
    }
}

Get-Ast -FolderName mixed_malicious