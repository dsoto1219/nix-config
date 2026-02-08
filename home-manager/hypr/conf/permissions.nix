###################
### PERMISSIONS ###
###################

# See https://wiki.hypr.land/Configuring/Permissions/
# Please note permission changes here require a Hyprland restart and are not applied on-the-fly for security reasons
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    # ecosystem = {
    #   enforce_permissions = 1
    # }
    # permission = [
    #   "/usr/(bin|local/bin)/grim, screencopy, allow"  
    #   "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland, screencopy, allow"
    #   "/usr/(bin|local/bin)/hyprpm, plugin, allow"
    # ];
  };
}

