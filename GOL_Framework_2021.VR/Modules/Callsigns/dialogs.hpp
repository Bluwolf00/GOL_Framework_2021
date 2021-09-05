class Blu_Callsign_Dialog
{
  idd = 999;
  movingEnabled = false;

  class controls
  {
    ////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Blu., v1.063, #Datuzi)
////////////////////////////////////////////////////////

    class Blu_rscPicture: RscPicture
    {
    	idc = 1200;

    	text = "#(argb,8,8,3)color(0.3,0.3,0.3,0.5)";
    	x = 0.37625 * safezoneW + safezoneX;
    	y = 0.39 * safezoneH + safezoneY;
    	w = 0.2475 * safezoneW;
    	h = 0.209 * safezoneH;
    };
    class RscPicture_1201: RscPicture
    {
    	idc = 1201;

    	text = "#(argb,8,8,3)color(0,0.2,0.6,1)";
    	x = 0.37625 * safezoneW + safezoneX;
    	y = 0.39 * safezoneH + safezoneY;
    	w = 0.2475 * safezoneW;
    	h = 0.022 * safezoneH;
    };
    class Blu_close: RscButton
    {
    	idc = 1600;
    	action = "closeDialog 0";

    	text = "Close"; //--- ToDo: Localize;
    	x = 0.577344 * safezoneW + safezoneX;
    	y = 0.5594 * safezoneH + safezoneY;
    	w = 0.04125 * safezoneW;
    	h = 0.033 * safezoneH;
    };
    class Blu_Apply: RscButton
    {
    	idc = 1601;
    	action = "[(lbCurSel 2101),(lbCurSel 2100)] call Blu_fnc_SetCallsign;";

    	text = "Apply"; //--- ToDo: Localize;
    	x = 0.525781 * safezoneW + safezoneX;
    	y = 0.5594 * safezoneH + safezoneY;
    	w = 0.04125 * safezoneW;
    	h = 0.033 * safezoneH;
    };
    class Blu_Combo_1: RscCombo
    {
    	idc = 2100;
    	OnMouseButtonClick = "(lbCurSel 2100) call Blu_fnc_ElementSelected;";

    	x = 0.37625 * safezoneW + safezoneX;
    	y = 0.445 * safezoneH + safezoneY;
    	w = 0.12375 * safezoneW;
    	h = 0.022 * safezoneH;
    };
    class Blu_RscIcon: RscPicture
    {
    	idc = 1202;

    	text = "Modules\Callsigns\Logo.paa";
    	x = 0.37625 * safezoneW + safezoneX;
    	y = 0.39 * safezoneH + safezoneY;
    	w = 0.0113438 * safezoneW;
    	h = 0.022 * safezoneH;
    };
    class Blu_Combo_2: RscCombo
    {
    	idc = 2101;

    	x = 0.37625 * safezoneW + safezoneX;
    	y = 0.511 * safezoneH + safezoneY;
    	w = 0.12375 * safezoneW;
    	h = 0.022 * safezoneH;
    };
    class Blu_Txt_Callsign: RscText
    {
    	idc = 1000;

    	text = "Callsign:"; //--- ToDo: Localize;
    	x = 0.37625 * safezoneW + safezoneX;
    	y = 0.489 * safezoneH + safezoneY;
    	w = 0.04125 * safezoneW;
    	h = 0.022 * safezoneH;
    };
    class RscText_1000: RscText
    {
    	idc = 1000;

    	text = "Element:"; //--- ToDo: Localize;
    	x = 0.37625 * safezoneW + safezoneX;
    	y = 0.423 * safezoneH + safezoneY;
    	w = 0.04125 * safezoneW;
    	h = 0.022 * safezoneH;
    };
    class Blu_HeaderTxt: RscText
    {
    	idc = 1002;

    	text = "Callsign Changer"; //--- ToDo: Localize;
    	x = 0.459781 * safezoneW + safezoneX;
    	y = 0.3834 * safezoneH + safezoneY;
    	w = 0.0670311 * safezoneW;
    	h = 0.033 * safezoneH;
    };
    class Blu_AAC_Number_txt: RscText
    {
    	idc = 1003;

    	text = "#"; //--- ToDo: Localize;
    	x = 0.510312 * safezoneW + safezoneX;
    	y = 0.511 * safezoneH + safezoneY;
    	w = 0.0103125 * safezoneW;
    	h = 0.022 * safezoneH;
    };
    class Blu_AAC_Number: RscEdit
    {
    	idc = 1400;
      maxChars = 1;
      canModify = 1;
    	x = 0.520625 * safezoneW + safezoneX;
    	y = 0.511 * safezoneH + safezoneY;
    	w = 0.0154688 * safezoneW;
    	h = 0.022 * safezoneH;
    };
    ////////////////////////////////////////////////////////
    // GUI EDITOR OUTPUT END
    ////////////////////////////////////////////////////////

  };
};
