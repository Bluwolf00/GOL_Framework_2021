

/*

	[Object,1,Number,TaskPosition,Side,ParentTask(BITaskObject)] spawn OKS_TASKSETUP;
	[TaskObject_1,1,GetMarkerPos "Task_1",west,Task_0] spawn OKS_TASKSETUP;
	[TaskObject_1,1,GetMarkerPos "Task_1",west,Task_0] spawn OKS_TASKSETUP;

*/

params ["_Object","_TaskNumber","_TaskPos","_Side","_TaskParent"];
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
		_TaskTitle = "Destroy Stockpile";
		_TaskDescription = "Intel found suggests a weapons cache west of Oreokastro. Expect enemy resistance in the area.";
		_TaskAction = "Download Intel";
		_TaskMarkerText = "Stockpile";
		_TaskType = "destroy";
		[_Object,_TaskID,_TaskAction,[_TaskID,_TaskTitle,_TaskDescription,_TaskMarkerText,_TaskPos,_TaskParent],_Side,_TaskNumber,_TaskType] spawn OKS_TASK;
	};

	case 2:{
		_TaskID = "OKS_TASK_2";
		_TaskTitle = "Neutralize Enemy Reserves";
		_TaskDescription = "Enemy reserves are located north-west. Eliminate them!";
		_TaskAction = "Download Intel";
		_TaskMarkerText = "Reserves";
		_TaskType = "attack";
		[_Object,_TaskID,_TaskAction,[_TaskID,_TaskTitle,_TaskDescription,_TaskMarkerText,_TaskPos,_TaskParent],_Side,_TaskNumber,_TaskType] spawn OKS_TASK;
	};


};