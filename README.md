# RustDesk HBBS (Static Build)

This is a stripped-down version of RustDesk HBBS configured for static compilation.

## About

HBBS (RustDesk ID/Rendezvous Server) is responsible for:
- User registration and authentication
- Connection establishment between RustDesk clients
- Runs on port 21116 by default

## Building

### Linux (using musl for static linking)
```bash
# Install musl target
rustup target add x86_64-unknown-linux-musl

# Build static binary
cargo build --release --target x86_64-unknown-linux-musl
```

### Windows
```bash
# For MinGW
cargo build --release --target x86_64-pc-windows-gnu

# For MSVC
cargo build --release --target x86_64-pc-windows-msvc
```

### macOS
```bash
cargo build --release
```

The compiled binary will be in `target/<target>/release/hbbs`

## Usage

```bash
./hbbs -h
```

Common options:
- `-p, --port <PORT>`: Listen on port (default: 21116)
- `-k, --key <KEY>`: Key for encryption
- `--mask <MASK>`: Network mask for allowed IPs

## Systemd Service

A systemd service file is included in `systemd/rustdesk-hbbs.service`. To install:

```bash
sudo cp systemd/rustdesk-hbbs.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable rustdesk-hbbs
sudo systemctl start rustdesk-hbbs
```

## Configuration

The server creates a `db_v2.sqlite3` database file in the working directory to store:
- User registrations
- Connection logs
- Server configuration

## License

Licensed under the same terms as the original RustDesk project.


