# PC-Free — Experimental Windows 10 in GitHub Codespaces

This fork contains an experimental attempt to run Windows 10 in a GitHub Codespace using Docker and [dockur/windows](https://github.com/dockur/windows).

> [!WARNING]
> This is **not** a guaranteed free Windows cloud PC. Codespaces is a Linux development environment, not a dedicated Windows VM. If KVM hardware acceleration is unavailable, Windows must use software emulation and may be extremely slow or unusable. Codespaces compute, storage, and usage quotas may also incur charges after included allowances.

## Start here

**Follow the mobile-friendly setup guide: [CODESPACES.md](CODESPACES.md).**

The guide explains how to create a Codespace from the `windows-cloud` branch, start Windows, open the private browser viewer on port 8006, and stop the container without deleting its data.

## What this branch adds

- `compose.yml` — conservative Windows 10 container configuration (4 GB RAM, 2 virtual CPU cores).
- `compose.kvm.yml` — optional KVM acceleration when `/dev/kvm` is accessible.
- `scripts/start-windows.sh` — checks Docker, creates a random local password, detects KVM, and starts the container.
- `scripts/stop-windows.sh` — stops Windows while preserving its data volume.
- `.env.example` — example settings only; never put real passwords in Git.
- `.gitignore` — excludes the local `.env` file and Windows data from commits.

## Security

- Keep Codespaces port **8006 Private**. Do not make it public.
- The setup does not publish RDP port 3389.
- The startup script generates a random password in the ignored local `.env` file.
- Never commit or share `.env` or its password.

## Upstream projects

- [Original PC-Free repository](https://github.com/jephersonRD/PC-Free)
- [dockur/windows](https://github.com/dockur/windows)
- [GitHub Codespaces documentation](https://docs.github.com/en/codespaces)

Windows is Microsoft's software. Use a valid license where required. This repository does not provide a Windows license.
