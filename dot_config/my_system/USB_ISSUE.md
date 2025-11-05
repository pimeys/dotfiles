# USB Keyboard Disconnects When Power-Cycling Topping DX9 DAC

**System**: ASUS ROG Crosshair VIII Dark Hero (X570), Ryzen 7, CachyOS/Arch Linux

---

## 1. Symptom Overview
- Kinesis Advantage360 (USB ID `29ea:0360`) briefly disconnects/re-enumerates whenever the Topping DX9 DAC (USB ID `152a:8750`) is powered off and on.
- KDE shows hotplug notifications; `journalctl -k` records the detach/attach sequence.
- Restarting PipeWire used to trigger the same behavior until power profile and PipeWire settings were adjusted.

---

## 2. Hardware Topology
- Multiple USB controllers:
  - `0000:08:00.1` → `usb1/usb2`
  - `0000:08:00.3` → `usb3/usb4`
  - `0000:0f:00.3` → `usb5/usb6`
- Front-panel ports and many rear Type‑A ports share the same AMD xHCI controller (`08:00.3`).
- The DX9 power-cycle causes the shared hub/controller to reset, dropping all downstream HID devices, including the keyboard.

---

## 3. Baseline Logs
Example `dmesg` when DX9 is toggled:
```
usb 1-4.2.2: USB disconnect, device number 24
usb 1-4.2.2: new high-speed USB device number 25 using xhci_hcd
usb 1-4.2.2: Product: DX9
...
usb 3-5: USB disconnect, device number 3
usb 3-5: new full-speed USB device number 4 using xhci_hcd
usb 3-5: Product: Kinesis Adv360
```
No `xhci_hcd` error codes—indicates a controller reset rather than a fault.

---

## 4. Mitigations Tested
| Change | Result |
|--------|--------|
| `powerprofilesctl set performance` | Fixes drop when PipeWire restarts; keeps controller powered. |
| PipeWire override (`session.suspend-timeout-seconds = 0`) | Prevents PipeWire from suspending DX9; restarts no longer trigger disconnect. |
| Disable autosuspend (`power/control=on`, `power/autosuspend=-1`) | Stops runtime power management; does not prevent keyboard drop when DAC is physically power-cycled while sharing the same hub/controller. |
| Move devices/hub to other ports | Only successful if devices land on different controllers or behind a buffering hub. |
| Powered USB hub (StarTech 10-port) | Helps only when hub is on a separate controller or actively absorbing reset. |
| Vanilla Arch / CachyOS kernels | Issue persists—hardware/firmware behavior. |

---

## 5. Command Cheatsheet
```bash
# Map root hubs → PCI controllers
for hub in /sys/bus/usb/devices/usb*; do
  echo "$(basename "$hub"): $(readlink -f "$hub")"
done
```
```bash
# USB tree
lsusb -t
```
```bash
# Force devices to stay on
sudo tee /sys/bus/usb/devices/1-4.2/power/control <<< on
sudo tee /sys/bus/usb/devices/1-4.2/power/autosuspend <<< -1
```

PipeWire override:
```ini
# ~/.config/pipewire/pipewire.conf.d/10-no-suspend.conf
context.properties = {
    session.suspend-timeout-seconds = 0
}
```

Persistent udev rule:
```udev
# /etc/udev/rules.d/99-usb-keepawake.rules
ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="14b0", ATTR{power/control}="on", ATTR{power/autosuspend}="-1"
ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="152a", ATTR{idProduct}=="8750", ATTR{power/control}="on", ATTR{power/autosuspend}="-1"
ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="29ea", ATTR{idProduct}=="0360", ATTR{power/control}="on", ATTR{power/autosuspend}="-1"
```

---

## 6. Current State
- Performance power profile + PipeWire override = no disconnect on PipeWire restarts.
- Physically turning the DX9 off/on while both devices share the same AMD controller still causes the keyboard to drop.
- Behavior matches ASUS/AMD X570 USB hot-plug issues reported by other users.

### Workarounds
1. Keep keyboard on a different root controller (e.g., rear USB‑C / Gen2 connected to `usb5/usb6`).
2. Buffer the keyboard through a powered USB 2.0 hub that stays powered during the DAC’s reset.
3. Avoid hot power-cycling the DAC while the system is running.

---

## 7. Next Steps
- New hardware (Framework desktop) is expected to eliminate the issue due to a different USB architecture.
- Upon receiving the Framework system, run `lsusb -t` to verify devices land on separate buses; retest by power-cycling the DX9.
- If the issue persists on the new platform, capture the `dmesg` output and revisit power/USB configuration.

---

## 8. References
- ASUS Crosshair VIII USB disconnect thread: <https://rog-forum.asus.com/t5/amd-500-400-series/rog-crosshair-viii-usb-disconnecting-issues/td-p/881928>
- Device IDs: DX9 `152a:8750`, Kinesis `29ea:0360`, StarTech Hub `14b0:015x`.
