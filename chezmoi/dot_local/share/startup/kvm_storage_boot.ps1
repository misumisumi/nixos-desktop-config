# get a list of storage drivers as parameters

if ($args.Count -eq 0) {
    echo "Must indicate at least 1 storage driver name"
    exit 1
}

$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path C:\kvm-script.txt -append

$rootPath = "HKLM:\SYSTEM\ControlSet001\Services\"
$tailPath = "\StartOverride"

foreach ($p in $args) {
    echo ("Checking: "+$rootPath+$p+$tailPath)
    if (Test-Path ($rootPath+$p+$tailPath)) {
        echo ($rootPath+$p+$tailPath) "exists"
        Set-ItemProperty -Name "0" -Path ($rootPath+$p+$tailPath) -Value 0
    }
}

Stop-Transcript
