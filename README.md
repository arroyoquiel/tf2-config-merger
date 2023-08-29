# TF2 Config Merger
![mintty_WemumgneAh](https://github.com/arroyoquiel/tf2-config-merger/assets/81461845/d68d0606-9018-4fc0-b679-794f69be0882)


TF2 Config Merger is a bash script that merges different Team Fortress 2 config files into one. It works with any custom config folder and avoids compatibility issues from files sharing the same name (for example, using mastercomfig and your custom class configs, the game will prioritize whichever file it loaded first and ignore the others). It merges .cfg and .txt files by appending their contents with headers indicating their original file names and folders. For other file types, such as audio files, it will copy the file to the merged folder and rename it with a number suffix if there are multiple files with the same name. You can keep the file you want by choosing the appropriate number.

# Requirements (Windows 11)
> (Only tested in Windows 11)

To use this tool, you need the following:

- Windows 11
- [Git for Windows](https://gitforwindows.org/)
- The config folders and the script in the same directory

## Usage
1. Create a new folder that contains only your config folders.
2. [Download the script](https://raw.githubusercontent.com/arroyoquiel/tf2-config-merger/main/tf2_config_merger.sh) and place it next to the config folders.
3. Execute the script by opening it with Git Bash.
4. Check the printed directory list and confirm the folders.
5. Choose a custom name for your merged folder.
6. Wait for the merge to complete.

The script will generate a new merged directory with the name you selected in the current directory, and store the merged or copied files there.

> Optional: You can drag the folder to `Team Fortress 2/bin/vpk.exe` to create a .vpk of your new config, for easier sharing.

To use your merged config folder, copy or move it to `Team Fortress 2/tf/custom`.
## Example
Suppose you have the following directory structure:

```
.
├── pootis
│	├── cfg
│	│   └── heavyweapons.cfg (pootis-spam-bind)
│	└── hitsound
│	    └── sound
│		└── ui
│		    └── hitsound.wav (pootis hitsound)
├── explode bind
│	└── cfg
│	    └── autoexec.cfg (explode bind)
├── respawn bind
│	└── cfg
│	    └── autoexec.cfg (respawn bind)
├── quake hitsound
│	└── hitsound
│           └── sound
│               └── ui
│                   └── hitsound.wav (quake hitsound)
└── file_merger.sh
```

After running the script, you will get the following directory structure:

```
.
├── pootis
│	├── cfg
│	│   └── heavyweapons.cfg (pootis-spam-bind)
│	└── hitsound
│	    └── sound
│		└── ui
│		    └── hitsound.wav (pootis hitsound)
├── explode bind
│	└── cfg
│	    └── autoexec.cfg (explode bind)
├── respawn bind
│	└── cfg
│	    └── autoexec.cfg (respawn bind)
├── quake hitsound
│	└── hitsound
│           └── sound
│               └── ui
│                   └── hitsound.wav (quake hitsound)
├── merged
│	├── cfg
│	│   ├── autoexec.cfg (explode bind + respawn bind)
│	│   └── heavyweapons.cfg (pootis-spam-bind)
│	├── hitsound
│	│   └── sound
│	│       └── ui
│	│           ├── hitsound.wav (pootis hitsound)
│	│           └── hitsound_2.wav (quake hitsound)
│	└── merge.log
├── merged_folders.log
└── file_merger.sh
```

The contents of the merged files will have headers with the original file names and directories, for example:

```
// Contents: autoexec.cfg, Folder: ./explode and schadenfreude bind
bind o "taunt_by_name Taunt: The Schadenfreude"
bind p explode

// Contents: autoexec.cfg, Folder: ./real and working call medic bind totally not a troll
bind e kill

```
