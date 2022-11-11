Set-Alias -Name list -Value Get-ChildItem
function my_make_directory { param ($my_path) New-Item -ItemType Directory $my_path }
Set-Alias -Name mkdir -Value my_make_directory
function my_rm_directory { param ($my_path) Remove-Item -Path $my_path }
Set-Alias -Name rmd -Value my_rm_directory
function my_make_directory_and_open { param ($my_path) New-Item -ItemType Directory $my_path; cd $my_path }
Set-Alias -Name mkdiro -Value my_make_directory_and_open
function my_du_command { param ($my_path) "{0:N2} GB" -f ((gci –force $my_path –Recurse -ErrorAction SilentlyContinue | Where-Object { $_.LinkType -notmatch "HardLink" }| measure Length -s).sum / 1Gb) }
Set-Alias -Name du -Value my_du_command
