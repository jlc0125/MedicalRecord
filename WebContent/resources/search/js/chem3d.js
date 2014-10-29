/////////////////////////////////////////////////////////////////////////////////////////////
//
// This is a Javascript library to write multi-browser pages comprising CS Chem3D Plugin/ActiveX.
//
//
// You will use the following three functions in your web pages:
//
//   c3d_insert3dStr(str)		- insert a chem3d object
//   c3d_getObject(name)		- get the chem3d object by its name
//
//
//  
// To support other browsers outside IE and Netscape, you should change the following function:
//   c3d_figureOutUsing()
//
// Usually there is no need for you to change any other variables or functions.
//
//
// All Rights Reserved.
//
// ***PLEASE DON'T FORGET TO CHANGE THE VERSION NUMBER BELOW WHEN CHANGING THIS FILE***
// (version 2.001) May 24, 2005
/////////////////////////////////////////////////////////////////////////////////////////////



// ------------------------------------- GLOBAL DATA -------------------------------------------
// Global data. VERY IMPORTANT: Once correctly set, never never change these.
// MAINTAIN: This must use the value for the latest version in CLSID_Chem3DControl / Chem3D: clsid.h
var C3D_CLSIDs = {  "12" : "clsid:b19a6c27-ce23-4d91-832d-00579fd48859",
					"11" : "clsid:76c5059a-f5b2-4970-9c66-9c36104d025c",
					"10" : "clsid:7fb47cb1-a3d0-4fa1-8475-832a6a166d5a",
					"9" : "clsid:9277934e-a149-4bbe-86ab-ed37ebf719e4",
					"8" : "clsid:B7A6B8E4-3E8B-4D18-8F8F-B4057EFC784B",
					"7" : "clsid:ca0fc5f6-a99e-11d4-8e31-0050daeaf0a5"
				};

var C3D_VER = "12";
var C3D_CONTROL_CLSID = C3D_CLSIDs[C3D_VER];

// These three files should be placed in the same folder as the three .js files.

var C3D_PLUGIN_JAR	= "camsoft.jar";
var C3D_PLUGIN_CAB	= "camsoft.cab";
var C3D_PLUGIN_CAB2	= "camsoft2.cab";


// MOST IMPORTANT!!! To indicate which Plugin/ActiveX to use
// 1 - Control/ActiveX;  2 - old Plugin;  3 - new Plugin.

var whichbrowser = 0;
var js_canUseTry = false;

// Default threshold can be overridden by declaring it previously in page
if (!c3d_plugin_threshold) var c3d_plugin_threshold = 5.0;

// !DGB! 12/01
// Declare global array to hold the names of c3d_objects in the page
var c3d_objectArray = new Array();


// ------------------------------------- TODO AREA -------------------------------------------
// You may change this section when configuring for your website.


// These two variables define the URL for downloading the Plugin/ActiveX control. You may change
// it to your own download address if you choose.

if (!C3D_AUTODOWNLOAD_PLUGIN) {
	var C3D_AUTODOWNLOAD_PLUGIN  = "http://accounts.cambridgesoft.com/login.cfm?serviceid=11&fp=true";
}
var C3D_AUTODOWNLOAD_ACTIVEX = C3D_AUTODOWNLOAD_PLUGIN;


/////////////////////////////////////////////////////////////////////////////////////////////
// This function is very important; I is run before anything else, to figure out which
// Plugin/ActiveX control should be used.
// If you would like to configure this to recognize other types of browsers (by default, only
// MS Internet Explorer and Netscape are recognized) you may add to this function.

function c3d_figureOutUsing() {

	// Chem3D Plugin isn't availabe on IE, MAC
	if (c3d_IsMacWithIE()) {
		whichbrowser = 0;
		return;
	}


	// Only 1, 2, 3 are used. Other codes make no sense.
	// 1 - Control/ActiveX;  2 - old Plugin;  3 - new Plugin.
	
	var version = c3d_getBrowserVersion();
	
	// CURRENT SETTING:
	//    ActiveX Control (1) - IE 5.5 or higher versions
	//    old Plugin      (2) - IE 5.0 or lower versions, Netscape 4.x or lower versions
	//    new Plugin      (3) - Netscape 6.0 or higher versions
	if (c3d_testBrowserType("Microsoft Internet Explorer")) {
		if (version < c3d_plugin_threshold)
			whichbrowser = 2;
		else
			whichbrowser = 1;
		if (version >= 5.5)
			js_canUseTry = true;
	}
	else if (c3d_testBrowserType("Netscape")) {
		if (version < 5.0)
			whichbrowser = 2;
		else if (version >= 5.0)
			whichbrowser = 3;
		if (version >= 5.0)
			js_canUseTry = true;
	}


	// TODO: add code to support other browsers beside IE and Netscape
	// else if (...)
	//		whichbrowser = 1 or 2 or 3;


	// Unknown browser type.
	else
		whichbrowser = 0;

}




