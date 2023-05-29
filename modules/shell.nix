{ ... }: {
  programs = {
    bash.enable = true;

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      history.save = 100000;
      shellAliases = {
        e = "emacsclient -n";
        tmp = "cd $(mktemp -d)";

        cat = "bat";
        tree = "lt";

        watch = "watch -n 1";

        dud = "du -h -d1";

        start = "sudo systemctl start";
        restart = "sudo systemctl restart";
        stop = "sudo systemctl stop";
        status = "sudo systemctl status";
        enable = "sudo systemctl enable";
        disable = "sudo systemctl disable";
        reload = "sudo systemctl daemon-reload";
        ustart = "systemctl start --user";
        urestart = "systemctl restart --user";
        ustop = "systemctl stop --user";
        ustatus = "systemctl status --user";
        uenable = "systemctl enable --user";
        udisable = "systemctl disable --user";
        ureload = "systemctl daemon-reload --user";

        open = "xdg-open";

        play = "mpv --hwdec=autosafe";
        dl = "yt-dlp -f bestvideo+bestaudio";

        up = "$HOME/sh/update.sh";

        ipython3 = "ipython3 --no-confirm-exit";
      };
      sessionVariables = {
        ALTERNATE_EDITOR = "";
        EDITOR = "emacsclient -tc";
        VISUAL = "emacsclient -c -a emacs";
        TERM = "xterm";
        SSH_AGENT_PID = "";
        SSH_AUTH_SOCK = "$\{XDG_RUNTIME_DIR\}/gnupg/S.gpg-agent.ssh";
      };
      initExtra = ''
        alias ..="cd .."
        alias ...="cd ../.."

        [[ -f "/tmp/emacs-share-path" ]] \
          && [[ -d "$(cat /tmp/emacs-share-path)" ]] \
          && cd "$(/bin/cat /tmp/emacs-share-path)"

        export PATH=$HOME/.cargo/bin:$PATH
      '';
    };

    starship.enable = true;

    bat.enable = true;

    exa = {
      enable = true;
      enableAliases = true;
      icons = true;
    };
  };
}
