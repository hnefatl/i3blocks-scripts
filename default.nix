let
    pkgs = import <nixpkgs> { };
in
    pkgs.stdenv.mkDerivation {
        name = "i3blocks-scripts";

        phases = [ "installPhase" "fixupPhase" ];

        inherit (pkgs) bash perl acpi libnotify blueman bluez sysstat i3 networkmanager iproute playerctl pulseaudio kmod alsaUtils procps brightnessctl;
        bluez_tools = pkgs.bluez-tools; # Can't inherit as `-` isn't allowed in env var names.
        useful_scripts = import (pkgs.fetchFromGitHub {
            owner = "hnefatl";
            repo = "useful-scripts";
            rev = "686872ff523ea1c719fcf935a66f394b058bffd5";
            sha256 = "137zn45iv73iq033xvclpkpvj2c89pp8hbkxj66xmf1xah030m6p";
        });

        installPhase = ''
            mkdir -p "$out/bin"
            for f in "${./scripts}"/* ; do
                f="$(basename $f)"
                substituteAll "${./scripts}/$f" "$out/bin/$f"
            done

            chmod +x "$out/bin/"*
        '';
    }
