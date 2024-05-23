# Home-Manager Module for 1Password GUI and CLI with SSH Agent
{pkgs, ...}: {
  home.packages = with pkgs; [
    _1password
    _1password-gui
  ];

  programs = {
    git.extraConfig = {
      gpg."ssh".program = "${pkgs._1password-gui}/bin/op-ssh-sign";
    };

    ssh.extraConfig = ''
      Host *
        IdentityAgent ~/.1password/agent.sock
    '';
  };

  home.file.".config/1Password/ssh/agent.toml" = {
    text = ''
      [[ssh-keys]]
      vault = "Private"
    '';
  };
}
