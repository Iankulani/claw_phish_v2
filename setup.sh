#!/bin/bash
# CLAW_PHISH_v2 Installer for Linux/Mac

set -e

echo "================================================"
echo " 🐾 CLAW_PHISH_v2 v2.0.0 - Installer"
echo "================================================"
echo

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Check Python
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}[ERROR] Python3 is not installed${NC}"
    exit 1
fi

# Check Python version
PYTHON_VERSION=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
if [ "$(printf '%s\n' "3.9" "$PYTHON_VERSION" | sort -V | head -n1)" != "3.9" ]; then
    echo -e "${RED}[ERROR] Python 3.9 or higher is required. Found: $PYTHON_VERSION${NC}"
    exit 1
fi

echo -e "${GREEN}[OK] Python $PYTHON_VERSION detected${NC}"

# Check for required system tools
echo "Checking system requirements..."
for tool in pip3 git; do
    if ! command -v $tool &> /dev/null; then
        echo -e "${YELLOW}[WARN] $tool not found. Installing...${NC}"
        if command -v apt-get &> /dev/null; then
            sudo apt-get update && sudo apt-get install -y $tool python3-pip
        elif command -v yum &> /dev/null; then
            sudo yum install -y $tool python3-pip
        elif command -v brew &> /dev/null; then
            brew install $tool
        else
            echo -e "${RED}[ERROR] Cannot install $tool automatically. Please install manually.${NC}"
        fi
    fi
done

# Create virtual environment
echo "Creating virtual environment..."
python3 -m venv venv
source venv/bin/activate

# Upgrade pip
echo "Upgrading pip..."
pip install --upgrade pip

# Install requirements
echo "Installing requirements..."
pip install -r requirements.txt
if [ $? -ne 0 ]; then
    echo -e "${RED}[ERROR] Failed to install requirements${NC}"
    exit 1
fi

# Create directories
echo "Creating directories..."
mkdir -p .claw_phish_v2 config logs reports

# Create default config
echo "Creating default configuration..."
if [ ! -f config/config.json ]; then
    cp config/config.example.json config/config.json
fi

# Set executable permissions
chmod +x scripts/*.sh

echo
echo -e "${GREEN}================================================"
echo " ✅ Installation Complete!"
echo "================================================${NC}"
echo
echo "To run CLAW_PHISH_v2:"
echo "   1. Activate environment: source venv/bin/activate"
echo "   2. Run: python src/main.py"
echo
echo "Or use the launcher: ./run.sh"
echo