# TF2 Config Merger
TF2 Config Merger is a bash script that merges different TF2 config files into one. It works with any custom config folder and avoids compatibility issues from files sharing the same name (for example, using mastercomfig and your custom class configs, the game will prioritize whichever file it loaded first and ignore the others). It merges .cfg and .txt files by appending their contents with headers indicating their original file names and folders. For other file types, such as audio files, it will copy the file to the merged folder and rename it with a number suffix if there are multiple files with the same name. You can keep the file you want by choosing the appropriate number.

# Requirements (Windows 11)
> (Only tested in Windows 11)

To use this tool, you need the following:

- Windows 11
- [Git for Windows](https://gitforwindows.org/)
- The config folders and the script in the same directory

## Usage
To run the script, open the script with Git Bash.

The script will create a new directory called `merged` in the current directory and store the merged or copied files there. The script will also print a message indicating that the merging process is done.

## Example
Suppose you have the following directory structure:

```
.
├── pootis
│	└── cfg
│		└── heavyweapons.cfg (pootis-spam-bind)
│	└── hitsound
│		└── sound
│			└── ui
│				└── hitsound.wav (pootis hitsound)
├── explode bind
│	└── cfg
│		└── autoexec.cfg (explode bind)
├── respawn bind
│	└── cfg
│		└── autoexec.cfg (respawn bind)
├── quake hitsound
│	└── hitsound
│		└── sound
│			└── ui
│				└── hitsound.wav (quake hitsound)
└── file_merger.sh
```

After running the script, you will get the following directory structure:

```
.
├── pootis
│	└── cfg
│		└── heavyweapons.cfg (pootis-spam-bind)
│	└── hitsound
│		└── sound
│			└── ui
│				└── hitsound.wav (pootis hitsound)
├── explode bind
│	└── cfg
│		└── autoexec.cfg (explode bind)
├── respawn bind
│	└── cfg
│		└── autoexec.cfg (respawn bind)
├── quake hitsound
│	└── hitsound
│		└── sound
│			└── ui
│				└── hitsound.wav (quake hitsound)
├── merged
│	└── cfg
│		└── autoexec.cfg (explode bind + respawn bind)
│		└── heavyweapons.cfg (pootis-spam-bind)
│	└── hitsound
│		└── sound
│			└── ui
│				└── hitsound.wav (pootis hitsound)
│				└── hitsound_2.wav (quake hitsound)
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
