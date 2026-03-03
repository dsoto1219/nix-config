{ ... }:
{
  services.monado = {
    enable = true;
    defaultRuntime = true;
  };

  # Stop monado systemd process when all XR apps close
  systemd.user.services.monado.environment."IPC_EXIT_ON_DISCONNECT" = "1";
}
