# emacs-pure
## configuration
- clone this repository to the '$HOME/.emacs.d' folder on Linux (for windows os check the instruction for windows OS section)
- get your computer's name from emacs: use this key 'Alt+:', write it to the minibuffer: (system-name)
- create your custom configuration file: ~/.emacs.d/lisp/custom-{computer-name}.el
- install ripgrep
- write this to the configuration file to use a dedicated folder for yours notes: (setq my/notes-path "H:/notes/") -- it is an example for windows version
    you can set the default folder with this: (cd "c:/Projects")
- setup your fonts: use the 'customize-face' function for 'default' and 'variable-pitch' faces.
    you can set the font-family, font-size in that page and save the changes what will be in the created 'custom-{computer-name}.el' file.
- you can choose a theme for you with the 'consult-theme' command.

## Instructions for windows OS
- set your HOME environment variable to 'c:/users/{username}'
- clone this repo to the 'c:/users/{username}/.emacs.d' folder
- you can copy the binaries from winos/binaries folder to the emacs's 'bin' folder or any places what is in yours PATH.
- the binaries like 'diff', 'find' ... are make more convenient to use emacs.

## Important functions keys
- Alt+return: switch buffer and recent-files and a custom menu with name 'Quick menu item' bottom of the list
- Alt+l: a few frequently used commands
- Alt-s: search, select commands.

# Links
flymake: https://nilsdeppe.com/posts/emacs-flymake
https://reddium.vercel.app/r/emacs/comments/zqshfy/do_i_still_need_to_install_treesitter_manually
