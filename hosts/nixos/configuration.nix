{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/purpose/workstation.nix
  ];

  networking.hostName = "nixos";

  # FIXME: fingerprinting is broken
  # services.fprintd.enable = true;
}
