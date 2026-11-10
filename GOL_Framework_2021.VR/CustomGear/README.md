# Framework Version 4.0 Local Gear Scripts
## Introduction
The framework was updated with the intent to make mission updates much easier. The majority of scripts and files have moved to the GW Addon, including the default kits and factions and what remains is the required files to customize your own kits. The framework now has two folders:
* Folder 1: CustomGear - Houses the local modified content by the editor. If you have custom gear, or custom default.sqf scripts, they will stay in this folder.
* Folder 2: Gear - These are primarily support functions that support CustomGear. This folder is separate from the files you will be changing, making an update much easier. A simple replacement of this folder is sufficient.
## Faction References
To find the current default factions you have to visit the GitHub and look at the files from there, you may then copy-paste those files into your custom kits. Custom kits are:
* CUSTOM-W
* CUSTOM-E
* CUSTOM-I

These kits are filled with standard NATO, CSAT, AAF kits as a baseline.
## Addon Options
### [GW_GEAR] Local Handler & Local Default
Options exist in the 3DEN editor for the use of local or global handler, the local handler is your local file in CustomGear folder, this allows you to change the different nuances in our kits and our factions. This is by default turned off. The global handler will be the default GOL standard kits, Custom factions may still be used with both local and global handlers.
### [GW_Gear] Faction by Side
Here's where you must select the factions of each side (west,east,independent). By default these point to NATO-D, CSAT-H and AAF-W.
## Updating Gear
Once you need to update your missions with the latest framework, make sure not to copy the CustomGear folder, as that houses your own gear changes. Replace the gear folder entirely, you should not be editing files there.
## Links
The links to see the current default factions are present at the Github. Note that the branch may be inaccurate. If so change to main branch (Current readme points to future branch code)
* [Link to faction folder on GitHub](https://github.com/oksmantv/GOL_Addon/tree/features/dev-Framewrok_version_4/addons/gear/scripts/Factions)