# Self-elevate the script if required
$setting="$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$tmp_setting="$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.tmp.json"
$user_setting="$env:USERPROFILE\.config\windows-terminal\settings.json"

if((Test-Path $setting) -eq "True" -and (Test-Path $user_setting) -eq "True"){
  if ((Test-Path $tmp_setting) -eq "True"){
    rm $tmp_setting
  }
  mv $setting $tmp_setting
# need to set encoding to ascii for Japanese
  $PSDefaultParameterValues['Out-File:Encoding'] = 'ascii'
  jq -a -s '.[0] * .[1]' $tmp_setting $user_setting > $setting
  rm $tmp_setting
}
