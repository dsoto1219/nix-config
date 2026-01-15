# Configuration for drawing tablets
{ ... }:
{
  # Enable OpenTabletDriver
  hardware.opentabletdriver.enable = true;

  # Required by OpenTabletDriver
  hardware.uinput.enable = true;
  boot.kernelModules = [ "uinput" ];

  # Add keybinds
  services.udev.enable = true;
  services.udev.extraHwdb =''
    evdev:input:b<BUS-ID>v<VID>p<PID>*
      KEYBOARD_KEY_<HOTKEY-ID>=<KEY-SCAN-CODE>
      KEYBOARD_KEY_70005=h
      KEYBOARD_KEY_700e0=0x1d
      KEYBOARD_KEY_70057=a
      KEYBOARD_KEY_70056=z
  '';
}
