# Zed

```bash
./script/linux
./script/install-mold 2.34.0
echo "nightly" > crates/zed/RELEASE_CHANNEL
./script/bundle-linux
```

```bash
git config --system core.longpaths true

sudo apt-get update
sudo apt-get install -y wget software-properties-common

sudo apt-get update
sudo apt-get install -y mingw-w64 powershell

sudo apt-get update
sudo apt-get install -y mingw-w64

rustup target add x86_64-pc-windows-gnu

cargo build --target x86_64-pc-windows-gnu --release --package zed --package cli

pwsh script/bundle-windows.ps1

export CC_x86_64_pc_windows_gnu=x86_64-w64-mingw32-gcc
export CXX_x86_64_pc_windows_gnu=x86_64-w64-mingw32-g++

echo 'export CC_x86_64_pc_windows_gnu=x86_64-w64-mingw32-gcc' >> ~/.bashrc
echo 'export CXX_x86_64_pc_windows_gnu=x86_64-w64-mingw32-g++' >> ~/.bashrc
source ~/.bashrc

echo "nightly" > crates/zed/RELEASE_CHANNEL

cargo install cargo-about

cargo build --target x86_64-pc-windows-gnu --release --package zed --package cli

sudo apt-get update
sudo apt-get install -y spirv-tools

wget https://github.com/microsoft/DirectXShaderCompiler/releases/download/v1.7.2212/dxc_2022_12_08.zip
unzip dxc_2022_12_08.zip -d dxc
export PATH=$PATH:/workspace/code/dxc/bin
```

[![Zed](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/zed-industries/zed/main/assets/badge/v0.json)](https://zed.dev)
[![CI](https://github.com/zed-industries/zed/actions/workflows/ci.yml/badge.svg)](https://github.com/zed-industries/zed/actions/workflows/ci.yml)

Welcome to Zed, a high-performance, multiplayer code editor from the creators of [Atom](https://github.com/atom/atom) and [Tree-sitter](https://github.com/tree-sitter/tree-sitter).

---

### Installation

On macOS and Linux you can [download Zed directly](https://zed.dev/download) or [install Zed via your local package manager](https://zed.dev/docs/linux#installing-via-a-package-manager).

Other platforms are not yet available:

- Windows ([tracking issue](https://github.com/zed-industries/zed/issues/5394))
- Web ([tracking issue](https://github.com/zed-industries/zed/issues/5396))

### Developing Zed

- [Building Zed for macOS](./docs/src/development/macos.md)
- [Building Zed for Linux](./docs/src/development/linux.md)
- [Building Zed for Windows](./docs/src/development/windows.md)
- [Running Collaboration Locally](./docs/src/development/local-collaboration.md)

### Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for ways you can contribute to Zed.

Also... we're hiring! Check out our [jobs](https://zed.dev/jobs) page for open roles.

### Licensing

License information for third party dependencies must be correctly provided for CI to pass.

We use [`cargo-about`](https://github.com/EmbarkStudios/cargo-about) to automatically comply with open source licenses. If CI is failing, check the following:

- Is it showing a `no license specified` error for a crate you've created? If so, add `publish = false` under `[package]` in your crate's Cargo.toml.
- Is the error `failed to satisfy license requirements` for a dependency? If so, first determine what license the project has and whether this system is sufficient to comply with this license's requirements. If you're unsure, ask a lawyer. Once you've verified that this system is acceptable add the license's SPDX identifier to the `accepted` array in `script/licenses/zed-licenses.toml`.
- Is `cargo-about` unable to find the license for a dependency? If so, add a clarification field at the end of `script/licenses/zed-licenses.toml`, as specified in the [cargo-about book](https://embarkstudios.github.io/cargo-about/cli/generate/config.html#crate-configuration).