// -------------------------------- FUNCTIONS USED IN WEB PAGES --------------------------------------
// The following three functions will be used in web pages


/////////////////////////////////////////////////////////////////////////////////////////////
// This function is used to insert a browser-specific Plugin/ActiveX Control object using
// a string to specify parameters.
// Parameter - tagStr - should be like following sample:
// c3d_insertObjectStr("<EMBED src='HTML/blank.cdx' align='baseline' border= '0' width='267' height='128' type= 'chemical/x-cdx' name= 'myCDX'>");

function c3d_insert3dStr(tagStr) {
	var paraArray = {"dataurl" : "", "src" : "", "mimetype" : "", "backgroundcolor" : "", "backgroundeffect" : "",
		"rotationbar" : "", "toolbar" : "", "contextmenu" : "", "fittowindow" : "", "displaymode" : "", "ligandmode" : "",
		"rotation" : "", "width" : "", "height" : "", "name" : "", "displaytype" : "", "bgcolor" : "", "ligandtype" : ""};

	c3d_parsePara(tagStr, paraArray);
	
	if (paraArray["displaytype"] != "")
		paraArray["displaymode"] = paraArray["displaytype"];
	
	if (paraArray["bgcolor"] != "")
		paraArray["backgroundcolor"] = paraArray["bgcolor"];
	
	if (paraArray["ligandtype"] != "")
		paraArray["ligandmode"] = paraArray["ligandtype"];

	c3d_insert3d(paraArray["src"], paraArray["width"], paraArray["height"], 
		paraArray["displaymode"], paraArray["backgroundcolor"],
		paraArray["name"], paraArray["dataurl"], paraArray["ligandmode"],
		paraArray["toolbar"], paraArray["rotationbar"], paraArray["contextmenu"], paraArray["backgroundeffect"],
		paraArray["fittowindow"], paraArray["rotation"], paraArray["mimetype"]);
}


/////////////////////////////////////////////////////////////////////////////////////////////
// This function is used to insert a browser-specific Plugin/ActiveX Control object using
// specific parameters.
// The first 3 parameters [mimeType, objWidth, objHeight] are required, and the rest are optional.

function c3d_insert3d(src, width, height, displaymode, backgroundcolor, name, dataurl, ligandmode, toolbar, rotationbar, 
	contextmenu, backgroundeffect, fittowindow, rotation, mimetype) {
	
	var buf;
	if (whichbrowser == 1) {
	
		//!DGB! 12/01 Add a call to c3d_AddToObjectArray
		c3d_AddToObjectArray(name);
		buf = c3d_insertactivex(src, width, height, displaymode, backgroundcolor, name, dataurl, ligandmode, toolbar, rotationbar, 
			contextmenu, backgroundeffect, fittowindow, rotation, mimetype);
	
	} else if (whichbrowser == 2 || whichbrowser == 3) {

		//!DGB! 12/01 Add a call to c3d_AddToObjectArray
		c3d_AddToObjectArray(name);
		buf = c3d_insertplugin(src, width, height, displaymode, backgroundcolor, name, dataurl, ligandmode, toolbar, rotationbar, 
			contextmenu, backgroundeffect, fittowindow, rotation, mimetype);
			
	} else {
	
		buf = "<P><font color=red>\"ALERT: The Chem3D Plugin is not available for Internet Explorer on the Macintosh!\"</font></P>";
	}
	
	document.write(buf);
}


/////////////////////////////////////////////////////////////////////////////////////////////
// Use this function to insert a Plugin/ActiveX Control wrapper file.

