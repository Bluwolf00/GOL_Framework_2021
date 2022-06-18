/*
    Examples:
    _null = [[test_1,test_2,test_3],Prisoner_Trigger,1000] spawn OKS_HVT_MoraleHit_Intel;
    _null = [[test_1,test_2,test_3],Prisoner_Trigger,1000] execVM "Scripts\OKS_Ambience\OKS_HVT_MoraleHit_Intel.sqf";
*/
params [
    ["_HvtArray",[],[[]]],                    // #0 Array of Units - HVTs who can surrender
    ["_PrisonerArea",objNull,[objNull]],      // #1 Prisoner Area - Named Trigger set to Activation:Anybody, set to repeatable.
    ["_MoraleImpactRange",600,[1]],           // #2 Morale Impact Range - Meters around the HVT that will receive reduced skill (only spawned units)
    ["_PlayerSide",west,[sideUnknown]]        // #3 Player Side for HQ Message    
];

if(!isServer) exitWith {false};

private _Debug_Variable = false;
private ["_Location","_RevealMarker","_ShouldCreateTask","_TaskTitle","_TaskDescription","_TaskMarker","_ShouldSendChatMessage","_ChatMessage","_IntelArray","_TaskName"];
Private ["_Chance","_Range","_ThreatByShot","_SurrenderByFlash"];

    /* Surrender Settings - Can be adjusted */
    _Chance = 0.5;            // 0-1 - 0 = 0%, 1 = 100%
    _Range = 25;              // Range to enable code to look for threats. Keep below 30.
    _ThreatByShot = true;     // Should be able to threaten HVT by shooting him. Doubled chance of surrender.
    _SurrenderByFlash = true; // Should be able to force surrender of HVT by throwing a flash within 10m of him.

OKS_Global_IntelArray = [
     [
        /* Intel ID - Must be unique! */ 1,
        /* Marker/Object/Position */ "ied_1",
        /* Array of Markers to be revealed (If you have additional markers to reveal upon intel received) */ nil,
        /* Should Reveal Marker */ true,
        /* Should Create Task */ false,
        /* Task Title */ "Intel: IEDs",
        /* Task Description */ "You have received intel of a minefield of IEDs in the area of operations.",
        /* Task Icon */ "mine",
        /* Should Send HQ Chat Message */ true,
        /* Chat Message */ "1-1 this is HQ, new intel on IEDs in your area of operations. Check your map, HQ out."
    ]                        
];
publicVariable "OKS_Global_IntelArray";

Private _HQ = "";
/* Assign HQ Callsign */
switch (_PlayerSide) do {
    case west: { _HQ = "PAPA_BEAR" };
    case east: { _HQ = "OPF" };
    case independent: { _HQ = "IND" };
    default { _HQ = "HQ"};
};

