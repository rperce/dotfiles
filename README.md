dotfiles
========

Robert's assorted dotfiles.

You need ruby and GNU stow installed.

To use these, simply go to your home directory and run:

    git clone http://github.com/rperce/dotfiles .dotfiles
    cd .dotfiles
    chmod +x link
    ./link

Existing dotfiles will prevent running. To update after cloning again, run
`./link -R`.
