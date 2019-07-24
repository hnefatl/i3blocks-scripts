let
    pkgs = import <nixpkgs> { };
in
    pkgs.stdenv.mkDerivation {
        name = "i3blocks-scripts";

        phases = [ "installPhase" "fixupPhase" ];

        inherit (pkgs) bash perl acpi libnotify blueman bluez sysstat i3 networkmanager iproute playerctl pulseaudio kmod alsaUtils procps;
        bluez_tools = pkgs.bluez-tools; # Can't inherit as `-` isn't allowed in env var names.

        installPhase = ''
            mkdir -p "$out/bin"
            substituteAll "${./scripts/battery}" "$out/bin/battery"
            substituteAll "${./scripts/bluetooth}" "$out/bin/bluetooth"
            substituteAll "${./scripts/bluetooth-connected}" "$out/bin/bluetooth-connected"
            substituteAll "${./scripts/cpu_usage}" "$out/bin/cpu_usage"
            substituteAll "${./scripts/diary}" "$out/bin/diary"
            substituteAll "${./scripts/disk}" "$out/bin/disk"
            substituteAll "${./scripts/iface}" "$out/bin/iface"
            substituteAll "${./scripts/memory}" "$out/bin/memory"
            substituteAll "${./scripts/spotify}" "$out/bin/spotify"
            substituteAll "${./scripts/volume}" "$out/bin/volume"
            substituteAll "${./scripts/wifi}" "$out/bin/wifi"

            chmod +x "$out/bin/"*
        '';
    }
