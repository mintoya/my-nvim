

## installation
not windows
```
git clone --recurse-submodules https://github.com/mintoya/my-nvim/ ~/.config/nvim && nvim
```
windows powershell
```
git clone --recurse-submodules https://github.com/mintoya/my-nvim/ $env:USERPROFILE\AppData\Local\nvim
nvim
```
or just 
```
setx XDG_CONFIG_HOME "c:/users/<username>/.config"
(relaunch)
git clone --recurse-submodules https://github.com/mintoya/my-nvim/ ~/.config/nvim
nvim
```
