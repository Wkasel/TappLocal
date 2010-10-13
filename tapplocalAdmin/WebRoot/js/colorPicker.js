// Color Picker Script from Flooble.com
// For more information, visit
//	http://www.flooble.com/scripts/colorpicker.php
// Copyright 2003 Animus Pactum Consulting inc.
// You may use and distribute this code freely, as long as
// you keep this copyright notice and the link to flooble.com
// if you chose to remove them, you must link to the page
// listed above from every web page where you use the color
// picker code.
//---------------------------------------------------------
     var perline = 12;
     var divSet = false;
     var curId;

     var colorArray = [
     	'#382509','#57401E','#75511A','#8F6B32','#B3925D','#DEBC85',  
     	'#590000','#8C0000','#BF0000','#FF0000','#FF8080','#FFBFBF',     	   	
     	'#4D2600','#803F00','#BF5E00','#FF7E00','#FFBF80','#FFDFBF',     	
     	'#6A0056','#85026C','#A02786','#B14F9A','#C173B0','#E8B7D7',
     	'#1D0A55','#34176E','#462886','#644A9B','#8E79A5','#C3B4DA',
     	'#00316E','#00438A','#0057AE','#2C72C7','#6193CF','#A4C0E4',
     	'#00484D','#006066','#007880','#00A7B3','#00C4CC','#A8DDE0',
     	'#00583F','#00734D','#009966','#00B377','#00CC88','#99DCC6',
     	'#006E29','#00892C','#37A42C','#77B753','#B1D28F','#D8E8C2',
     	'#E3AD00','#F3C300','#FFDD00','#FFEB55','#FFF299','#FFF6C8',
     	'#AC4311','#CF4913','#EB7331','#F29B68','#F2BB88','#FFD9B0',
     	'#2E3436','#555753','#888A85','#BABDB6','#D3D7CF','#EEEEEC',
     	'#9C0F56','#BF0361','#E20071','#E85290','#F082B0','#F9CADE',
     	'#9C0F0F','#BF0303','#E20800','#E85752','#F08682','#F9CCCA',
     	'#730055','#A3007B','#CC009A','#FF00BF','#FF80DF','#FFBFF0',
     	'#2C0059','#400080','#5A00B3','#8000C7','#C080FF','#DFBFFF',
     	'#000080','#0000BF','#0000FF','#0066FF','#80B3FF','#BFD9FF',
     	'#004D00','#008C00','#00BF00','#00FF00','#80FF80','#BFFFBF',
     	'#638000','#8BB300','#BFF500','#FFFF00','#F0FF80','#F8FFBF',
     	'#FFAA00','#FFBF00','#FFD500','#FFFF00','#FFFF99','#FFFFBF',
     	'#000000','#323232','#555555','#777777','#888888','#999999',
     	'#AAAAAA','#BBBBBB','#CCCCCC','#DDDDDD','#EEEEEE','#FFFFFF']

     var ie = false;
     var nocolor = 'none';
	 if (document.all) { ie = true; nocolor = ''; }
	 function getObj(id) {
		if (ie) { return document.all[id]; }
		else {	return document.getElementById(id);	}
	 }

     function setColor(color) {
     	var link = getObj(curId);
     	var field = getObj(curId + 'field');
     	var picker = getObj('colorpicker');
     	field.value = color;
     	if (color == '') {
	     	link.style.background = nocolor;
	     	link.style.color = nocolor;
	     	color = nocolor;
     	} else {
	     	link.style.background = color;
	     	link.style.color = color;
	    }
     	picker.style.display = 'none';
	    eval(getObj(curId + 'field').title);
     }

     function setDiv() {
     	if (!document.createElement) { return; }
        var elemDiv = document.createElement('div');
        if (typeof(elemDiv.innerHTML) != 'string') { return; }
        //genColors();
        elemDiv.id = 'colorpicker';
	elemDiv.style.position = 'absolute';
        elemDiv.style.display = 'none';
        elemDiv.style.border = '#000000 1px solid';
        elemDiv.style.background = '#FFFFFF';
        elemDiv.innerHTML = '<span style="font-family:Verdana; font-size:11px;">'
          	+ '(<a href="javascript:setColor(\'\');">No color</a>)<br>'
        	+ getColorTable()
        	+ '</span>';

        document.body.appendChild(elemDiv);
        divSet = true;
     }

     function pickColor(id) {
     	if (!divSet) { setDiv(); }
     	var picker = getObj('colorpicker');
		if (id == curId && picker.style.display == 'block') {
			picker.style.display = 'none';
			return;
		}
     	curId = id;
     	var thelink = getObj(id);     
     	picker.style.top = (getAbsoluteOffsetTop(thelink) + 16)+'px';
     	picker.style.left = (getAbsoluteOffsetLeft(thelink))+'px';	
		picker.style.display = 'block';     
     }


     function getColorTable() {
         var colors = colorArray;
      	 var tableCode = '';
         tableCode += '<table border="0" cellspacing="1" cellpadding="1">';
         for (i = 0; i < colors.length; i++) {
              if (i % perline == 0) { tableCode += '<tr>'; }
              tableCode += '<td bgcolor="#000000"><a style="outline: 1px solid #000000; color: '
              	  + colors[i] + '; background: ' + colors[i] + ';font-size: 10px;" title="'
              	  + colors[i] + '" href="javascript:setColor(\'' + colors[i] + '\');">&nbsp;&nbsp;&nbsp;</a></td>';
              if (i % perline == perline - 1) { tableCode += '</tr>'; }
         }
         if (i % perline != 0) { tableCode += '</tr>'; }
         tableCode += '</table>';
      	 return tableCode;
     }
     function relateColor(id, idField, color) {
          
     	if (document.getElementById(id) != null)
     	{
     		if (document.getElementById(id) && document.getElementById(idField))
     		{     
	    	 	var link = getObj(id);
	    	 	var linkField = getObj(idField);     	
	    	 	if (color == '' || color == '#') {
			     	link.style.background = nocolor;
			     	link.style.color = nocolor;
			     	color = nocolor;
			     	linkField.value = '#FFFFFF';
	    	 	} else {
			     	link.style.background = color;
			     	link.style.color = color;
			     	linkField.value = color;	     	
			    }
			    eval(getObj(idField).title);
	    	}     	
     	}
     	else
     	{    
     		if (window.opener.document.getElementById(id) && window.opener.document.getElementById(idField))
     		{          		
	    	 	var link = window.opener.document.getElementById(id);
	    	 	var linkField = window.opener.document.getElementById(idField);     	
	    	 	if (color == '' || color == '#') {
			     	link.style.background = nocolor;
			     	link.style.color = nocolor;
			     	color = nocolor;
			     	linkField.value = '#FFFFFF';
	    	 	} else {
			     	link.style.background = color;
			     	link.style.color = color;
			     	linkField.value = color;	     	
			    }
			    eval(window.opener.document.getElementById(idField).title);
	    	}     	
     	}
          
     	if (document.getElementById(id) && document.getElementById(idField))
     	{     
	     	var link = getObj(id);
	     	var linkField = getObj(idField);     	
	     	if (color == '' || color == '#') {
		     	link.style.background = nocolor;
		     	link.style.color = nocolor;
		     	color = nocolor;
		     	linkField.value = '#FFFFFF';
	     	} else {
		     	link.style.background = color;
		     	link.style.color = color;
		     	linkField.value = color;	     	
		    }
		    eval(getObj(idField).title);
	    }
     }
     function getAbsoluteOffsetTop(obj) {
     	var top = obj.offsetTop;
     	var parent = obj.offsetParent;     		     
     	while (parent != document.body) {
     		top += parent.offsetTop;     		
     		parent = parent.offsetParent;
     	}  		
     	return top;
     }

     function getAbsoluteOffsetLeft(obj) {
     	var left = obj.offsetLeft;
     	var parent = obj.offsetParent;
     	while (parent != document.body) {
     		left += parent.offsetLeft;
     		parent = parent.offsetParent;
     	}
     	return left;
     }	

	function convertRGBToHex(col) {
		var re = new RegExp("rgb\\s*\\(\\s*([0-9]+).*,\\s*([0-9]+).*,\\s*([0-9]+).*\\)", "gi");

		var rgb = col.replace(re, "$1,$2,$3").split(',');
		if (rgb.length == 3) {
			r = parseInt(rgb[0]).toString(16);
			g = parseInt(rgb[1]).toString(16);
			b = parseInt(rgb[2]).toString(16);

			r = r.length == 1 ? '0' + r : r;
			g = g.length == 1 ? '0' + g : g;
			b = b.length == 1 ? '0' + b : b;

			return "#" + r + g + b;
		}

		return col;
	}
