
params["_arguments","_code"]; 
_varName = ("SLT"+str (round random 10000)); 

TempCode = compile ("if(!isServer) exitWith{};_this call "+str _code+"; "+(_varName+" = nil;")); 
TempArgs = _arguments; 

call compile (_varName +" = [TempArgs,TempCode]; 
publicVariable '"+_varName+"'; 

[[], { 
("+_varName+" select 0) spawn ("+_varName+" select 1); 
}] remoteExec ['spawn',2];"); 
