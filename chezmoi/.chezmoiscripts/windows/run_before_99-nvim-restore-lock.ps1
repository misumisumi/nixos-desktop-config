# lazy-lock.jsonは上流のものを常に尊重する
# $env:XDG_CONFIG_HOMEがあるか確認
$FNAME=Split-Path -Path $MyInvocation.MyCommand.Path -Leaf
function Logging($1) {
    Write-Output "${FNAME}: $1"
}
Logging "Start"

if ($env:XDG_CONFIG_HOME -eq $null) {
    $nvimDir = "$env:USERPROFILE\.config\nvim"
    if (-Not (Test-Path $nvimDir)) {
        $nvimDir = "$env:LOCALAPPDATA\nvim"
    }
} else {
    $nvimDir = "$env:XDG_CONFIG_HOME\nvim"
}

if (Test-Path $nvimDir) {
    Set-Location $nvimDir
    if (Test-Path ".\lazy-lock.json") {
        git restore lazy-lock.json
    }
    if (Test-Path ".\mason-lock.json") {
        git restore mason-lock.json
    }
}

Logging "Finish"
