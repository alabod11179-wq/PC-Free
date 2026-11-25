# Run Windows 10 in a GitHub Codespace

This is an experimental setup, not a guaranteed free Windows VM. GitHub Codespaces is a Linux development environment, not a dedicated Windows hosting service. Availability, storage, runtime limits, and billing depend on your GitHub account and selected machine.

## 1. Create the Codespace

1. Open this repository on the `windows-cloud` branch.
2. Tap **Code** → **Codespaces** → **Create codespace on windows-cloud**.
3. Wait until the Codespace terminal is ready.
4. In the terminal, run:

```bash
bash scripts/start-windows.sh
```

The script checks Docker, creates a random Windows password in the ignored `.env` file, checks for accessible KVM, and starts Windows. It does not publish RDP port 3389.

## 2. Open Windows

1. In the Codespace, open the **Ports** tab.
2. Wait for port **8006** to appear.
3. Keep its visibility set to **Private**.
4. Tap the open-in-browser icon for port 8006.

The web viewer may ask for the password generated in `.env`. To display it in the terminal, run:

```bash
grep WINDOWS_PASSWORD .env
```

Do not share this password or make the forwarded port public.

## 3. Performance warning

The startup script uses KVM only when `/dev/kvm` is accessible. Otherwise it sets `KVM=N` and QEMU uses software emulation. This fallback can be extremely slow and may be impractical. Even when KVM exists, Codespaces resource limits can constrain performance.

The default allocation is 4 GB RAM and 2 virtual CPU cores. Do not increase these values unless your Codespace machine has enough memory and CPU available. The virtual Windows disk can consume substantial Codespace storage.

## 4. Useful commands

View logs:

```bash
docker compose --env-file .env logs -f windows
```

Show status:

```bash
docker compose --env-file .env ps
```

Stop Windows without deleting its data:

```bash
bash scripts/stop-windows.sh
```

Start it again:

```bash
bash scripts/start-windows.sh
```

To permanently delete the Windows disk and all files stored in it, use the destructive command below only if you are certain:

```bash
docker compose --env-file .env down -v
```

## Important

- GitHub may charge for Codespaces usage after included quotas are exhausted. Check your Codespaces usage and spending limit before leaving it running.
- Codespace storage and compute are not guaranteed to be persistent forever. Back up important files elsewhere.
- Use a valid Windows license where required. This project does not provide a Windows license.
- Never commit `.env`; it contains your generated password.
