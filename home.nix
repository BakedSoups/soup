{pkgs, ...}: {
  home.file.".config/direnv/lib/uv.sh".source = ./scripts/uv.sh;

  # autograder doesn't allow empty TOML key
  xdg.configFile."grade/config.toml".source = (pkgs.formats.toml {}).generate "something" {
    Canvas = {};
    CanvasMapper = {};
    Config = {};
    Git = {};
    Github = {};
    Test = {
      digital_path = "${pkgs.digital}/share/java/Digital.jar";
    };
  };

  programs = {
    bash = {
      enable = true;
    };

    readline = {
      enable = true;
      extraConfig = "set editing-mode vi";
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    #    git = {
    #      enable = true;
    #      username = "";
    #      useremail = "";
    #    };

    ssh = {
      enable = true;
      addKeysToAgent = "yes";
      compression = true;
      matchBlocks = {
        "stargate" = {
          hostname = "stargate.cs.usfca.edu";
          user = "acpeczon";
          forwardAgent = true;
          identityFile = "/home/alex/.ssh/id_ed25519";
        };
        "beagle" = {
          hostname = "beagle";
          user = "acpeczon";
          forwardAgent = true;
          identityFile = "/home/alex/.ssh/id_ed25519";
          proxyCommand = "ssh stargate -w %h:%p";
        };
        "github" = {
          hostname = "github.com";
          forwardAgent = true;
          identityFile = "/home/alex/.ssh/id_ed25519";
        };
      };
    };
  };

  home.username = "alex";
  home.homeDirectory = "/home/alex";
  home.stateVersion = "23.11";
}
