set PATH /Users/jvsalles/.cargo/bin /Users/jvsalles/.toolbox/bin $PATH

alias ccpr="aws codecommit pr --profile \$(git remote get-url origin | sed 's|codecommit::[^:]*://\([^@]*\)@.*|\1|') --pr-mode=feature-branch --role-name=Developer --skip-verify-tag=\"[SKIP_CI_BUILD]\""

bind \cf tmux-sessionizer
bind \c\eH tmux-sessionizer CAWSApmFrontend
