

/*

	[Object,1,Number,TaskPosition,Side,ParentTask(BITaskObject)] spawn OKS_TASKSETUP;
	[TaskObject_1,1,GetMarkerPos "Task_1",west,Task_0] spawn OKS_TASKSETUP;
	[TaskObject_1,1,GetMarkerPos "Task_1",west,Task_0] spawn OKS_TASKSETUP;

*/

params [
	["_Object",[objNull],[]],
	["_TaskNumber",1,[0]],
	["_TaskPos",[0,0,0],[[]]],
	["_Side",[sideUnknown],[sideUnknown]],
	["_TaskParent",objNull,[objNull]]
];
private ["_TaskID","_TaskTitle","_TaskAction","_TaskDescription","_TaskMarkerText"];


/*

	Object: Can be any object, can also be unit
	Number: The number guides task to the definitions below, match the number to the case you with to use
	TaskPosition: Can be any type of pos, getPos object, getMarkerPos "marker" or [x,y,z]
	Side: The side of the players who will get the task
	TaskParent:

	Task Types:

	airdrop , armor , attack , backpack , boat , box , car , container , danger , default , defend
	destroy , documents , download , exit , getin , getout , heal , heli , help , intel , interact
	kill , land , listen , map , meet , mine , move(move1-5) , navigate , plane , radio , rearm
	refuel , repair , rifle , run , scout , search , takeoff , talk(talk1-5) , target , truck
	unknown , upload , use , wait , walk , whiteboard

*/


switch (_TaskNumber) do {

	case 1:{
		_TaskID = "OKS_TASK_1";
		_TaskTitle = "Intel: Ammo Cache";
		_TaskDescription = "Intel found suggests an ammo cache in the near vicintiy of the camp. Find it and destroy it, expect Insurgents in the area, they will protect their equipment.";
		_TaskAction = "Read Intel";
		_TaskMarkerText = "Ammo Cache";
		_TaskType = "Destroy";
		[_Object,_TaskID,_TaskAction,[_TaskID,_TaskTitle,_TaskDescription,_TaskMarkerText,_TaskPos,_TaskParent],_Side,_TaskNumber,_TaskType] spawn OKS_TASK;
	};

	case 2:{
		_TaskID = "OKS_TASK_2";
		_TaskTitle = "Intel: Ammo Cache";
		_TaskDescription = "Intel found suggests an ammo cache in the near vicintiy of the camp. Find it and destroy it, expect Insurgents in the area, they will protect their equipment.";
		_TaskAction = "Read Intel";
		_TaskMarkerText = "Ammo Cache";
		_TaskType = "Destroy";
		[_Object,_TaskID,_TaskAction,[_TaskID,_TaskTitle,_TaskDescription,_TaskMarkerText,_TaskPos,_TaskParent],_Side,_TaskNumber,_TaskType] spawn OKS_TASK;
	};

	case 3:{
		_TaskID = "OKS_TASK_3";
		_TaskTitle = "Intel: Insurgent Camp";
		_TaskDescription = "Intel found suggests an insurgent camp is in the near vicintiy of the cache. Investigate the camp";
		_TaskAction = "Read Document";
		_TaskMarkerText = "Possible Insurgent Camp";
		_TaskType = "attack";
		[_Object,_TaskID,_TaskAction,[_TaskID,_TaskTitle,_TaskDescription,_TaskMarkerText,_TaskPos,_TaskParent],_Side,_TaskNumber,_TaskType] spawn OKS_TASK;
	};

	case 4:{
		_TaskID = "OKS_TASK_4";
		_TaskTitle = "Intel: Unknown";
		_TaskDescription = "Intel found suggests insurgent activity in the compound marked on the map. Proceed with caution.";
		_TaskAction = "Read Document";
		_TaskMarkerText = "Possible Insurgent Camp";
		_TaskType = "unknown";
		[_Object,_TaskID,_TaskAction,[_TaskID,_TaskTitle,_TaskDescription,_TaskMarkerText,_TaskPos,_TaskParent],_Side,_TaskNumber,_TaskType] spawn OKS_TASK;
	};

	case 5:{
		_TaskID = "OKS_TASK_5";
		_TaskTitle = "Intel: Explosives Cache";
		_TaskDescription = "The doctor explains that they have been held hostage by Al-Shabab for weeks, and they have know where the insurgent explosives supplies are located. Check your map";
		_TaskAction = "Question Doctor";
		_TaskMarkerText = "Possible Insurgent Cache";
		_TaskType = "destroy";
		[_Object,_TaskID,_TaskAction,[_TaskID,_TaskTitle,_TaskDescription,_TaskMarkerText,_TaskPos,_TaskParent],_Side,_TaskNumber,_TaskType] spawn OKS_TASK;
	};

	case 6:{
		_TaskID = "OKS_TASK_6";
		_TaskTitle = "Intel: Convoy";
		_TaskDescription = "Intel found suggests a convoy of Insurgents are heading towards the town of Masakali. We assume they are planning to gather their forces for an attack on our positions in Geydam-Tchoukou. Reach the ambush-site and prepare an ambush. You must reach the ambush-site but you do not need to ambush at that specific position.";
		_TaskAction = "Read Map";
		_TaskMarkerText = "Convoy Ambush";
		_TaskType = "mine";
		[_Object,_TaskID,_TaskAction,[_TaskID,_TaskTitle,_TaskDescription,_TaskMarkerText,_TaskPos,_TaskParent],_Side,_TaskNumber,_TaskType] spawn OKS_TASK;
	};
};