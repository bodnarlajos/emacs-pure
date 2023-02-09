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
scoop bucket add sysinternals https://github.com/niheaven/scoop-sysinternals

scoop update
scoop reset git

# install additional packages
scoop install process-explorer ctrl2cap debugview desktops du handle listdlls portmon procmon pskill pslist tcpview
scoop install git-credential-manager
scoop install aria2
scoop install ripgrep 7zip zstd fzf winrar keepassxc
scoop install doublecmd
scoop install JetBrains-Mono
scoop install gitui
scoop install emacs-k diffutils findutils
