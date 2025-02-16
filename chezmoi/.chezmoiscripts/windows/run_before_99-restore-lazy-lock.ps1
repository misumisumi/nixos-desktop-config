# lazy-lock.jsonは上流のものを常に尊重する
# $env:XDG_CONFIG_HOMEがあるか確認
if($env:XDG_CONFIG_HOME -eq $null){
    $nvimDir = "$env:USERPROFILE\.config\nvim"
    if((Test-Path $nvimDir) -eq "False"){
        $nvimDir = "$env:LOCALAPPDATA\nvim"
    }
}else{
    $nvimDir = "$env:XDG_CONFIG_HOME\nvim"
}

if((Test-Path $nvimDir) -eq "True"){
    Set-Location $nvimDir
    git restore lazy-lock.json
}
