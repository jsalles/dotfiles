alias ccpr="aws codecommit pr --profile \$(git remote get-url origin | sed 's|codecommit::[^:]*://\([^@]*\)@.*|\1|') --pr-mode=feature-branch --role-name=Developer --skip-verify-tag=\"[SKIP CI]\""

bind \cf tmux-sessionizer