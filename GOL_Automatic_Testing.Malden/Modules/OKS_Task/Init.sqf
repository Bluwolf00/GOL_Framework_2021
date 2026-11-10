/*
    Create NEKY Civilian / Death Count Tasks
*/
[] spawn {
    UISleep 1; // Without this sleep, no tasks will be created in the briefing screen. Do not place ANY more sleeps, just place all the tasks one after the other.

    // YOU CAN EDIT THINGS BELOW THIS LINE \\
    // Tasks
    [1,["NEKY_Task1",["Hearts and Minds: Avoid causing civilian casualties as that will turn the civilians against us, bolstering enemy reinforcements.","Avoid Civilian Casualties"],civilian,{}],true] spawn OKS_fnc_TaskRun;
    [2,["NEKY_Task2",["War Support: Dont die, we will lose war support back home.","Avoid Deaths"],sideEmpty,{}],true] spawn OKS_fnc_TaskRun;
};