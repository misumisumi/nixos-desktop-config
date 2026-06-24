$Env:COPILOT_PROVIDER_API_KEY = (Get-Content "$HOME\.env" -Raw | ConvertFrom-StringData).OPENCODE_API_KEY
$Env:COPILOT_PROVIDER_TYPE=openai
$Env:COPILOT_PROVIDER_BASE_URL=https://opencode.ai/zen/go/v1
$Env:COPILOT_MODEL=deepseek-v4-flash

copilot @args