/* Impact Morale Method */
OKS_ImpactMorale = {
    Params ["_Unit","_Range"];
    _TroopsInRange = AllUnits select {!isPlayer _X && side _X == [_Unit] call GW_Common_Fnc_getSide && _X distance2D _Unit < _Range};
    if(count _TroopsInRange > 0) then {
        {[_x,3] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach _TroopsInRange;
    };
};

/* Intel Method */
OKS_ReceiveIntel = {
    params [
        ["_IntelID",nil,[0]],
        ["_Location",[0,0,0],["",objNull,[]]],
        ["_AdditionalMarkers",nil,["",[]]],                
        ["_RevealMarker",true,[true]],                   
        ["_ShouldCreateTask",false,[true]],          
        ["_TaskTitle","Intel",[""]],       
        ["_TaskDescription","You have secured new intel from an HVT capture.",[""]],
        ["_TaskIcon","destroy",[""]],
        ["_ShouldSendChatMessage",true,[true]],
        ["_ChatMessage","Be advised new intel received.",[""]],
        ["_ParentTaskId",nil,[""]],
        ["_HQ","HQ",[""]]
    ];
    Private ["_Position","_Marker","_TaskName","_ExitScript"];
    if(typeName _Location == "STRING") then {
        _Position = getMarkerPos _Location;
        _Marker = _Location;
    };
    if(typeName _Location == "OBJECT") then {
        _Position = _Location;
        _Marker = nil;
    };
    if(typeName _Location == "ARRAY") then {
        _Position = _Location;
        _Marker = createMarker [format["OKS_HVT_Intel_TaskMarker_%1",round((random 99999) - (random 99999))], _Position];
        [_Marker,"hd_dot"] remoteExec ["setMarkerType",0];
        [_Marker,_TaskTitle] remoteExec ["setMarkerText",0];
    };

    if(_RevealMarker && !isNil "_Marker") then {
        [_Marker,1] remoteExec ["setMarkerAlpha",0];
    };
    if(_RevealMarker && !isNil "_AdditionalMarkers") then{
        { [_X,1] remoteExec ["setMarkerAlpha",0] } foreach _AdditionalMarkers;
    };
  

    if(_ShouldCreateTask) then {
        // If it's Object and its already dead when intel is given. Different message.
        if(typeName _Position == "OBJECT") then {
            if(!Alive _Position) exitWith {
                _TaskName = [true,[format["OKS_HVT_Intel_Task_%1",round((random 99999) - (random 99999))]],[_TaskDescription,_TaskTitle,"Intel"],_Position,"SUCCEEDED",-1, true,_TaskIcon, false] call BIS_fnc_taskCreate;
                [_HQ,"side","HQ to all units, the intel extracted is out of date, it seems youve already neutralized the threat, HQ out."] remoteExec ["OKS_Chat",0];
            };
            if(!isNil "_ParentTaskId") then {
                _TaskName = [true,[format["OKS_HVT_Intel_Task_%1",round((random 99999) - (random 99999))],_ParentTaskId],[_TaskDescription,_TaskTitle,"Intel"],_Position,"CREATED",-1, true,_TaskIcon, false] call BIS_fnc_taskCreate;
            } else {
                _TaskName = [true,[format["OKS_HVT_Intel_Task_%1",round((random 99999) - (random 99999))]],[_TaskDescription,_TaskTitle,"Intel"],_Position,"CREATED",-1, true,_TaskIcon, false] call BIS_fnc_taskCreate;
            };
        } else {
            if(!isNil "_ParentTaskId") then {
                _TaskName = [true,[format["OKS_HVT_Intel_Task_%1",round((random 99999) - (random 99999))],_ParentTaskId],[_TaskDescription,_TaskTitle,"Intel"],_Position,"CREATED",-1, true,_TaskIcon, false] call BIS_fnc_taskCreate;
            } else {
                _TaskName = [true,[format["OKS_HVT_Intel_Task_%1",round((random 99999) - (random 99999))]],[_TaskDescription,_TaskTitle,"Intel"],_Position,"CREATED",-1, true,_TaskIcon, false] call BIS_fnc_taskCreate;
            };
        };

        if(_ShouldCreateTask && toLower (_TaskName call BIS_fnc_taskState) isEqualTo "succeeded") exitWith { _ExitScript = true; if(_Debug_Variable) then { systemChat "Task already succeeded. Exiting before WaitUntil."}};  

        _WaitUntilDestroyedOrNearby = [_TaskName,_Position] spawn {
            Params["_TaskName","_Location"];
            if(typeName _Location == "OBJECT") then {
                waitUntil{sleep 10; !Alive _Location};
                [_TaskName,"SUCCEEDED"] call BIS_fnc_taskSetState;
            } else {
                waitUntil{sleep 10; count ((_Location nearEntities ["Man",100]) select {isPlayer _X}) > 0};
                [_TaskName,"SUCCEEDED"] call BIS_fnc_taskSetState;
            };
        };
    };
    if(_ExitScript) exitWith {};  
    if(_ShouldSendChatMessage && !isNil "_ChatMessage") then {
        [_HQ,"side",_ChatMessage] remoteExec ["OKS_Chat",0];
    };        
};

/* Setup of HVTs with Surrender Module */
    { 
        [_X,_Chance,_Range,_ThreatByShot,_SurrenderByFlash] spawn OKS_Surrender;
        if(_Debug_Variable) then { systemChat format ["OKS_Surrender - HVT: %1",_X]};

        // _DeleteId = _SelectedIntel select 0;
        // _IntelArray deleteAt (_IntelArray findIf {(_x select 0) == _DeleteId});
        _WaitForDeathOrCapture = [_X,_MoraleImpactRange,_PrisonerArea,_HQ,_Debug_Variable] spawn {
            Params ["_Unit","_ImpactRange","_PrisonerArea","_HQ","_Debug_Variable"];
            waitUntil{sleep 5; !alive _Unit || _Unit in (list _PrisonerArea) || (objectParent _Unit) in (list _PrisonerArea)};

            if(!alive _Unit) then {
                [_Unit,_ImpactRange] spawn OKS_ImpactMorale;
                [true,[format["OKS_HVT_Killed_Task_%1",round((random 99999) - (random 99999))]],["You have killed a high-value target in the area of operations. This have negatively impacted the morale of forces in the area, they will fight with less resolve now. Good work!","HVT Killed","Intel"],_Unit,"SUCCEEDED",-1, true,"kill", false] call BIS_fnc_taskCreate;
                if(_Debug_Variable) then { systemChat format ["Morale impacted around HVT: %1 - Range %2",_Unit,_ImpactRange]};
            } else {
                if(_Debug_Variable) then { systemChat format ["Intel HVT: %1",_Unit]};
                Private _Parent = [true,[format["OKS_HVT_Captured_Task_%1",round((random 99999) - (random 99999))]],["You have captured a high-value target in the area of operations. Let the team at base interrogate the HVT for intel, expect an updated momentarily.","HVT Captured","Intel"],_Unit,"SUCCEEDED",-1, true,"exit", false] call BIS_fnc_taskCreate;
                sleep 10;
                _SelectedIntel = selectRandom OKS_Global_IntelArray;
                if(!isNil "_SelectedIntel") then {
                    OKS_Global_IntelArray deleteAt (OKS_Global_IntelArray find _SelectedIntel);
                    publicVariable "OKS_Global_IntelArray";
                } else {
                    _SelectedIntel = [];
                };
                if(count _SelectedIntel > 0) then {
                    _SelectedIntel pushBack _Parent;
                    _SelectedIntel pushBack _HQ;
                    _SelectedIntel spawn OKS_ReceiveIntel;    
                } else {
                    [_HQ,"side","HQ to all units, we were unable to extract intel from the HVT. HQ out!"] remoteExec ["OKS_Chat",0];
                }             
            }
        };
    } foreach _HvtArray;
/* Setup of HVTs Complete */



