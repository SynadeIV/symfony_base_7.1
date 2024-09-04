{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-23.11"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.php
    pkgs.symfony-cli
    pkgs.php82Packages.composer
  ];

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  # Sets environment variables in the workspace
  env = {
    SOME_ENV_VAR = "hello";
  };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "angular.ng-template"
      "rangav.vscode-thunder-client"
    ];
    workspace = {
      onCreate = {
        # Open editors for the following files by default, if they exist:
        default.openFiles = ["index.php"];
      };
      # Runs when a workspace is (re)started 
      onStart= {
        run-server = "symfony server:start";
      };
    };
  };

    # Enable previews and customize configuration
  idx.previews = {
    enable = true;
    previews = {
      web = {
        command = [
          "npm"
          "run"
          "start"
          "--"
          "--port"
          "$PORT"
          "--host"
          "0.0.0.0"
          "--disable-host-check"
        ];
        manager = "web";
      };
    };
  };
}