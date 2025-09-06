#!/bin/bash
set -e

echo "Building static HBBS binary..."

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Building for Linux with musl..."
    rustup target add x86_64-unknown-linux-musl 2>/dev/null || true
    cargo build --release --target x86_64-unknown-linux-musl
    echo "Binary location: target/x86_64-unknown-linux-musl/release/hbbs"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Building for macOS..."
    cargo build --release
    echo "Binary location: target/release/hbbs"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    echo "Building for Windows..."
    cargo build --release --target x86_64-pc-windows-gnu
    echo "Binary location: target/x86_64-pc-windows-gnu/release/hbbs.exe"
else
    echo "Unknown OS type: $OSTYPE"
    echo "Running standard cargo build..."
    cargo build --release
    echo "Binary location: target/release/hbbs"
fi

echo "Build completed!"