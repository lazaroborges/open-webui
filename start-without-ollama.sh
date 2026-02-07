#!/bin/bash

# Quick start script for Open WebUI without Ollama
# This script helps you set up Open WebUI with Claude/Gemini APIs

set -e

echo "🚀 Open WebUI Setup Without Ollama"
echo "===================================="
echo ""

# Check if .env file exists
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    cp .env.example.no-ollama .env
    echo "✅ Created .env file"
    echo ""
    echo "⚠️  IMPORTANT: Please edit .env file and add your API keys:"
    echo "   - OPENAI_API_KEY (for Claude/Anthropic)"
    echo "   - GEMINI_API_KEY (for Gemini)"
    echo ""
    read -p "Press Enter after you've added your API keys to .env..."
fi

# Check if API keys are set
source .env 2>/dev/null || true

if [ -z "$OPENAI_API_KEY" ] && [ -z "$GEMINI_API_KEY" ]; then
    echo "⚠️  WARNING: No API keys found in .env file"
    echo "   Please set at least one of:"
    echo "   - OPENAI_API_KEY (for Claude/Anthropic)"
    echo "   - GEMINI_API_KEY (for Gemini)"
    echo ""
    read -p "Press Enter to continue anyway, or Ctrl+C to exit..."
fi

# Generate secret key if not set
if [ -z "$WEBUI_SECRET_KEY" ]; then
    echo "🔑 Generating random secret key..."
    SECRET_KEY=$(openssl rand -hex 32)
    echo "WEBUI_SECRET_KEY=$SECRET_KEY" >> .env
    echo "✅ Secret key generated and added to .env"
fi

# Ensure ENABLE_OLLAMA_API is False
if ! grep -q "ENABLE_OLLAMA_API=False" .env 2>/dev/null; then
    echo "ENABLE_OLLAMA_API=False" >> .env
fi

echo ""
echo "🐳 Starting Open WebUI with Docker Compose..."
echo ""

# Start the services
docker-compose -f docker-compose.no-ollama.yaml up -d

echo ""
echo "✅ Open WebUI is starting!"
echo ""
echo "📋 Next steps:"
echo "   1. Wait a few seconds for the container to start"
echo "   2. Open http://localhost:3000 in your browser"
echo "   3. Create an admin account on first launch"
echo "   4. Go to Settings → Connections to verify your models"
echo ""
echo "📊 To view logs:"
echo "   docker-compose -f docker-compose.no-ollama.yaml logs -f open-webui"
echo ""
echo "🛑 To stop:"
echo "   docker-compose -f docker-compose.no-ollama.yaml down"
echo ""
