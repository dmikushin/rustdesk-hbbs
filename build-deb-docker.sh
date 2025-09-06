#!/bin/bash
set -e

echo "Building RustDesk HBBS deb package using Docker..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed. Please install Docker first."
    exit 1
fi

# Build the Docker image
echo "Building Docker image..."
docker build -f Dockerfile.deb-builder -t rustdesk-hbbs-deb-builder .

# Create output directory
mkdir -p deb-output

# Run the build in container
echo "Building deb package in container..."
docker run --rm \
    -v "$(pwd)/deb-output:/output" \
    -v "$(pwd):/build" \
    -w /build \
    rustdesk-hbbs-deb-builder \
    bash -c "dpkg-buildpackage -b -uc -us -d && cp ../*.deb /output/"

echo "Build completed!"
echo "Package files:"
ls -la deb-output/*.deb

echo ""
echo "To install the package on a Debian/Ubuntu system:"
echo "  sudo dpkg -i deb-output/rustdesk-hbbs_*.deb"
echo ""
echo "Or with apt to handle dependencies:"
echo "  sudo apt install ./deb-output/rustdesk-hbbs_*.deb"