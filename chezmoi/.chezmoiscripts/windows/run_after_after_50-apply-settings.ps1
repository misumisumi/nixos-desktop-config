Write-Host "Start to apply settings..."

$setting="$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$tmp_setting="$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.tmp.json"
$user_setting="$env:USERPROFILE\.config\windows-terminal\settings.json"

Write-Host "Apply windows terminal setting"
if((Test-Path $setting) -eq "True" -and (Test-Path $user_setting) -eq "True"){
    if ((Test-Path $tmp_setting) -eq "True"){
        Remove-Item $tmp_setting
    }
    Move-Item $setting $tmp_setting
# need to set encoding to ascii for Japanese
    jq -a -s '.[0] * .[1]' $tmp_setting $user_setting | Out-File -FilePath $setting -Encoding ascii
    Remove-Item $tmp_setting
}

Write-Host "Apply vivaldi setting"
$vivaldi_dir="$env:USERPROFILE\AppData\Local\Vivaldi\User Data"
$vivaldi_common_pref = "$env:USERPROFILE\.config\vivaldi\CommonPreferences"
if ((Test-Path $vivaldi_dir) -eq "True") {
    # find profile named "Default" or "Profile *"
    $profile_dirs = Get-ChildItem -Path $vivaldi_dir -Directory | Where-Object { $_.Name -match '^Profile \d+$' -or $_.Name -eq 'Default' }
    # for each profile, merge CommonPreferences to existing Preferences
    foreach ($profile_dir in $profile_dirs) {
        $preferences_file = Join-Path $profile_dir.FullName 'Preferences'
        if (Test-Path $preferences_file) {
            if (Test-Path $vivaldi_common_pref) {
                Move-Item $preferences_file "$preferences_file.bak" -Force
                jq -a -s '.[0] * .[1]' $preferences_file.bak $vivaldi_common_pref | Out-File -FilePath ($preferences_file + ".new") -Encoding ascii
                if (Get-Content -Path ($preferences_file + ".new") -Encoding ascii) {
                    Move-Item ($preferences_file + ".new") $preferences_file -Force
                }
            } else {
                Write-Host "CommonPreferences not found: $vivaldi_common_pref"
            }
        } else {
            Write-Host "Preferences file not found: $preferences_file"
        }
    }
}

Write-Host "Finish!"