function c3d_includeWrapperFile(basePath, checkInstall) {
	if (basePath == null)
		basePath = "";

	if (checkInstall == null)
		checkInstall = true;

	if (basePath.length > 0) {
		var lastChar = basePath.charAt(basePath.length - 1);
		if (!(lastChar == "\\" || lastChar == "/"))
			basePath += "\\";
		
		// all these files should be place in the same folder as the three js files.
		C3D_PLUGIN_JAR	= basePath + "camsoft.jar";
		C3D_PLUGIN_CAB	= basePath + "camsoft.cab";
		C3D_PLUGIN_CAB2	= basePath + "camsoft2.cab";
	}


	if (whichbrowser >= 1 && whichbrowser <=3) {
		var wrapperfile = "<script language=JavaScript src=\"";
	
		if (whichbrowser == 2 || whichbrowser == 3)
			// Plugin uses cdlib_ns.js wrapper file
			wrapperfile += basePath + "cdlib_ns.js";
		else if (whichbrowser ==  1)
			// ActiveX Control uses cdlib_ie.js wrapper file
			wrapperfile += basePath + "cdlib_ie.js";
			
		wrapperfile += "\"></script>";

		document.write(wrapperfile);
	}


	// auto-download Plugin/ActiveX
	// If you don't like the auto-download feature, remove the following 4 lines
	if (checkInstall) {
		C3D_CONTROL_CLSID = "";
		C3D_VER = "";
		
		if (whichbrowser == 2 || whichbrowser == 3) {
			if (c3d_isCDPluginInstalled() == false)
				c3d_installNetPlugin();
		}
		else if (whichbrowser == 1) {
			if (c3d_isCDActiveXInstalled() == false)
				c3d_installNetActiveX();
//			else if (C3D_CONTROL_CLSID == C3D_CONTROL60CLSID) {
//				if (confirm("You are using the 6.0 ActiveX Control.  We strongly recommend that you" +
//					" upgrade to 9.0, or the page may not be correctly displayed.\nDo you want to install it now?"))
//					window.open(C3D_AUTODOWNLOAD_ACTIVEX);
//		}
	}
	}
}




// ------------------------------------- INTERNAL FUNCTIONS DEFINATION -------------------------------------------
// You may never change following codes.


/////////////////////////////////////////////////////////////////////////////////////////////
// At first, run figureOutUsing() to initilize *currentUsing*.

c3d_figureOutUsing();


/////////////////////////////////////////////////////////////////////////////////////////////
// !DGB! 12/01 This function appends an element to the c3d_objectsArray. 
// The array contains the names of all cd objects in the page
	
function c3d_AddToObjectArray(objName) {
	c3d_objectArray[c3d_objectArray.length] = objName;
}


/////////////////////////////////////////////////////////////////////////////////////////////
// According to browser type and version, choose its corresponding Chem3D Plugin/ActiveX tag.
// The first 3 parameters [mimeType, objWidth, objHeight] is required, and the last 5 is optional.


