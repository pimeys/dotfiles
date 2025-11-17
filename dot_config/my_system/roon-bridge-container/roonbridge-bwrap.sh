#!/usr/bin/env bash
set -euo pipefail

ROON_ROOT=${ROON_ROOT:-/opt/RoonBridge}
ROON_STATE=${ROON_STATE:-/var/roon}
HOSTNAME=${ROON_HOSTNAME:-roonbridge}

exec /usr/bin/bwrap \
  --die-with-parent \
  --unshare-pid \
  --unshare-ipc \
  --unshare-uts \
  --hostname "${HOSTNAME}" \
  --setenv ROON_DATAROOT "${ROON_STATE}" \
  --setenv ROON_ID_DIR "${ROON_STATE}" \
  --proc /proc \
  --dev /dev \
  --tmpfs /tmp \
  --tmpfs /run \
  --ro-bind /usr /usr \
  --ro-bind /bin /bin \
  --ro-bind /lib /lib \
  --ro-bind /lib64 /lib64 \
  --ro-bind /etc /etc \
  --bind "${ROON_ROOT}" "${ROON_ROOT}" \
  --bind "${ROON_STATE}" "${ROON_STATE}" \
  --dev-bind /dev/snd /dev/snd \
  --dev-bind /dev/bus/usb /dev/bus/usb \
  --dev-bind /dev/shm /dev/shm \
  --dev-bind /dev/pts /dev/pts \
  --dev-bind /dev/ptmx /dev/ptmx \
  --dev-bind /dev/null /dev/null \
  --dev-bind /dev/zero /dev/zero \
  --dev-bind /dev/full /dev/full \
  --dev-bind /dev/random /dev/random \
  --dev-bind /dev/urandom /dev/urandom \
  --ro-bind /run/udev /run/udev \
  --chdir "${ROON_ROOT}" \
  "${ROON_ROOT}/start.sh"
