

<p align="center">
    <h1> GOL_Framework_2021 </h1>
    <img src="https://github.com/Bluwolf00/GOL_Framework_2021/blob/main/AnimatedGOLlogo.png" width="160">
</p>

Guerrillas Of Liberation's custom framework for Arma 3</br>
Edited by the GOL Technical Team.</br>

USE THE RELEASE FOR THE LATEST **STABLE** BUILD

Video Guides of GOL Setup: https://www.youtube.com/playlist?list=PLdTW1xaImQYUvXiP5KYoTlrf0XG6qixZ5

## Modules

The main Modules of the FRAMEWORK include:

### Common:
* Includes basic commands that allows the framework to operate correctly.
* **DO NOT TOUCH**

### Gear:
* Adds and controls auto-gear for all units on mission file.
* Factions are custom made and can be set in the 3den addon options to a specifc faction for each side. (BLUFOR, OPFOR, INDFOR, Civilian)
* Adds the gearbox which allows players to change their role and kit to a vast number of different options, to name a few:
    * Squad Leader
    * Forward Air Controller
    * Fire Team Leader
    * Rifleman
    * Grenadier
    * Asst. Gunner
    * Automatic Rifleman
    * Helicopter Pilot
    * Crewman
* The gearbox can also allow players to adjust their weapon attachments on their primary and secondary weapons as well as any container changes (Uniform, Vest, Backpack) if the author of the mission includes it.

### MHQ:
* Adds the framework for the most widely used reinsertion method. The Mobile Headquarters.
* The mobile headquarters acts as a Forward Operating Point and is classed as a vehicle that can be activated and deactivated.
* The MHQ can be activated to allow players to travel between the spawnpoint and the MHQ and vice versa.
    * During this time the MHQ is depleted of fuel in order to stop the vehicle from being moved.
* When Assembled, The MHQ can provide minimal cover from fire as well as a gearbox for the players.
* The MHQ can come in many different variants:
    * Small - Small compact design, To be used on small vehicles such as the Quad Bike or similar.
    * Medium - The most common preset, Includes some minimal cover and concealment for Logistical support of assets.
    * FOB/Large - The largest preset, Will construct a large FOB containing H-Barrier walls spanning approx. 20m x 20m. **Rarely Used**
    * Boat - No cover provided, deploys a gearbox on the closest piece of land that is not water.
    * Air - Usually used on VTOLs for paradropping troops from a high altitude.

### MiscSettings:
* Adds options to the GOL Flexi menu that is part of the GW_Addon which the framework works in tandem with.

### Radios:
* Initialises and Instantiates Task Force Radio & ACRE radios if present to specifed settings.
* Usually pre-programs radios to be defaulted to Ch. 1 Freq. 10.

### SetDifficulty:
* Adds different difficulty levels for enemy AI.
* This changes their:
    * Accuracy
    * Time to aim on target
    * Courage (May retreat after heavy suppression or heavy assets are present)
    * General Spotting
        * Time
        * Distance
* The difficulties are split into certain "Trees":
    * Dummy
    * Insurgents
    * Military
    * Special Forces
    * -Testing- (Not to be used in real operations)
    * Each of which come with increasing difficulty and decreased reaction times in terms of the previously mentioned skills.

### Startup:
* Displays the GOL startup screen when initialising into a **Multiplayer** session.


## Scripts

The framework contains a multitude of scripts designed by a handful of the dev team.

### LARs:
* Custom compositions

### NEKY_Airdrop:
* Dependency for dynamic enemy aeriel reinforcements.

### NEKY_CombatExperience:
* Changes the combat actions of AI.

### NEKY_HUNT:
* The first iteration of the **"Dynamic Hunt Base"** script that facilitates a spawnpoint for enemies every specified interval.
* Enemies will track location of player upon spawn.
* Hunt base can be destroyed in order to stop enemy reinforcements.

### NEKY_Mortars:
* Allows AI to target players within a specified radius from the source mortar.
* AI squads will communicate position of players. The more squads / closer the squads = The more accurate the mortar strike.
* Will spawn a red smoke on target primarily for a fair early warning for players which forces a retreat or disengagement.

### NEKY_Paradrop:
* Adds the additional option of reinsertion of friendly units by adding a paradrop action to the flagpole at the spawnpoint.
* Squad leaders, Forward Air Controllers and any Fire team leaders are able to reposition a map marker which dictates the point in which players are dropped from.
* The drop-zone is able to be moved by using the ACE Self-Interaction method and navigating to: **Request Support > Reposition Dropzone**.

