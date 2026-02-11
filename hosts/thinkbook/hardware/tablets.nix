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
  # 056a:0374 Input device ID: bus 0000 vendor 0000 product 0000 version 0000
  services.udev.extraHwdb =''
    evdev:input:b0000v0000p0000*
      KEYBOARD_KEY_70005=h
      KEYBOARD_KEY_700e0=0x1d
      KEYBOARD_KEY_70057=a
      KEYBOARD_KEY_70056=z
  '';
}
