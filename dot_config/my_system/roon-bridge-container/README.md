# Roon Bridge Sandbox (systemd only)

Running `roon-bridge` inside its own mount/pid namespace stops the DX9 power-cycle from yanking the keyboard even though ALSA + USB devices remain available. This directory keeps that setup reproducible, including a bubblewrap-based launcher plus a systemd unit—no Docker/Podman required.

## Requirements

- `bubblewrap` (`sudo pacman -S bubblewrap`)
- Roon Bridge installed under `/opt/RoonBridge` with state in `/var/roon`

## Files

- `roonbridge-bwrap.sh` – helper that enters a sandbox via `bwrap` and starts `/opt/RoonBridge/start.sh`.
- `roonbridge-bwrap.service` – systemd unit wired to the helper with sensible hardening defaults.
- (`Dockerfile`, `docker-compose.yml`, `roonbridge-docker.service`) remain for reference but are no longer required.

## Install the systemd service

```bash
# 1) helper script
sudo install -Dm755 roon-bridge-container/roonbridge-bwrap.sh \
  /usr/local/libexec/roonbridge-bwrap.sh

# 2) service unit
sudo install -Dm644 roon-bridge-container/roonbridge-bwrap.service \
  /etc/systemd/system/roonbridge-bwrap.service

# 3) optional overrides
cat <<'ENV' | sudo tee /etc/default/roon-bridge >/dev/null
ROON_ROOT=/opt/RoonBridge
ROON_STATE=/var/roon
ROON_HOSTNAME=roonbridge
ENV

# 4) enable
sudo systemctl daemon-reload
sudo systemctl enable --now roonbridge-bwrap.service
```

The helper sets up a private namespace with:

- tmpfs-backed `/tmp` and `/run`
- separate PID/IPC/UTS namespaces (so Roon’s restarts don’t ripple to the host)
- read-only binds for `/usr`, `/bin`, `/etc`, `/lib*`
- read/write binds for `/opt/RoonBridge` and `/var/roon`
- device binds for `/dev/snd`, `/dev/bus/usb`, `/dev/shm`, `/dev/pts`, `/dev/null`, etc.
- a read-only bind to `/run/udev` so RAAT can read USB descriptors without touching the host controller

Essentially the same isolation Docker provided, but managed entirely by systemd.

## Logs & validation

- `systemctl status roonbridge-bwrap.service`
- `journalctl -u roonbridge-bwrap -f`
- Roon → Settings → Audio should list DX9/onboard devices.
- Power-cycle the DX9; `journalctl -k` should stay quiet and the keyboard must remain active.

## Tweaks

- Change `ROON_HOSTNAME` (and other env vars) in `/etc/default/roon-bridge`.
- Add more bind mounts inside `roonbridge-bwrap.sh` if another device needs extra paths.
- If you ever need to revert to Docker/Podman, the old files remain here for reference.
