_Objects = [];

{

_Pos = getPosWorld _X;
_Pos = ASLToAGL _Pos;
_VectorDir = Truck_1 vectorWorldToModel (VectorDir _X);
_VectorUp = VectorUp _X;
_AttachPos = Truck_1 worldToModel _Pos;
_Objects pushBack [typeOf _X,Truck_1,_AttachPos,_VectorDir,_VectorUp];

} foreach attachedObjects Truck_1;

CopyToClipboard str _Objects;

[["B_T_Mortar_01_F",trucK_1,[-0.175781,-1.16992,-0.426544],[-0.0263681,0.999192,0.0303417],[0.0017598,0.000660941,0.999998]],["Land_BagFence_01_short_green_F",trucK_1,[-1.07813,0.0253906,-0.65213],[0.999171,0.0407002,-0.00131648],[0.0237514,-0.0203115,0.999512]],["Land_BagFence_01_short_green_F",trucK_1,[0.923828,-0.0493164,-0.811462],[0.99997,-0.00716102,-0.00276867],[0.0227124,-0.0213302,0.999515]],["Land_BagFence_01_short_green_F",trucK_1,[-1.06445,-1.92529,-0.806274],[0.999952,-0.00943184,-0.00283742],[0.0226608,-0.0213761,0.999515]],["Land_BagFence_01_short_green_F",trucK_1,[0.953125,-1.96143,-0.810135],[0.99997,-0.00716102,-0.00276867],[0.0227124,-0.0213302,0.999515]]]