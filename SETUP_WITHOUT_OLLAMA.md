# Setting Up Open WebUI Without Ollama

This guide will help you set up Open WebUI to use external APIs (Claude/Anthropic and Gemini) without requiring Ollama.

## Quick Start Options

### Option 1: Using Docker (Recommended)

Create a `.env` file in the project root with your API keys:

```bash
# Disable Ollama
ENABLE_OLLAMA_API=False

# Claude/Anthropic API Configuration
OPENAI_API_BASE_URL=https://api.anthropic.com/v1
OPENAI_API_KEY=sk-ant-your-anthropic-api-key-here

# Gemini API Configuration
GEMINI_API_KEY=your-gemini-api-key-here
GEMINI_API_BASE_URL=https://generativelanguage.googleapis.com/v1beta

# Optional: Disable signup for security
ENABLE_SIGNUP=True

# WebUI Configuration
WEBUI_SECRET_KEY=your-secret-key-here
```

Then run:
```bash
docker-compose -f docker-compose.no-ollama.yaml up -d
```

### Option 2: Using Python pip

1. Install Open WebUI:
```bash
pip install open-webui
```

2. Set environment variables:
```bash
export ENABLE_OLLAMA_API=False
export OPENAI_API_BASE_URL=https://api.anthropic.com/v1
export OPENAI_API_KEY=sk-ant-your-anthropic-api-key-here
export GEMINI_API_KEY=your-gemini-api-key-here
export GEMINI_API_BASE_URL=https://generativelanguage.googleapis.com/v1beta
```

3. Run Open WebUI:
```bash
open-webui serve
```

## API Configuration Details

### Claude/Anthropic API Setup

Anthropic provides an OpenAI-compatible API endpoint. Configure it as follows:

**Environment Variables:**
- `OPENAI_API_BASE_URL=https://api.anthropic.com/v1`
- `OPENAI_API_KEY=sk-ant-your-api-key-here`

**Getting Your Anthropic API Key:**
1. Go to https://console.anthropic.com/settings/keys
2. Create a new API key
3. Copy the key (starts with `sk-ant-`)

**Supported Models:**
- `claude-3-5-sonnet-20241022`
- `claude-3-5-haiku-20241022`
- `claude-3-opus-20240229`
- `claude-3-sonnet-20240229`
- `claude-3-haiku-20240307`

### Gemini API Setup

Google Gemini has direct support in Open WebUI:

**Environment Variables:**
- `GEMINI_API_KEY=your-gemini-api-key-here`
- `GEMINI_API_BASE_URL=https://generativelanguage.googleapis.com/v1beta` (optional, this is the default)

**Getting Your Gemini API Key:**
1. Go to https://aistudio.google.com/app/apikey
2. Create a new API key
3. Copy the key

**Supported Models:**
- `gemini-pro`
- `gemini-pro-vision`
- `gemini-1.5-pro`
- `gemini-1.5-flash`

## After Setup

1. **Access the WebUI**: Navigate to http://localhost:3000 (or http://localhost:8080 if using pip)

2. **Create an Admin Account**: On first launch, you'll be prompted to create an admin account

3. **Add Models**: 
   - Go to Settings → Connections
   - The models should automatically appear if configured correctly
   - For Claude: Models will appear under "OpenAI" connections
   - For Gemini: Models will appear under "Gemini" connections

4. **Start Chatting**: Select a model and start chatting!

## Troubleshooting

### Models Not Appearing

1. **Check API Keys**: Ensure your API keys are correct and have proper permissions
2. **Check Environment Variables**: Verify all environment variables are set correctly
3. **Check Logs**: 
   ```bash
   docker-compose -f docker-compose.no-ollama.yaml logs open-webui
   ```

### Connection Errors

- Ensure `ENABLE_OLLAMA_API=False` is set to prevent connection attempts to Ollama
- Verify your API keys are valid and have billing enabled (for Anthropic, minimum $5)

### Using Multiple API Providers

You can configure multiple API endpoints by separating them with semicolons:

```bash
OPENAI_API_BASE_URLS=https://api.anthropic.com/v1;https://api.openai.com/v1
OPENAI_API_KEYS=sk-ant-your-anthropic-key;sk-your-openai-key
```

## Additional Configuration

### Disable Ollama Completely

Set in your `.env` file:
```bash
ENABLE_OLLAMA_API=False
```

### Security Settings

```bash
# Disable public signup (recommended for production)
ENABLE_SIGNUP=False

# Set a secret key for session encryption
WEBUI_SECRET_KEY=your-random-secret-key-here
```

### Custom Port

```bash
OPEN_WEBUI_PORT=8080
```

## Notes

- **Anthropic API**: Uses OpenAI-compatible endpoint, so it appears under "OpenAI" connections in the UI
- **Gemini API**: Has native support and appears under "Gemini" connections
- **No Local Models**: Without Ollama, you cannot run local models. All inference happens via external APIs
- **Costs**: Both APIs charge per token/request. Monitor your usage in their respective dashboards
