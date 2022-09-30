# install scoop for other packages
# Need to use job since scoop installer can just {exit 1}
Start-Job -ScriptBlock {
    Invoke-WebRequest -useb 'get.scoop.sh' | Invoke-Expression -ErrorAction SilentlyContinue
} | Wait-Job | Receive-Job

if (!(Get-Command 'git' -ErrorAction SilentlyContinue))
{
    scoop install git
}

scoop bucket add extras
scoop bucket add misc https://github.com/kiennq/scoop-misc
# scoop bucket add misc2 https://github.com/bodnarlajos/scoop

# boostrap all the dotfiles
# Push-Location ~

# git clone https://github.com/bodnarlajos/emacs-pure.git

# Pop-Location

scoop update
scoop reset git

# install additional packages
scoop install aria2 gsudo-x
scoop install ripgrep pwsh-x 7zip zstd fzf winrar keepassxc
scoop install JetBrains-Mono
scoop install emacs-k diffutils findutils

gsudo cache on

gsudo -k
