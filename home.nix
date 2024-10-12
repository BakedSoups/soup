{...}: {
  home.file.".config/direnv/lib/uv.sh".source = ./scripts/uv.sh;

  programs = {
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
          user = "tltien";
          forwardAgent = true;
          identityFile = "/home/alex/.ssh/id_ed25519";
        };
        "beagle" = {
          hostname = "beagle";
          user = "tltien";
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
