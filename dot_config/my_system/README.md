# A New Computer

Right now your distro of choice is CachyOS. This repo has (almost) everything you need to set things up on the other side.

## Packages

Install the software you usually use with:

```bash
> sudo pacman -S --needed - < cachyos-packages
```

## Home Configuration

Install config files with chezmoi:

```bash
> chezmoi init git@github.com:pimeys/dotfiles.git
> chezmoi diff
> chezmoi apply -v
```

## Always the DNS

Your home network hostnames are all `.local`. That was a stupid idea, but what can you do. Add a resolved config to `/etc/systemd/resolved.conf.d/unicast-local.conf`:

```ini
[Resolve]
DNS=10.0.0.59
Domains=~local homenet tail0d177.ts.net
```

And then restart the resolver:

```
> sudo systemctl restart systemd-resolved
```

## Secrets

You know where to find them. Copy them in place.

## Certificate

Your home network uses a custom CA. You need to install it to Firefox. It's in the secrets, the file is called `ca.crt`.

## Roon

Use the soda-9.0-1 launcher. Use these launch options:

```sh
WINEDLLOVERRIDES="windows.media.mediacontrol=" %command% -scalefactor=1
```

Change scale factor to match your desktop.