### NEKY_Pickup:
* Adds another additional option of reinsertion of friendly units by allowing pick-up & drop-off by an AI helicopter pilot.
* Due to the fact that the helicopter is piloted by AI and because ArmA's AI are sometimes not intelligent, reinsertion may not be successful everytime.

### NEKY_ServiceStation:
* A key module in the framework that adds the Mobile Service Station & Static Service Station.
* The service station is able to perform R&R on most vehicles (which can be specified as a parameter when called) in the field or at a base of operations.
* When activated on one object the script will search for any vehicles within a given radius and add the R&R actions to each of them.
* The actions are:
    * Repair -  Repairs the vehicle's hitpoints one-by-one (The delay and time taken for each hitpoint can be dictated in the settings).
    * Refuel -  Refuels the vehicle's fuel tank incrementally depending on the size of the tank. (e.g. Cars take less time to fill than Tanks or Helicopters)
    * Rearm  -  Rearms the vehicle's onboard weaponry. Depending on the type of weaponry (Pylons, Fixed-Turret etc.) the Rearm process can be incrementative or given a delay until the action is complete.
* Updated to also use ACE_Rearm Stations.

### NEKY_Supply:
* Allows any leader of a team to call for a resupply crate to be airlifted by an airframe.
* The type of airframe and available resupplies can be specified in the options as well as a few more options.
* The request process is initiated from the ACE Self-Interaction menu under: **Request Support > Request Resupply**. (Implemented by Lucas)
* The process will then open the player's map and prompt the user to click on a location for the supplies to either be Airdropped or Unloaded on deck.

### NEKY_Tasks:
* Implements tasks to keep track of player fatalities and civilian fatalities.

### OKS_AAC:
* Adds some QoL features for airframes including:
    * Adding ACE Action to swap seats
    * Replacing the ammunition of door gunners with a Yak-130 gatling gun for more accurate tracer fire.

### OKS_Ambience:
* Adds many ambience features including:
    * Enemy shouts, talking and muttering when players are nearby.
    * Changing AI faces to the specified nationality.
    * A Power generator which can toggle the light sources in a specified radius.
    * Surrender of enemy units if conditions met: (Flashbanged, Suppressed etc.)
    * Punishment of players upon loss of HVT or Hostage.

### OKS_Dynamic:
* THE Key module of the modern GOL Framework.
* Dynamic allows mission makers to place Game Logics in the editor and place a trigger area with given parameters.
* This will populate the given areas with contacts and spawn:
    * Checkpoints
    * Mortar Pits
    * Vehicle Pools etc.
* Units can be garrisoned or be set to patrol. The parameters allow for control over:
    * The number of enemies in the area.
    * The number of enemies on patrol.
    * How many vehicular contacts will be present, which is split between:
        * Light Vehicles
        * APCs
        * Armour
    * How many dynamic objectives are created.
    * How many checkpoints are created.
    * And a few more.


### OKS_Reinforcement:
* Allows player leaders to call for friendly reinforcements.
* The process is identical to the one mentioned in NEKY_Supply by navigating to **Request Support > Call Reinforcements**.

### OKS_Spawn:
* Adds a few more dynamic scripts such as:
    * Ambient AAA (Fires into sky for pretty tracer effects)
    * Creation of enemy convoys with ease. (All within the bounds of ArmA AI capabilities)
    * Ambient Artillery firing from Self Propelled Guns and SCUD launchers.
    * ...To name a few.

### OKS_Support:
* Adds the ability for leaders to call for CAS and precision strikes via the **Request Support** menu in ACE Self-Interaction.
* This can be achieved by the available units of:
    * Fixed-Wing with Guns.
    * Fixed-Wing with Rockets.
    * Fixed-Wing with Guns & Rockets.
    * Fixed-Wing with Missile.
    * Fixed-Wing with Bombs.


### OKS_Task:
* Adds additional tasks that the mission maker may use in their mission, which includes but is not limited to:
    * Escorting friendlies.
    * Reporting to and assisting injured friendlies/civilians.
    * Assistance by repairing damaged friendly vehicles.

### OKS_Vehicles:
* Adds an optional initialisation to vehicles that:
    * Increases their ACE Cargo Capacity.
    * May add spare parts.
    * May add NEKY_ServiceStation.
    * Adds a commander's smoke countermeasure to an available commander's seat.
    * Adds additional countermeasures to airframes.
    * And More!

#### BLU_SetChannel.sqf:
* Obtains the day of the week from a formula and will set the active Task Force Radio Teamspeak channel to either:
    * Thursday Operations.
    * Sunday Operations.

Many more changes to come in the future :D
