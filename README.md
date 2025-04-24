# 347OS

This is my setup for managing my computing life with Nix

## Features

- Modules for system configuration for both NixOS or macOS via nix-darwin
- Modules for portable userspace configuration via Home-Manager, including standalone
- Host Configurations:
  - Amber - Personal Workstation
  - Athena - Personal Laptop

## Usage

### Linux

```bash
# Selects the appropriate config by hostname
# Can optionally append #<HOSTNAME> to specify a specific host definition
sudo nixos-rebuild switch --flake "$FLAKE_DIR"
```

### Mac

```bash
# Selects the appropriate config by hostname
# Can optionally append #<HOSTNAME> to specify a specific host definition
darwin-rebuild switch --flake "$FLAKE_DIR"
```

### Generic Unix

```bash
# Portable Userspace for user 'katie'
home-manager switch --flake "$FLAKE_DIR"
```