function c3d_insertactivex(src, width, height, displaymode, backgroundcolor, name, dataurl, ligandmode, toolbar, rotationbar, 
	contextmenu, backgroundeffect, fittowindow, rotation, mimetype) {
	
	var s;
	if (C3D_CONTROL_CLSID == null || C3D_VER == null || C3D_CONTROL_CLSID == "" || C3D_VER == "")
	{
		if (navigator.platform.indexOf("Win") == -1)
		{
			s  = "<SPAN STYLE=\"color:red\">Sorry! We support only Window system.</SPAN>\n";
		}
		else if (c3d_testBrowserType("Netscape"))
		{
			s  = "<SPAN STYLE=\"color:red\">Sorry! You are using Netscape browser that we do not support.</SPAN>\n";
		}
		else
		{
			s  = "<SPAN STYLE=\"color:red\">Chem3D ActiveX control failed to load! -- Did you install Chem3D ActiveX control software? If not, <a href='";
			s += C3D_AUTODOWNLOAD_ACTIVEX + "'>install from here</a>.</SPAN>\n";
		}
	}
	else
	{
		if (src == null)
			src = "";
		if (name == null)
			name = "Chem3DControl";
		if (!(width > 0))
			width = 200;
		if (!(height > 0))
			height = 200;
			
		s =	"<OBJECT name=\"" + name + "\" CLASSID=\"" + C3D_CONTROL_CLSID + "\" width=" + width + " height=" + height + ">\n";
		s += "	<param name=SRC value=\"" + src + "\">\n";
		if (displaymode != null && displaymode != "")
		{
			if (C3D_VER > 9)
				s += "	<param name=DISPLAYMODE value=\"" + displaymode + "\">\n";
			else
				s += "	<param name=DISPLAYTYPE value=\"" + displaymode + "\">\n";
		}
		if (backgroundcolor != null && backgroundcolor != "")
		{
			if (C3D_VER > 9)
				s += "	<param name=BACKGROUNDCOLOR value=\"" + backgroundcolor + "\">\n";
			else
				s += "	<param name=BGCOLOR value=\"" + backgroundcolor + "\">\n";
		}
		if (dataurl != null && dataurl != "")
			s += "	<param name=DATAURL value=\"" + dataurl + "\">\n";
		if (ligandmode != null && ligandmode != "")
		{
			if (C3D_VER > 9)
				s += "	<param name=LIGANDMODE value=\"" + ligandmode + "\">\n";
			else
				s += "	<param name=LIGANDTYPE value=\"" + ligandmode + "\">\n";
		}
		if (toolbar != null && toolbar != "")
			s += "	<param name=TOOLBAR value=\"" + toolbar + "\">\n";
		if (rotationbar != null && rotationbar != "")
			s += "	<param name=ROTATIONBAR value=\"" + rotationbar + "\">\n";
		if (contextmenu != null && contextmenu != "")
			s += "	<param name=CONTEXTMENU value=\"" + contextmenu + "\">\n";
		if (backgroundeffect != null && backgroundeffect != "")
			s += "	<param name=BACKGROUNDEFFECT value=\"" + backgroundeffect + "\">\n";
		if (fittowindow != null && fittowindow != "")
			s += "	<param name=FITTOWINDOW value=\"" + fittowindow + "\">\n";
		if (rotation != null && rotation != "")
			s += "	<param name=ROTATION value=\"" + rotation + "\">\n";
		if (mimetype != null && mimetype != "")
			s += "	<param name=MIMETYPE value=\"" + mimetype + "\">\n";
			
		s += "	<SPAN STYLE=\"color:red\">Chem3D ActiveX control failed to load! -- Please check the security setting of your browser.</SPAN>\n";
		s +=	"</OBJECT>\n";
	}

	return s;
}

var c3d_pluginID = 1000;

function c3d_insertplugin(srcFile, objWidth, objHeight, displaymode, backgroundcolor, objName, dataURL, ligandmode, toolbar, rotationbar, 
	contextmenu, backgroundeffect, fittowindow, rotation, mimetype) {

	var pluginID = ++c3d_pluginID;
	
	if (objName == null)
		objName == "";

	if (srcFile == null)
		srcFile == "";
		
	var buf = "";
				
	buf +=	"<EMBED " +
			"src=\"" + srcFile + "\"" + 
			" width=\"" + objWidth + "\"" +
			" height=\"" + objHeight + "\"" +
			" type=\"" + "chemical/x-chem3d" + "\"";

	if (whichbrowser == 3) {
		// In netscape 6, we get data directly from the plugin, not the applet
		if (objName != null && objName != "")
			buf += " name=\"" + objName + "\"";
	}

	if (whichbrowser == 2) 
		buf += " id=\"" + pluginID + "\"";
		
	if (dataURL != null && dataURL != "")
		buf += "DATAUTRL =\"" + dataURL + "\"";

	if (backgroundcolor != null && backgroundcolor != "")
		buf += "BACKGROUNDCOLOR =\"" + backgroundcolor + "\"";

	if (displaymode != null && displaymode != "")
		buf += "DISPLAYMODE =\"" + displaymode + "\"";

	if (ligandmode != null && ligandmode != "")
		buf += "LIGANDMODE =\"" + ligandmode + "\"";

	if (ligandmode != null && ligandmode != "")
		buf += " =\"" + ligandmode + "\"";

	if (toolbar != null && toolbar != "")
		buf += "TOOLBAR =\"" + toolbar + "\"";

	if (rotationbar != null && rotationbar != "")
		buf += "ROTATIONBAR =\"" + rotationbar + "\"";

	if (contextmenu != null && contextmenu != "")
		buf += "CONTEXTMENU =\"" + contextmenu + "\"";

	if (backgroundeffect != null && backgroundeffect != "")
		buf += "BACKGROUNDEFFECT =\"" + backgroundeffect + "\"";

	if (fittowindow != null && fittowindow != "")
		buf += "FITTOWINDOW =\"" + fittowindow + "\"";

	if (rotation != null && rotation != "")
		buf += "ROTATION =\"" + rotation + "\"";

	if (mimetype != null && mimetype != "")
		buf += "MIMETYPE =\"" + mimetype + "\"";

	buf += ">\n";
	return buf;
}


