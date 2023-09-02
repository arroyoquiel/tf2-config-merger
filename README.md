# TF2 Config Merger: A Script to Combine Multiple Config Files
![mintty_PvSP09MsTF](https://github.com/arroyoquiel/tf2-config-merger/assets/81461845/4f887a15-0c2e-4f4d-b48f-24d307148aad)

TF2 Config Merger is a bash script that combines multiple TF2 config folders into a single one. It supports any custom config folder and prevents conflicts from files with the same name.

The tool adds headers to .cfg and .txt files that indicate their original names and folders. It also copies other file types and adds a number suffix if there are duplicate file names.

The tool allows you to use both .cfg and .txt files that have the same name in different config folders. This solves the problem of the Source engine not loading two .cfg files with the same name. For example, if you have `cfg/scout.cfg` in two different `tf/custom` folders, only one of them will be loaded by the game.

If you want to use your own class/mercenary .cfg files and also the ones from a pro-player, you might face a problem where only one set of files will be loaded. By using this tool, you can merge and use both sets of files without any issues.

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
