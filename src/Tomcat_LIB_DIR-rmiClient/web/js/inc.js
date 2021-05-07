/* Global variables */

var d = document, w = window, p = parent, n = navigator.userAgent;

/* Drag class */

var DRG = {

	obj : null,
	
	init : function(o, oRoot, minX, maxX, minY, maxY, bSwapHorzRef, bSwapVertRef, fXMapper, fYMapper)
	{
		o.onmousedown	= DRG.start;

		o.hmode = bSwapHorzRef? false : true;
		o.vmode = bSwapVertRef? false : true;

		o.root = oRoot && oRoot != null? oRoot : o;

		if (o.hmode && isNaN(parseInt(o.root.style.left  ))) o.root.style.left = 0;
		if (o.vmode && isNaN(parseInt(o.root.style.top   ))) o.root.style.top = 0;
		if (!o.hmode && isNaN(parseInt(o.root.style.right ))) o.root.style.right = 0;
		if (!o.vmode && isNaN(parseInt(o.root.style.bottom))) o.root.style.bottom = 0;

		o.minX	= typeof minX != 'undefined'? minX : null;
		o.minY	= typeof minY != 'undefined'? minY : null;
		o.maxX	= typeof maxX != 'undefined'? maxX : null;
		o.maxY	= typeof maxY != 'undefined'? maxY : null;

		o.xMapper = fXMapper? fXMapper : null;
		o.yMapper = fYMapper? fYMapper : null;

		o.root.onDragStart = new Function;
		o.root.onDragEnd = new Function;
		o.root.onDrag = new Function;
	},

	start : function(e)
	{
		var o = DRG.obj = this;
		e = DRG.fixE(e);
		var y = parseInt(o.vmode? o.root.style.top  : o.root.style.bottom);
		var x = parseInt(o.hmode? o.root.style.left : o.root.style.right );
		
		o.root.onDragStart(x, y);

		o.lastMouseX	= e.clientX;
		o.lastMouseY	= e.clientY;

		if (o.hmode) {
			if (o.minX != null)	o.minMouseX	= e.clientX - x + o.minX;
			if (o.maxX != null)	o.maxMouseX	= o.minMouseX + o.maxX - o.minX;
		} else {
			if (o.minX != null) o.maxMouseX = -o.minX + e.clientX + x;
			if (o.maxX != null) o.minMouseX = -o.maxX + e.clientX + x;
		}

		if (o.vmode) {
			if (o.minY != null)	o.minMouseY	= e.clientY - y + o.minY;
			if (o.maxY != null)	o.maxMouseY	= o.minMouseY + o.maxY - o.minY;
		} else {
			if (o.minY != null) o.maxMouseY = -o.minY + e.clientY + y;
			if (o.maxY != null) o.minMouseY = -o.maxY + e.clientY + y;
		}

		d.onmousemove	= DRG.drag;
		d.onmouseup		= DRG.end;

		return false;
	},

	drag : function(e)
	{
		e = DRG.fixE(e);
		var o = DRG.obj;

		var ey = e.clientY;
		var ex = e.clientX;
		var y = parseInt(o.vmode? o.root.style.top  : o.root.style.bottom);
		var x = parseInt(o.hmode? o.root.style.left : o.root.style.right );
		var nx, ny;

		if (o.minX != null) ex = o.hmode? Math.max(ex, o.minMouseX) : Math.min(ex, o.maxMouseX);
		if (o.maxX != null) ex = o.hmode? Math.min(ex, o.maxMouseX) : Math.max(ex, o.minMouseX);
		if (o.minY != null) ey = o.vmode? Math.max(ey, o.minMouseY) : Math.min(ey, o.maxMouseY);
		if (o.maxY != null) ey = o.vmode? Math.min(ey, o.maxMouseY) : Math.max(ey, o.minMouseY);

		nx = x + ((ex - o.lastMouseX) * (o.hmode? 1 : -1));
		ny = y + ((ey - o.lastMouseY) * (o.vmode? 1 : -1));

		if (o.xMapper)	nx = o.xMapper(y)
		else if (o.yMapper)	ny = o.yMapper(x)

		DRG.obj.root.style[o.hmode? "left" : "right"] = nx + "px";
		DRG.obj.root.style[o.vmode? "top" : "bottom"] = ny + "px";
		DRG.obj.lastMouseX	= ex;
		DRG.obj.lastMouseY	= ey;
		
		/* this writes togeter with drag action */
		DRG.obj.root.onDrag(nx, ny);
		
		return false;
	},

	end : function()
	{
		d.onmousemove = null;
		d.onmouseup   = null;
		
		/* this writes end result of the drag action */
		DRG.obj.root.onDragEnd(parseInt(DRG.obj.root.style[DRG.obj.hmode? "left" : "right"]), 
		 parseInt(DRG.obj.root.style[DRG.obj.vmode ? "top" : "bottom"]));
		
		DRG.obj = null;
	},

	fixE : function(e)
	{
		if (typeof e == 'undefined') e = w.event;
		if (typeof e.layerX == 'undefined') e.layerX = e.offsetX;
		if (typeof e.layerY == 'undefined') e.layerY = e.offsetY;
		return e;
	}
};

