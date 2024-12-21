# Import modules
Import-Module syntax-highlighting
Import-Module Terminal-Icons

#NOTE: reference: https://qiita.com/AWtnb/items/5551fcc762ed2ad92a81#%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E6%8B%AC%E5%BC%A7%E3%81%A7%E5%9B%B2%E3%82%80
Set-PSReadLineOption `
    -PredictionSource History ` # 予測変換の有効化
    -BellStyle None ` # ベルの無効化
    -HistoryNoDuplicates ` # 重複したコマンドは履歴に残さない
    -WordDelimiters ";:,.[]{}()/\|^&*-=+'`" !?@#`$%&_<>``「」（）『』『』［］、，。：；／　" `
    -AddToHistoryHandler { # 条件に一致するコマンドを履歴に残さない
    param ($command)
    switch -regex ($command) {
        "SKIPHISTORY" {return $false}
        "^dsk$" {return $false}
        " -execute" {return $false}
        " -force" {return $false}
    }
    return $true
}
# zsh like候補選択
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# smart close
Set-PSReadLineKeyHandler -Key "(","{","[" -BriefDescription "InsertPairedBraces" -LongDescription "Insert matching braces or wrap selection by matching braces" -ScriptBlock {
    param($key, $arg)
    $openChar = $key.KeyChar
    $closeChar = switch ($openChar) {
        <#case#> "(" { [char]")"; break }
        <#case#> "{" { [char]"}"; break }
        <#case#> "[" { [char]"]"; break }
    }

    $bs = [PSBufferState]::new()
    $line = $bs.CommandLine
    $pos = $bs.CursorPos

    if ($bs.SelectionLength -gt 0) {
        [PSConsoleReadLine]::Replace($bs.SelectionStart, $bs.selectionLength, $openChar + $line.SubString($bs.selectionStart, $bs.selectionLength) + $closeChar)
        [PSConsoleReadLine]::SetCursorPosition($bs.selectionStart + $bs.selectionLength + 2)
        return
    }

    $nOpen = [regex]::Matches($line, [regex]::Escape($openChar)).Count
    $nClose = [regex]::Matches($line, [regex]::Escape($closeChar)).Count
    if ($nOpen ne $nClose) {
        [PSConsoleReadLine]::Insert($openChar)
        return
    }
    [PSConsoleReadLine]::Insert($openChar + $closeChar)
    [PSConsoleReadLine]::SetCursorPosition($pos + 1)
}

Set-PSReadLineKeyHandler -Key ")","]","}" -BriefDescription "SmartCloseBraces" -LongDescription "Insert closing brace or skip" -ScriptBlock {
    param($key, $arg)

    $bs = [PSBufferState]::new()
    $line = $bs.CommandLine
    $pos = $bs.CursorPos

    if ($line[$pos] eq $key.KeyChar) {
        [PSConsoleReadLine]::SetCursorPosition($pos + 1)
    }
    else {
        [PSConsoleReadLine]::Insert($key.KeyChar)
    }
}

Set-PSReadLineKeyHandler -Key "`"","'" -BriefDescription "smartQuotation" -LongDescription "Put quotation marks and move the cursor between them or put marks around the selection" -ScriptBlock {
    param($key, $arg)
    $mark = $key.KeyChar

    $bs = [PSBufferState]::new()
    $line = $bs.CommandLine
    $pos = $bs.CursorPos

    if ($bs.SelectionLength -gt 0) {
        [PSConsoleReadLine]::Replace($bs.selectionStart, $bs.selectionLength, $mark + $line.SubString($bs.selectionStart, $bs.selectionLength) + $mark)
        [PSConsoleReadLine]::SetCursorPosition($bs.selectionStart + $bs.selectionLength + 2)
        return
    }

    if ($line[$pos] eq $mark) {
        [PSConsoleReadLine]::SetCursorPosition($pos + 1)
        return
    }

    $a = [ASTer]::new()
    $token = $a.GetActiveToken()
    if ( ($token.Kind eq "StringLiteral" -and $mark eq '"') -or ($token.Kind eq "StringExpandable" -and $mark eq "'") ) {
        [PSConsoleReadLine]::Insert($mark)
        return
    }

    [PSConsoleReadLine]::Insert($mark + $mark)
    [PSConsoleReadLine]::SetCursorPosition($pos+1)
}

# キーバインド
# Set-PSReadLineOption -EditMode vi
# vi modeの表示
# function OnViModeChange {
#     if ($args[0] eq 'Command') {
#         # Set the cursor to a blinking block.
#         Write-Host -NoNewLine "`e[1 q"
#     } else {
#         # Set the cursor to a blinking line.
#         Write-Host -NoNewLine "`e[5 q"
#     }
# }
# Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

# ctrl+dでpowershellを抜ける
Set-PSReadLineKeyHandler -Chord Ctrl+d -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert('exit')
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

# fzfの統合
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

{{ range $key, $value := .windows.env -}}
{{ if eq $key "PATH" -}}
$env:PATH = {{- $value | join ";" -}}; + $env:PATH
{{- else -}}
$env:${{- $key -}} = {{- $value | quote -}}
{{- end -}}
{{ end }}

$localrc = "$env:HOMEPATH/.profile.local.ps1"
if (Test-Path $localrc) {
  . $localrc
}

# WSLのコマンドをpowershellから呼び出す
# Import-WslCommand "apt", "awk", "emacs", "find", "grep", "head", "less", "ls", "man", "sed", "seq", "ssh", "sudo", "tail", "touch"

# starshipの有効化
Invoke-Expression (& '~/scoop/apps/starship/current/starship.exe' init powershell --print-full-init | Out-String)
