# Ollama Docker Setup

This directory contains a Docker Compose configuration for running Ollama server with automatic restart capabilities.

## Prerequisites

- Docker installed on your system
- Docker Compose installed (usually comes with Docker Desktop)

## Quick Start

### Starting the Ollama Server

```bash
docker-compose up -d
```

This will:
- Pull the latest Ollama image if not already present
- Start the Ollama server in detached mode
- Automatically download recommended models for finance and document processing (llama3.2-vision, llama3.1, mistral, phi3.5)
- Automatically restart the container if it stops or when the system restarts

**Note:** The first startup will take longer as it downloads the models (several GB total). You can monitor the progress with:

```bash
docker-compose logs -f ollama-setup
```

### Stopping the Server

```bash
docker-compose down
```

### Viewing Logs

```bash
docker-compose logs -f ollama
```

## Configuration Details

### Restart Policy

The service is configured with `restart: unless-stopped`, which means:
- The container will automatically restart if it crashes
- The container will restart when the Docker daemon starts (e.g., system reboot)
- The container will NOT restart if you manually stop it with `docker-compose down` or `docker stop`

### Port Mapping

- The Ollama API is accessible at `http://localhost:11434`

### Data Persistence

- Models and data are stored in a Docker volume named `ollama_data`
- This ensures your downloaded models persist across container restarts

### Health Check

The container includes a health check that:
- Runs `ollama list` every 30 seconds
- Helps Docker monitor the service health
- Can trigger restarts if the service becomes unhealthy

## Using Ollama

### Recommended Models for Finance & Document Processing

For financial analysis and document/HTML data extraction, here are the recommended models:

#### Best Options

**llama3.2-vision** (11B or 90B)
- Supports vision capabilities for processing document images
- Excellent for extracting data from financial tables and screenshots
- Can understand complex document layouts

**llama3.1** (8B or 70B)
- Strong text understanding and structured output generation
- Great for parsing HTML and extracting financial data
- Handles complex reasoning for financial analysis

**mistral** (7B) or **mixtral** (8x7B)
- Efficient performance with good reasoning capabilities
- Suitable for financial terminology and data extraction
- Good balance of speed and accuracy

**phi3.5** (3.8B)
- Smaller, faster model for quick extractions
- Surprisingly effective at structured data extraction
- Lower resource requirements

#### Installation Commands

```bash
# For document/image processing (recommended for HTML/PDF screenshots)
docker exec -it ollama ollama pull llama3.2-vision

# For text-based extraction and financial analysis
docker exec -it ollama ollama pull llama3.1

# Lighter alternative with good performance
docker exec -it ollama ollama pull mistral

# Fastest option for quick extractions
docker exec -it ollama ollama pull phi3.5
```

**Recommended Setup:** Start with `llama3.2-vision` (if processing document images) and `llama3.1` (for text/HTML parsing).

**Note on Model Sizes:** Begin with smaller variants (8B, 7B) to test performance. Upgrade to larger models (70B, 90B) if you need better accuracy and have sufficient system resources.

### Download a Model

```bash
docker exec -it ollama ollama pull llama2
```

### List Available Models

```bash
docker exec -it ollama ollama list
```

### Run a Model Interactively

```bash
docker exec -it ollama ollama run llama2
```

### Using the API

You can interact with Ollama via HTTP API:

```bash
curl http://localhost:11434/api/generate -d '{
  "model": "llama2",
  "prompt": "Why is the sky blue?"
}'
```

#### Example: Extract Financial Data

```bash
curl http://localhost:11434/api/generate -d '{
  "model": "llama3.1",
  "prompt": "Extract the revenue, profit, and growth rate from this text: Q3 2024 revenue was $5.2M, up 15% YoY. Net profit: $1.1M.",
  "stream": false
}'
```

## Troubleshooting

### Check Container Status

```bash
docker-compose ps
```

### View Container Logs

```bash
docker-compose logs ollama
```

### Restart the Service

```bash
docker-compose restart
```

### Remove Everything (including volumes)

```bash
docker-compose down -v
```

**Warning:** This will delete all downloaded models!

## Additional Information

- Official Ollama Documentation: https://github.com/ollama/ollama
- Ollama Model Library: https://ollama.ai/library
