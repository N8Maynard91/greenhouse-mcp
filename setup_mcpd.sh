#!/bin/bash

# Setup script for MCPD deployment of Greenhouse MCP Server

echo "🌱 Greenhouse MCP Server - MCPD Setup"
echo "======================================"
echo ""

# Check if MCPD is installed
if ! command -v mcpd &> /dev/null; then
    echo "❌ MCPD is not installed."
    echo "Please install it first: npm install -g @modelcontextprotocol/mcpd"
    exit 1
fi

# Check for API key
if [ -z "$GREENHOUSE_API_KEY" ]; then
    echo "⚠️  GREENHOUSE_API_KEY is not set in environment."
    echo "Please set it before running the server:"
    echo "  export GREENHOUSE_API_KEY='your_api_key_here'"
    echo ""
fi

# Add server to MCPD
echo "📦 Adding greenhouse-mcp to MCPD..."
mcpd add greenhouse-mcp

# Configure environment variables
echo "🔧 Configuring environment variables..."
if [ ! -z "$GREENHOUSE_API_KEY" ]; then
    mcpd config args set greenhouse-mcp --env GREENHOUSE_API_KEY="$GREENHOUSE_API_KEY"
    echo "✅ GREENHOUSE_API_KEY configured"
fi

# Optional: Set base URL if different from default
if [ ! -z "$GREENHOUSE_BASE_URL" ]; then
    mcpd config args set greenhouse-mcp --env GREENHOUSE_BASE_URL="$GREENHOUSE_BASE_URL"
    echo "✅ GREENHOUSE_BASE_URL configured"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "To start the MCPD daemon:"
echo "  mcpd daemon"
echo ""
echo "API documentation will be available at:"
echo "  http://localhost:8090/docs"
echo ""
echo "To use with Claude Desktop, add to your config:"
echo '  {
    "mcpServers": {
      "greenhouse": {
        "url": "http://localhost:8090/greenhouse-mcp"
      }
    }
  }'