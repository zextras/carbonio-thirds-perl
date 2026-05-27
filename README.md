# Carbonio Perl

This repository contains build configurations for Perl third-party modules used by the Carbonio platform.

Packages are built with [YAP](https://github.com/M0Rf30/yap) inside container images.

## Quick Start

### Prerequisites

- Podman installed
- Make

### Building Packages

```bash
make build TARGET=ubuntu-jammy
make build TARGET=rocky-9
make help
```

### Supported Targets

- `ubuntu-jammy` - Ubuntu 22.04 LTS
- `ubuntu-noble` - Ubuntu 24.04 LTS
- `rocky-8` - Rocky Linux 8
- `rocky-9` - Rocky Linux 9
