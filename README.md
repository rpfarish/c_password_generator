# Password Generator (pwg)

A cryptographically secure password generator which uses OpenSSL.

## Overview

`pwg` generates random passwords with customizable character exclusion. The generator uses OpenSSL's `RAND_bytes` function, which provides cryptographically secure random values from the system's entropy source. The implementation includes rejection sampling to ensure uniform distribution across the requested character range.

## Installation

### Prerequisites

- GCC compiler
- OpenSSL development libraries (`libssl-dev` on Debian/Ubuntu, `openssl-devel` on RHEL/Fedora)

**Runtime dependencies:**

- OpenSSL 3.x libraries (`libssl3` and `libcrypto3`)
  - Debian/Ubuntu: `sudo apt install libssl3`
  - RHEL/Fedora: `sudo dnf install openssl-libs`
  - Arch: `sudo pacman -S openssl`

Most Linux distributions include OpenSSL by default. You can verify with:

```bash
ldconfig -p | grep libssl
```

### Build from source

```bash
# Release build (optimized)
make

# Debug build (with sanitizers)
make debug

# Install to ~/.local/bin
make install
```

- Ensure `~/.local/bin` is in your `PATH` when using `make install`

### Build targets

- `make` or `make release` - Builds optimized binary in `release/`
- `make debug` - Builds debug binary with AddressSanitizer in `debug/`
- `make clean` - Removes build artifacts
- `make install` - Installs release binary to `~/.local/bin/`

## Usage

```bash
pwg [options]
```

### Options

| Option | Argument   | Description                         | Default  |
| ------ | ---------- | ----------------------------------- | -------- |
| `-l`   | `<length>` | Password length (must be > 0)       | 15       |
| `-e`   | `<chars>`  | Characters to exclude from password | none     |
| `-s`   | none       | Exclude symbols                     | included |
| `-u`   | none       | Exclude lowercase letters           | included |
| `-U`   | none       | Exclude uppercase letters           | included |
| `-n`   | none       | Exclude numbers                     | included |

### Character sets

By default, passwords include:

- **Lowercase letters**: `a-z`
- **Uppercase letters**: `A-Z`
- **Numbers**: `0-9`
- **Symbols**: `!@#$%^&*()[]{}-_=+'";:,.<>/?\|~`

## Examples

Generate a default 15-character password:

```bash
pwg
```

Generate a 20-character password:

```bash
pwg -l 20
```

Generate a password without symbols:

```bash
pwg -s
```

Generate a password with only lowercase letters and numbers:

```bash
pwg -U -s
```

Generate a 12-character password excluding specific characters:

```bash
pwg -l 12 -e "O0Il1"
```

Generate a PIN (numbers only):

```bash
pwg -l 6 -u -U -s
```

## License

MIT license.

## See also

- OpenSSL RAND_bytes documentation: https://www.openssl.org/docs/man3.0/man3/RAND_bytes.html
- OWASP Password Guidelines: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
