{ pkgs, ... }:

{
  home.packages = with pkgs;
    let
      myEmacs = (emacs.override {
        withGTK3 = true;
        withGTK2 = false;
      });
      steamWithLibs =
        (steam.override { extraPkgs = pkgs: [ libjpeg openssl_1_0_2 ]; });
      steam-run = (steamWithLibs.override { nativeOnly = true; }).run;
    in [
      # desktop
      imv
      libnotify
      neofetch

      # shells
      antibody

      # development
      crystal
      docker-compose
      editorconfig-core-c
      elixir
      exercism
      gdb
      insomnia
      lazydocker
      lua
      nasm
      nodejs
      python3
      ruby
      shellcheck
      shfmt
      stack
      virtualbox
      wakatime

      # nix stuff
      nixfmt
      nix-prefetch-github
      nix-review

      # documents
      gimp-with-plugins
      libreoffice-fresh

      # other ART (Awesome Rust Tools)
      exa
      diskus
      du-dust
      fd
      hexyl
      just
      lsd
      pastel
      ruplacer
      sd
      tealdeer
      tokei
      xsv

      # communication
      discord
      riot-desktop
      slack
      tdesktop
      weechat
      zoom-us

      # gaming software
      steamWithLibs
      steam-run
      wineFull
      winetricks

      # games
      cataclysm-dda

      # monitoring
      inxi
      python3Packages.glances
      speedtest-cli

      # passwords & security
      gopass
      pass

      # net & cloud tools
      doctl
      httpie
      miniserve
      rclone
      transmission-gtk

      # synchronization
      syncthing-gtk

      # entertainment
      python3Packages.mps-youtube
      youtube-dl
    ];
}
