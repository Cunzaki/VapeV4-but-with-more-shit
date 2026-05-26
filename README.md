<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="./README/vapelogo-white.png">
    <source media="(prefers-color-scheme: light)" srcset="./README/vapelogo-dark.png">
    <img alt="vape logo" src="./README/vapelogo.png">
  </picture>
</p>
<h2 align="center">
  A Roblox script built from the ground up for your precise needs!
  <br/>
  Rise up to the top while remaining completely untouchable.
</h2>

## Uhhh why did you fork it
I really like the vapev4 project and ive been using this script for a while. I dont wanna take any credits to the still updated version by 7GrandDad. I just felt there was a few things I could add to the universal to make it more fun to use and that I felt were needed. 

## Why use the fork?
Im gonna try to stay relatively updated to the original version with game support and whatnot. Once again, all credits to https://github.com/7GrandDadVape for the original scripts. 
This version has bullet tracers, cframe desync, more visualizers, better npc detection and so on. I may make a full change list eventually but I am too lazy for that as I type this right now. 

## 7GrandDadVape Contacts
[Discord](https://discord.gg/ZqS836yx9k)
<br/>
[Youtube](https://youtube.com/c/7GrandDadVape)

## Usage
1. Download the specific scripting utility of your choice.
2. Execute the provided loadstring below.
```luau
loadstring(game:HttpGet("https://raw.githubusercontent.com/Cunzaki/VapeV4-but-with-more-shit/main/NewMainScript.lua", true))()
```

## Possible Issues
Half of the time its usually the scripting utility at fault, please make sure the utility meets certain quality standards such as.
1. Supporting file functions & the debug library.
2. Not implementing lua generated / half baked versions of such functions resulting in unintended behavior.
3. Maintaing the same behavior across all usages of said functions.
### User Issues
If its not the supposed utility at fault, please try some troubleshooting steps.
1. Deleting the newvape folder (WITH THE GAME CLOSED).
2. Making sure you have connection to [the main loadstring.](https://raw.githubusercontent.com/Cunzaki/VapeV4-but-with-more-shit/refs/heads/main/NewMainScript.lua)
3. Ensuring no external script is conflicting with vape.

## Developers & Credits
[Cunzaki](https://github.com/Cunzaki) - forker of the project
<br/>
[7GrandDad](https://github.com/7GrandDadVape) - Lead maintainer of the project - vaperoblox on Discord
<br/>
[rce-incorporated](https://github.com/rce-incorporated/Fiu) - Luau bytecode disassembly with modifications
<br/>
[Egor Skriptunoff, boatbomber, and howmanysmall](https://devforum.roblox.com/t/open-source-hashlib/416732/1) - HashLibrary for Luau
<br/>
[Vernumerator](https://devforum.roblox.com/t/predict-projectile-ballistics-including-gravity-and-motion/1842434) - Projectile prediction for Roblox
<br/>
[KaenDeveloper](https://github.com/KaenDeveloper) - Updated ESP library for 2D ESP
