#!/bin/sh

# Script to pull required Ollama models for finance and document processing
# This runs automatically when docker-compose starts

echo "========================================"
echo "Pulling Ollama models for finance and document processing..."
echo "========================================"

# Wait for Ollama server to be fully ready
echo "Waiting for Ollama server to be ready..."
sleep 5

# Set the Ollama host
export OLLAMA_HOST=ollama:11434

# Pull llama3.2-vision for document/image processing
echo ""
echo "Pulling llama3.2-vision (11B) - for document and image processing..."
ollama pull llama3.2-vision || echo "Warning: Failed to pull llama3.2-vision"

# Pull llama3.1 for text-based extraction and financial analysis
echo ""
echo "Pulling llama3.1 (8B) - for text extraction and financial analysis..."
ollama pull llama3.1 || echo "Warning: Failed to pull llama3.1"

# Pull mistral as a lighter alternative
echo ""
echo "Pulling mistral (7B) - lighter alternative with good performance..."
ollama pull mistral || echo "Warning: Failed to pull mistral"

# Pull phi3.5 for fast extractions
echo ""
echo "Pulling phi3.5 (3.8B) - fast option for quick extractions..."
ollama pull phi3.5 || echo "Warning: Failed to pull phi3.5"

echo ""
echo "========================================"
echo "Model installation complete!"
echo "========================================"
echo ""
echo "Available models:"
ollama list

echo ""
echo "Note: Large models may take several minutes to download."
echo "You can check progress with: docker-compose logs -f ollama-setup"
