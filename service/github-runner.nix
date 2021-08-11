{tokenFile}: {
  services = {
    github-runner = {
      enable = true;
      name = "Ardana-CI";
      url = "https://github.com/ArdanaLabs";
      inherit tokenFile;
    };
  };
}
