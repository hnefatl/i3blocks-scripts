let
    pkgs = import <nixpkgs> { };
in
    pkgs.stdenv.mkDerivation {
        name = "i3blocks-scripts";

        phases = [ "installPhase" "fixupPhase" ];

        buildInputs = with pkgs; [ bash perl acpi libnotify blueman bluez bluez-tools sysstat i3 networkmanager iproute playerctl pulseaudio ];

        installPhase = ''
            mkdir -p "$out/bin"
            cp "${./scripts}/"* "$out/bin/"
        '';
    }