/////////////////////////////////////////////////////////////////////////////////////////////
// This function to return the reference of Chem3D Plugin/ActiveX by its name.

function c3d_getObject(nm) {
	var r = null;

	if (whichbrowser == 1) // ActiveX Control
		r = document.all(nm);
	else if (whichbrowser == 2) // old Plugin + CDPHelper
		r = document.applets[nm];
	else if (whichbrowser == 3) // new Plugin (XPCOM, scriptable old Plugin)
		r = document.embeds[nm];

	if (r == null)
		alert("ERROR: You have the wrong name [" + nm + "] to refer to the Plugin/ActiveX !!!");

	return r;
}


/////////////////////////////////////////////////////////////////////////////////////////////
// To get Browser's version.

function c3d_getBrowserVersion() {
	if (c3d_testBrowserType("Microsoft Internet Explorer")) {
		var str = navigator.appVersion;
		var i = str.indexOf("MSIE");
		if (i >= 0) {
			str = str.substr(i + 4);
			return parseFloat(str);
		}
		else
			return 0;
	}
	else
		return parseFloat(navigator.appVersion);
}


/////////////////////////////////////////////////////////////////////////////////////////////
// To test Browser's type.

function c3d_testBrowserType(brwType) {
	return (navigator.appName.indexOf(brwType) != -1);
}


/////////////////////////////////////////////////////////////////////////////////////////////
// To test if IE runs on MAC.

function c3d_IsMacWithIE() {
	return c3d_testBrowserType("Microsoft Internet Explorer") && (navigator.platform.indexOf("Mac") != -1 || navigator.platform.indexOf("MAC") != -1);
}


/////////////////////////////////////////////////////////////////////////////////////////////
// To test whether Plugin is installed on locall machine.

function c3d_isC3DPluginInstalled() {
	if (c3d_testBrowserType("Microsoft Internet Explorer")) {
		var str =
		"<div style='left:0;top:0;zIndex:1;position:absolute'><applet code='camsoft.cdp.CDPHelperAppSimple2' width=0 height=0 name='test_plugin'><param name=ID value=99999><param NAME=cabbase value='" + C3D_PLUGIN_CAB2 + "'></applet></div>" +
		"<SCRIPT LANGUAGE=javascript>" +
		"	var testpluginonlyonce = false;" +
		"	function document_onmouseover() {" +
		"		if (!testpluginonlyonce) {" +
		"			testpluginonlyonce = true;" +
		"			var pluginstalled = false;" +
		"			pluginstalled = document.applets[\"test_plugin\"].isLoaded();" +
		"			if (!pluginstalled) {" +
		"				C3D_PLUGIN_JAR = \"\";" +
		"				C3D_PLUGIN_CAB = \"\";" +
		"				c3d_installNetPlugin();" +
		"			}" +
		"		}" +
		"	}" +
		"</" + "SCRIPT>" +
		"<SCRIPT LANGUAGE=javascript FOR=document EVENT=onmouseover>document_onmouseover()</" + "SCRIPT>";
		
		document.write(str);
		
		return true;
	}
	
	for (var i = 0; i < navigator.plugins.length; ++i) {
		if (navigator.plugins[i].name.indexOf("Chem3D") != -1)
			return true;
	}
	
	return false;
}


/////////////////////////////////////////////////////////////////////////////////////////////
// To  install NET plugin on local machine.

function c3d_installNetPlugin() {
	if (confirm("You currently use " + navigator.appName + " " + c3d_getBrowserVersion() + ".\n" +
		"This page will use CS Chem3D Plugin, but it isn't installed on your computer.\n" +
		"Do you want to install it now?")) {
		window.open(C3D_AUTODOWNLOAD_PLUGIN);
	}
	else {
		C3D_PLUGIN_JAR = "";
		C3D_PLUGIN_CAB = "";
	}
}


/////////////////////////////////////////////////////////////////////////////////////////////
// To test whether ActiveX is installed on local machine.

