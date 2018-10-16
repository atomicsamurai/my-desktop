# my-desktop
This is my Manjaro-i3 desktop setup

## .config
My "~/.config/" directory

## bin
My "~/bin/" directory

## misc
Directory containing other configuration files, like udev rules etc.

## Install Manjaro i3
Get the latest Manjaro i3 edition from https://manjaro.org/community-editions/. As of writing this, the latest is 17.1.12.

### Bootable USB
Use etcher to create a bootable USB drive from the iso.

### Boot from USB
When booting from USB, at the grub screen, select nonfree drivers and then edit the linux command line and add `systemd.mask=mhwd-live.service nouveau.modeset=0`.

### Run installer
Before starting the installer, edit `/usr/lib/calamares/modules/mhwdcfg/main.py` so the end of file looks like this:

```
def run():
    """ Configure the hardware """
    
    mhwd = MhwdController()
    
    # return mhwd.run()
    return None # <- Add this and comment the above line
```
Then go ahead and install Manjaro as usual.

## Post install
### Kernel parameters
After installation, reboot. At the grub screen, efit the linux command line and add `acpi_rev_override acpi_osi=! acpi_osi="Windows 2009"`

Once booted and logged into the i3 session, edit the `/etc/default/grub` and add `acpi_rev_override acpi_osi=! acpi_osi=\"Windows 2009\"` to `GRUB_CMDLINE_LINUX_DEFAULT` and then run `sudo update-grub`

### Update system
Next, update the system with `sudo pacman -Syu` and reboot

### Install intel video driver
Next install the intel video drivers with `sudo pacman -S xf86-video-intel`

At this time, you should have a working Manjaro-i3 system, without any nvidia drivers. If you do not want to use the nvidia card, you can stop here and setup the rest of the system and enjoy it. Otherwise, continue...

## NVIDIA card

I got a lot of help by reading about NVIDIA optimus and bumblebee. In particular, this arch thread was a huge help

https://bbs.archlinux.org/viewtopic.php?id=238389

My use case is the following:
1. I will use my laptop primarily for work where I do some Java and Node.js development, run docker containers and play with bash scripts, other than the usual web browsing and using an office suite. The IGP will more than suffice for this purpose and I do not even want the DGP to be on and using any power normally.
2. Ocaasionally, I will use my laptop to play games, like CS:Source or Fortnite. This is when I would love to have the extra graphics prowess of the DGP using the proprietary driver.

Given my use case, I decided to not use bumblebee at all and went with nvidia-xrun, specifically `michelesr's` fork which does not require `bbswitch`. This fork can be found here:

https://github.com/michelesr/nvidia-xrun

I rely on linux PM to control power to the nvidia card. When the nvidia modules are loaded, linux will turn the card on and when the nvidia modules are unloaded, the card will be turned off and will consume no power.

Below is a step-by-step of what I did.

### Install NVIDIA proprietary driver
I am using the nvidia-390xx drivers. Install these with `sudo pacman -S linux414-nvidia-390xx` as I am using the default kernel (4.14) that is bundled with Manjaro-i3 17.1.12.


### Prevent nvidia from loading at boot
Create `/etc/modprobe.d/blacklist_nvidia.conf` with the content:

```
blacklist nvidia
blacklist nvidia_drm
blacklist nvidia_modeset
```

Create `/etc/X11/xorg.conf.d/01-noautogpu.conf` with the content:

```
Section "ServerFlags"
	Option "AutoAddGPU" "off"
EndSection
```
and also create `/etc/X11/xorg.conf.d/20-intel.conf` with the content:

```
Section "Device"
	Identifier "Intel Graphics"
	Driver "intel"
EndSection
```
### Enable PM for DGP
Create a file `/etc/tmpfiles.d/nvidia_pm.conf` with the content

```
w /sys/bus/pci/devices/0000:01:00.0/power/control - - - - auto
```

This is the equivalent of doing `sudo tee /sys/bus/pci/devices/0000:00:01.0/power/control <<<auto` automatically at every boot.

### Install nvidia-xrun
Install `michelesr's` [fork](https://github.com/michelesr/nvidia-xrun) of nvidia-xrun, using the PKGBUILD in the git repository.
I also created a `.nvidia-xinitrc` with the content

```
exec i3
```

Thats it!!!

My system specs:

```
██████████████████  ████████   sandeepc@sandxps 
██████████████████  ████████   ---------------- 
██████████████████  ████████   OS: Manjaro Linux x86_64 
██████████████████  ████████   Host: XPS 15 9570 
████████            ████████   Kernel: 4.14.74-1-MANJARO 
████████  ████████  ████████   Uptime: 1 hour, 34 mins 
████████  ████████  ████████   Packages: 936 (pacman) 
████████  ████████  ████████   Shell: bash 4.4.23 
████████  ████████  ████████   Resolution: 1920x1080, 1920x1080 
████████  ████████  ████████   WM: i3 
████████  ████████  ████████   Theme: Adapta-Nokto-Eta-Maia [GTK2/3] 
████████  ████████  ████████   Icons: Papirus-Adapta-Nokto-Maia [GTK2/3] 
████████  ████████  ████████   Terminal: urxvtd 
████████  ████████  ████████   Terminal Font: 9x15,xft 
                               CPU: Intel i7-8750H (12) @ 4.100GHz 
                               GPU: Intel Device 3e9b 
                               Memory: 1476MiB / 15810MiB
```

Result of running `unigine-valley` benchmark on "Extreme 3D" preset, using `nvidia-xrun` is [here](http://htmlpreview.github.com/?https://github.com/sandman0/my-desktop/blob/master/Unigine_Valley_Benchmark_1.0_20181016_1217.html).