/* Drag class end */

/* AJAX class */

var AJX = { 

	xmlHttp : null,

	url : '',

	reqXML : function ()
	{
		
		try {
		/* Firefox, Opera 8.0+, Safari, IE7 */   
			AJX.xmlHttp = new XMLHttpRequest();
			
			if (AJX.xmlHttp.overrideMimeType)
	        AJX.xmlHttp.overrideMimeType('text/xml');
	    
		}
		catch (e) {
		/* Internet Explorer 6, 5 */
			try {
				AJX.xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			}
			catch (e) {
				try {
					AJX.xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				}
				catch (e) {
					alert("Your browser does not support AJAX!");
					return false;
				}
			}
		}
		
		AJX.xmlHttp.onreadystatechange = AJX.processReqChange;
		
		try {
			AJX.xmlHttp.open("GET", AJX.url, true);
			AJX.xmlHttp.send(null);
		}
		catch (e) {
			var msg = (typeof e == "string") ? e : ((e.message) ? e.message : "Unknown Error");
			alert("Unable to get XML data:\n" + msg);
			return;
		}
						
	},
	
	processReqChange : new Function,
	
	load : new Function,
	
	rdm : function (){ return Math.random() * Math.pow(10,17); }

}

/* AJAX class end */

/* Cookie class */

var CK = {

	Set : function (name, value, expires, path, domain, secure)
	{
		var today = new Date();
	
		today.setTime(today.getTime());
			
		if(expires) expires = expires*1000*60*60*24;
		
		var expires_date = new Date(today.getTime() + expires);
	
		d.cookie = name + " = " + escape(value) 
		+ (expires? ";expires = " + expires_date.toGMTString() : "") 
		+ (path? ";path = " + path : "") 
		+ (domain? ";domain = " + domain : "") 
		+ (secure? ";secure" : "");
	},
	
	Get : function (name)
	{
		var start = d.cookie.indexOf(name + "="), len = start + name.length + 1;
			
			if(!start && name != d.cookie.substring(0, name.length)) return null;
			
			if(start == -1) return null;
		
		var end = d.cookie.indexOf(";", len);
			
			if(end == -1) end = d.cookie.length;
		
			return unescape(d.cookie.substring(len, end));
	},
	
	Del : function (name, path, domain)
	{
		var exp = new Date();  
		
		exp.setTime(exp.getTime() - 1); 
		
		if(CK.Get(name)) 
			d.cookie = name + " = " 
			+ (path? ";path = " + path : "")
			+ (domain? ";domain = " + domain : "")
			+ ";expires = " + exp.toGMTString();
	}

}