function c3d_isCDActiveXInstalled() {
	// Note: try ... catch ... statement isn't available in JavaScript 1.4 (IE 4 uses js 1.4).
	// That means that try/catch code can't even exist if we're using an earlier version of JavaScript
	//  so we have to wrap it as a string.  If we're using a sufficiently-recent browser (that has
	//  a version of JavaScript 1.4 or later), we'll eval the string, which will end up doing a try/catch
	//  For older browsers, we'll just do things the old way, and suffer through any performance penalties.
	
	var retval = false;

	if (js_canUseTry) {
		var str = "";
		for (var ver in C3D_CLSIDs) {
			var clsid = C3D_CLSIDs[ver];
			var progid = "ChemDrawControl" + ver + ".ChemDrawCtl";
			
			str = str + "try\n";
			str = str + "{\n";
			str = str + "	var obj" + ver + " = new ActiveXObject(\"" + progid + "\");\n";
			str = str + "	C3D_CONTROL_CLSID = C3D_CLSIDs[\"" + ver + "\"];\n";
			str = str + "	C3D_VER = " + ver + ";\n";
			str = str + "	retval = true;\n";
			str = str + "} catch(e" + ver + ")\n";
			str = str + "{\n";
		}
		
		for (var i = 0; i < C3D_CLSIDs.length; ++i) {
			if (i == 0) {
				str = str + "   retval = false;\n";
			}
			str = str + "}\n";
		}
		
		eval(str);
	} else {
		for (var ver in C3D_CLSIDs) {
			var clsid = C3D_CLSIDs[ver];
			var tagname = "test_" + ver;
			
			document.write("<OBJECT NAME=\"" + tagname + "\" WIDTH=0 HEIGHT=0 CLASSID=\"" + clsid + "\"><param NAME=ViewOnly VALUE=true></OBJECT>");
			if (document.all(tagname).Selection != null)	{
				C3D_CONTROL_CLSID = clsid;
				C3D_VER = ver;
				retval = true;
				break;
			}
		}
	}

	return retval;
}


/////////////////////////////////////////////////////////////////////////////////////////////
// To  install NET plugin on locall machine.

function c3d_installNetActiveX() {
	if (confirm("You currently use " + navigator.appName + " " + c3d_getBrowserVersion() + ".\n" +
		"This page will use CS Chem3D ActiveX control, but it isn't installed on your computer.\n" +
		"Do you want to install it now?")) {
		window.open(C3D_AUTODOWNLOAD_ACTIVEX);
	}
}


/////////////////////////////////////////////////////////////////////////////////////////////
// This function to parse all useful parameter from <EMBED> string. Return values is
// stored an array.
// <embed width="200" HEIGHT="200" type="chemical/x-cdx" src="mols/blank.cdx" dataurl="mols/toluene.mol" viewonly="TRUE">

function c3d_parsePara(str, paraArray) {

	for (var p in paraArray)
		paraArray[p] = c3d_getTagValue(p, str);
}


/////////////////////////////////////////////////////////////////////////////////////////////
// This function return the tag value from <EMBED> string.

function c3d_getTagValue(tag, str) {
	var r = "";
	var pos = str.toLowerCase().indexOf(tag, 0);
	var taglen = tag.length;
	
	// make sure tag is a whole word
	while (pos >= 0 && !(pos == 0 && (str.charAt(taglen) == " " || str.charAt(taglen) == "=") ||
		pos > 0 && str.charAt(pos - 1) == " " && (str.charAt(pos + taglen) == " " || str.charAt(pos + taglen) == "=")) ) {
		pos += taglen;
		pos = str.toLowerCase().indexOf(tag, pos);
	}

	if (pos >= 0) {		
		// skip the space chars following tag
		pos += taglen;
		while (str.charAt(pos) == " ")
			pos++;
		
		// following char must be '='
		if (str.charAt(pos) == "=") {
			pos++;
			
			// skip the space chars following '='
			while (str.charAt(pos) == " ")
				pos++;
			
			var p2 = pos;
			if (str.charAt(pos) == "\"") {
				pos++;
				p2 = str.indexOf("\"", pos);
			}
			else if (str.charAt(pos) == "\'") {
				pos++;
				p2 = str.indexOf("\'", pos);
			}
			else {
				p2 = str.indexOf(" ", pos);
			}
			
			if (p2 == -1)
				p2 = str.length
			else if (pos > p2)
				p2 = str.length - 1;

			r = str.substring(pos, p2);
		}
	}
	
	return r;
}