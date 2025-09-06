#!/bin/bash
set -e

echo "Building Debian package for RustDesk HBBS..."

# Check if we're on a Debian-based system
if ! command -v dpkg-buildpackage &> /dev/null; then
    echo "Error: dpkg-buildpackage not found. Please install build-essential and devscripts:"
    echo "  sudo apt-get install build-essential devscripts debhelper"
    exit 1
fi

# Clean previous builds
echo "Cleaning previous builds..."
rm -f ../rustdesk-hbbs_*.deb
rm -f ../rustdesk-hbbs_*.dsc
rm -f ../rustdesk-hbbs_*.tar.gz
rm -f ../rustdesk-hbbs_*.changes
rm -f ../rustdesk-hbbs_*.buildinfo

# Build the package
echo "Building package..."
dpkg-buildpackage -b -uc -us

echo "Build completed!"
echo "Package files created in parent directory:"
ls -la ../rustdesk-hbbs_*.deb

echo ""
echo "To install the package, run:"
echo "  sudo dpkg -i ../rustdesk-hbbs_*.deb"
echo ""
echo "Or with apt to handle dependencies:"
echo "  sudo apt install ../rustdesk-hbbs_*.deb"