/* Cookie class end */

/* Scrollbar class */

var SCR = {

	tid : null, 
	
	step : 20, 
	
	obj : null, 
	
	slidBarH : null, 
	
	slider : null, 
	
	arrUp : null, 
	
	arrDown : null, 
	
	k : 1,
	
	moveScroll : function (Y)
	{
	  SCR.obj.scrollTop = Y * SCR.k;
	},
	
	moveSlider : function ()
	{
  	SCR.slider.style.top = SCR.obj.scrollTop/SCR.k + 'px';
	},
	
	scrollIt : function (action)
	{
		if(action != null)
			SCR.tid = setTimeout(function ()
				{
					SCR.obj.scrollTop += SCR.step * action;
					SCR.moveSlider();
					SCR.scrollIt(action);
				}
				, 100);
		else
			clearTimeout(SCR.tid);
	},
	
	arrEvInit : function ()
	{
	  SCR.arrUp.onmouseover = new Function('SCR.scrollIt(-1)');
	  SCR.arrDown.onmouseover = new Function('SCR.scrollIt(1)');
	  SCR.arrUp.onmouseout = SCR.arrDown.onmouseout = new Function('SCR.scrollIt()');
	},
	
	arrStopInit : function ()
	{
	  SCR.arrDown.onmouseover = SCR.arrUp.onmouseover = function (e){ DRG.fixE(e).cancelBubble = true; }
	},
	
	/* mouse wheel */
	
	myScroll : function (onwheel)
	{
		if(onwheel){
			if (w.addEventListener)
				/** DOMMouseScroll is for mozilla. */
				w.addEventListener('DOMMouseScroll', SCR.wheel, false);
			/** IE/Opera. */
			w.onmousewheel = d.onmousewheel = SCR.wheel;
		}
		else
		{
			if (w.removeEventListener)
				/** DOMMouseScroll is for mozilla. */
				w.removeEventListener('DOMMouseScroll', SCR.wheel, false);
			w.onmousewheel = d.onmousewheel = null;
		}
	},
	
	handle : function (delta) 
	{
		if (delta < 0)
			SCR.obj.scrollTop += SCR.myScroll? SCR.step : 0;
		else
			SCR.obj.scrollTop -= SCR.myScroll? SCR.step : 0;
			
		SCR.moveSlider();
	},
	
	wheel : function (event)
	{
	    var delta = 0;
	    if (!event) /* For IE. */
	            event = w.event;
	    if (event.wheelDelta) { /* IE/Opera. */
	            delta = event.wheelDelta/120;
	            /** In Opera 9, delta differs in sign as compared to IE. */
	            if (w.opera)
	                    delta = delta;
	    } else if (event.detail) { /** Mozilla case. */
	            delta = -event.detail/3;
	    }
	    if (delta)
	            SCR.handle(delta);
	    if (event.preventDefault)
	            event.preventDefault();
	            
			event.returnValue = false;
	},
	
	/* mouse wheel end */
	
	init : function (id, slBg, slBut, slUp, slDown, slPos)
	{
		SCR.obj = $(id);
		SCR.slidBarH = $(slBg).offsetHeight;
		SCR.slider = $(slBut);
		
		SCR.k = (SCR.obj.scrollHeight - SCR.obj.offsetHeight)/(SCR.slidBarH - SCR.slider.offsetHeight);
		
		SCR.arrUp = $(slUp);
		SCR.arrDown = $(slDown);
		
		SCR.arrEvInit();
		
		$(slBg, 1).visibility = $(slUp, 1).visibility = $(slDown, 1).visibility = SCR.obj.scrollHeight > 
		SCR.obj.offsetHeight? "visible" : "hidden";

		SCR.obj.scrollTop = slPos? slPos : 0;
		SCR.slider.style.top = SCR.obj.scrollTop + 'px';
		
		DRG.init(SCR.slider, SCR.slider, 0, 0, 0, SCR.slidBarH - SCR.slider.offsetHeight);
		
		SCR.obj.onmouseover = function (){ SCR.myScroll(1); } 
		SCR.obj.onmouseout = function (){ SCR.myScroll(); }
		
		SCR.slider.onDragStart = function (x, y){ SCR.arrStopInit(); };
		SCR.slider.onDrag = function (x, y){ SCR.moveScroll(y); };
		SCR.slider.onDragEnd = function (x, y){ SCR.arrEvInit(); };
	}
};

