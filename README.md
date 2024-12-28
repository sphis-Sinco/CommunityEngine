# Friday Night Funkin Community Engine
## Compiling
0. Setup
    - Download Haxe from [Haxe.org](https://haxe.org)
    - Download Git from [git-scm.com](https://www.git-scm.com)
1. Open the folder you put the zip in inside of your terminal (or command prompt)
2. Run `haxelib --global install hmm` and then `haxelib --global run hmm setup` to install hmm.json
3. Run `hmm install` to install all haxelibs of the current branch
4. Run `haxelib run lime setup` to set up lime
5. If you are targeting for native, you may need to run `lime rebuild <PLATFORM>` and `lime rebuild <PLATFORM> -debug`
6.  `lime test <PLATFORM>` to build and launch the game for your platform (for example, `lime test windows`)

## Credits
- Sinco - Programming