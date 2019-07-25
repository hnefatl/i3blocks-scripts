let
    pkgs = import <nixpkgs> { };
in
    pkgs.stdenv.mkDerivation {
        name = "i3blocks-scripts";

        phases = [ "installPhase" "fixupPhase" ];

        inherit (pkgs) bash perl acpi libnotify blueman bluez sysstat i3 networkmanager iproute playerctl pulseaudio kmod alsaUtils procps brightnessctl;
        bluez_tools = pkgs.bluez-tools; # Can't inherit as `-` isn't allowed in env var names.

        installPhase = ''
            mkdir -p "$out/bin"
            for f in "${./scripts}"/* ; do
                f="$(basename $f)"
                substituteAll "${./scripts}/$f" "$out/bin/$f"
            done

            chmod +x "$out/bin/"*
        '';
    }