/* Scrollbar class end */

/* Browser check class */

function BWC(){

	this.dom = d.getElementById;
	this.ie4 = d.all && !this.dom?  true : false;	
	this.ns4 = d.layers? true : false;
	
	this.ns = n.indexOf("Netscape") > -1 && !this.ns4;
	this.ff = n.indexOf("Firefox") > -1;
	this.mz = n.indexOf("Gecko") > -1 && !this.ns && !this.ff;
	this.op = n.indexOf("Opera") > -1;
	this.ie = n.indexOf("MSIE") > -1 && !this.op && !this.ie4;
	
}

/* Browser check class end */

/* Flash function */

function acXCt(){
var html = '<embed ';

	for (var _x = 0; _x <= acXCt.arguments.length - 1; _x++)
		if(_x%2)
			html += acXCt.arguments[_x] + '" ';
		else
			html += acXCt.arguments[_x] + '="';
			
	html += 'type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />';
		
	document.write(html);
	
}

/* Flash function end */

/* DOM functions */

function $(id, f){
	return eval('d.getElementById(id)' + (f? '.style' : ''));
}

function _(o, _e, id, f){
	return eval('o.getElementsByTagName(_e)[' + (id? id : 0) + ']' + (f? '.style' : ''));
}


function bookInfo(title, author, genre, publ, keywords, lang)
{		
	w = 800;
	h = 600;		
	//is = new browser();
	// var brWin = new winSize();
	//posX = (brWin.width-w)/2;	
	//posY = (brWin.height-h)/2;
        posX = 50;
        posY = 50;
	(posX<0)? posX = 0 : 0;
	(posY<0)? posY = 0 : 0;
	var win = window.open('','picture','width='+w+',height='+h+',toolbar=no,menubar=no,resizable=no,statusbar=no,top='+posY+',left='+posX+',screenX='+posX+' ,screenY='+posY);
	win.document.open();
	win.document.write(
		'<html>\n<head>\n'
		+'<title> Info book: '+title+'</title>' +'\n'+'<link href="style.css" rel="stylesheet" type="text/css">'+'</head>'+'\n'
		+'<body class="login">'+'\n'
	);
	win.document.write('<table border="0" cellpadding="0" cellspacing="0" width="800">');
        win.document.write('<tr><td colspan="3" height="130"></td></tr>');
        win.document.write('<tr><td width="55%">&nbsp;</td>\n<td width="34%" class="brief"><strong>Brief Info</strong> </td>\n<td width="11%">&nbsp;</td>\n</tr>');
        win.document.write('<tr><td>&nbsp;</td><td class="info">');
        win.document.write('<p><strong>Title: </strong>'+title+ '</p>');  // book title
	win.document.write('<p><strong>Author: </strong>'+author+ '</p>');  // book author
        win.document.write('<p><strong>Genre: </strong>' +genre+ '</p>');  // book genre
        win.document.write('<p><strong>Publisher: </strong>' +publ+ '</p>');  // book publisher
        win.document.write('<p><strong>Keywords: </strong>' +keywords+ '</p>');  // book publisher
        win.document.write('<p><strong>Language: </strong>' +lang+ '</p>');  // book language
 
        win.document.write('</td><td>&nbsp;</td></tr></table>');
        win.document.write('</body>\n</html>');
	win.document.close();
	win.focus(); 
}


/* DOM functions end */
