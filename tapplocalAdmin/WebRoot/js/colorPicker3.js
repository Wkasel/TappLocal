// A few configuration settings
var CROSSHAIRS_LOCATION = './images/crosshairs.png';
var HUE_SLIDER_LOCATION = './images/h.png';
var HUE_SLIDER_ARROWS_LOCATION = './images/position.png';
var SAT_VAL_SQUARE_LOCATION = './images/sv.png';
var inputName=getURLParam('input');
var inputFieldName=getURLParam('inputField');

// Here are some boring utility functions. The real code comes later.

function hexToRgb(hex_string, default_)
{
    if (default_ == undefined)
    {
        default_ = null;
    }

    if (hex_string.substr(0, 1) == '#')
    {
        hex_string = hex_string.substr(1);
    }
    
    var r;
    var g;
    var b;
    if (hex_string.length == 3)
    {
        r = hex_string.substr(0, 1);
        r += r;
        g = hex_string.substr(1, 1);
        g += g;
        b = hex_string.substr(2, 1);
        b += b;
    }
    else if (hex_string.length == 6)
    {
        r = hex_string.substr(0, 2);
        g = hex_string.substr(2, 2);
        b = hex_string.substr(4, 2);
    }
    else
    {
        return default_;
    }
    
    r = parseInt(r, 16);
    g = parseInt(g, 16);
    b = parseInt(b, 16);
    if (isNaN(r) || isNaN(g) || isNaN(b))
    {
        return default_;
    }
    else
    {
        return {r: r / 255, g: g / 255, b: b / 255};
    }
}

function rgbToHex(r, g, b, includeHash)
{
    r = Math.round(r * 255);
    g = Math.round(g * 255);
    b = Math.round(b * 255);
    if (includeHash == undefined)
    {
        includeHash = true;
    }
    
    r = r.toString(16);
    if (r.length == 1)
    {
        r = '0' + r;
    }
    g = g.toString(16);
    if (g.length == 1)
    {
        g = '0' + g;
    }
    b = b.toString(16);
    if (b.length == 1)
    {
        b = '0' + b;
    }
    return ((includeHash ? '#' : '') + r + g + b).toUpperCase();
}

var arVersion = navigator.appVersion.split("MSIE");
var version = parseFloat(arVersion[1]);

function fixPNG(myImage)
{
    if ((version >= 5.5) && (version < 7) && (document.body.filters)) 
    {
        var node = document.createElement('span');
        node.id = myImage.id;
        node.className = myImage.className;
        node.title = myImage.title;
        node.style.cssText = myImage.style.cssText;
        node.style.setAttribute('filter', "progid:DXImageTransform.Microsoft.AlphaImageLoader"
                                        + "(src=\'" + myImage.src + "\', sizingMethod='scale')");
        node.style.fontSize = '0';
        node.style.width = myImage.width.toString() + 'px';
        node.style.height = myImage.height.toString() + 'px';
        node.style.display = 'inline-block';
        return node;
    }
    else
    {
        return myImage.cloneNode(false);
    }
}

function trackDrag(node, handler)
{
    function fixCoords(x, y)
    {
        var nodePageCoords = pageCoords(node);
        x = (x - nodePageCoords.x) + document.documentElement.scrollLeft;
        y = (y - nodePageCoords.y) + document.documentElement.scrollTop;
        if (x < 0) x = 0;
        if (y < 0) y = 0;
        if (x > node.offsetWidth - 1) x = node.offsetWidth - 1;
        if (y > node.offsetHeight - 1) y = node.offsetHeight - 1;
        return {x: x, y: y};
    }
    function mouseDown(ev)
    {
        var coords = fixCoords(ev.clientX, ev.clientY);
        var lastX = coords.x;
        var lastY = coords.y;
        handler(coords.x, coords.y);

        function moveHandler(ev)
        {
            var coords = fixCoords(ev.clientX, ev.clientY);
            if (coords.x != lastX || coords.y != lastY)
            {
                lastX = coords.x;
                lastY = coords.y;
                handler(coords.x, coords.y);
            }
        }
        function upHandler(ev)
        {
            myRemoveEventListener(document, 'mouseup', upHandler);
            myRemoveEventListener(document, 'mousemove', moveHandler);
            myAddEventListener(node, 'mousedown', mouseDown);
        }
        myAddEventListener(document, 'mouseup', upHandler);
        myAddEventListener(document, 'mousemove', moveHandler);
        myRemoveEventListener(node, 'mousedown', mouseDown);
        if (ev.preventDefault) ev.preventDefault();
    }
    myAddEventListener(node, 'mousedown', mouseDown);
    node.onmousedown = function(e) { return false; };
    node.onselectstart = function(e) { return false; };
    node.ondragstart = function(e) { return false; };
}

var eventListeners = [];

function findEventListener(node, event, handler)
{
    var i;
    for (i in eventListeners)
    {
        if (eventListeners[i].node == node && eventListeners[i].event == event
         && eventListeners[i].handler == handler)
        {
            return i;
        }
    }
    return null;
}
function myAddEventListener(node, event, handler)
{
    if (findEventListener(node, event, handler) != null)
    {
        return;
    }

    if (!node.addEventListener)
    {
        node.attachEvent('on' + event, handler);
    }
    else
    {
        node.addEventListener(event, handler, false);
    }

    eventListeners.push({node: node, event: event, handler: handler});
}

function removeEventListenerIndex(index)
{
    var eventListener = eventListeners[index];
    delete eventListeners[index];
    
    if (!eventListener.node.removeEventListener)
    {
        eventListener.node.detachEvent('on' + eventListener.event,
                                       eventListener.handler);
    }
    else
    {
        eventListener.node.removeEventListener(eventListener.event,
                                               eventListener.handler, false);
    }
}

function myRemoveEventListener(node, event, handler)
{
    removeEventListenerIndex(findEventListener(node, event, handler));
}

function cleanupEventListeners()
{
    var i;
    for (i = eventListeners.length; i > 0; i--)
    {
        if (eventListeners[i] != undefined)
        {
            removeEventListenerIndex(i);
        }
    }
}
myAddEventListener(window, 'unload', cleanupEventListeners);

// This copyright statement applies to the following two functions,
// which are taken from MochiKit.
//
// Copyright 2005 Bob Ippolito <bob@redivi.com>
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject
// to the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
// BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
// ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

function hsvToRgb(hue, saturation, value)
{
    var red;
    var green;
    var blue;
    if (value == 0.0)
    {
        red = 0;
        green = 0;
        blue = 0;
    }
    else
    {
        var i = Math.floor(hue * 6);
        var f = (hue * 6) - i;
        var p = value * (1 - saturation);
        var q = value * (1 - (saturation * f));
        var t = value * (1 - (saturation * (1 - f)));
        switch (i)
        {
            case 1: red = q; green = value; blue = p; break;
            case 2: red = p; green = value; blue = t; break;
            case 3: red = p; green = q; blue = value; break;
            case 4: red = t; green = p; blue = value; break;
            case 5: red = value; green = p; blue = q; break;
            case 6: // fall through
            case 0: red = value; green = t; blue = p; break;
        }
    }
    return {r: red, g: green, b: blue};
}

function rgbToHsv(red, green, blue)
{
    var max = Math.max(Math.max(red, green), blue);
    var min = Math.min(Math.min(red, green), blue);
    var hue;
    var saturation;
    var value = max;
    if (min == max)
    {
        hue = 0;
        saturation = 0;
    }
    else
    {
        var delta = (max - min);
        saturation = delta / max;
        if (red == max)
        {
            hue = (green - blue) / delta;
        }
        else if (green == max)
        {
            hue = 2 + ((blue - red) / delta);
        }
        else
        {
            hue = 4 + ((red - green) / delta);
        }
        hue /= 6;
        if (hue < 0)
        {
            hue += 1;
        }
        if (hue > 1)
        {
            hue -= 1;
        }
    }
    return {
        h: hue,
        s: saturation,
        v: value
    };
}

function pageCoords(node)
{
    var x = node.offsetLeft;
    var y = node.offsetTop;
    var parent = node.offsetParent;
    while (parent != null)
    {
        x += parent.offsetLeft;
        y += parent.offsetTop;
        parent = parent.offsetParent;
    }
    return {x: x, y: y};
}

// The real code begins here.
var huePositionImg = document.createElement('img');
huePositionImg.galleryImg = false;
huePositionImg.width = 35;
huePositionImg.height = 11;
huePositionImg.src = HUE_SLIDER_ARROWS_LOCATION;
huePositionImg.style.position = 'absolute';

var hueSelectorImg = document.createElement('img');
hueSelectorImg.galleryImg = false;
hueSelectorImg.width = 35;
hueSelectorImg.height = 200;
hueSelectorImg.src = HUE_SLIDER_LOCATION;
hueSelectorImg.style.display = 'block';

var satValImg = document.createElement('img');
satValImg.galleryImg = false;
satValImg.width = 200;
satValImg.height = 200;
satValImg.src = SAT_VAL_SQUARE_LOCATION;
satValImg.style.display = 'block';

var crossHairsImg = document.createElement('img');
crossHairsImg.galleryImg = false;
crossHairsImg.width = 21;
crossHairsImg.height = 21;
crossHairsImg.src = CROSSHAIRS_LOCATION;
crossHairsImg.style.position = 'absolute';

function makeColorSelector(inputBox)
{
    var rgb, hsv
    
    function colorChanged()
    {
        var hex = rgbToHex(rgb.r, rgb.g, rgb.b);
        var hueRgb = hsvToRgb(hsv.h, 1, 1);
        var hueHex = rgbToHex(hueRgb.r, hueRgb.g, hueRgb.b);
        previewDiv.style.background = hex;
        inputBox.value = hex;
        satValDiv.style.background = hueHex;
        crossHairs.style.left = ((hsv.v*199)-10).toString() + 'px';
        crossHairs.style.top = (((1-hsv.s)*199)-10).toString() + 'px';
        huePos.style.top = ((hsv.h*199)-5).toString() + 'px';
    }
    function rgbChanged()
    {
        hsv = rgbToHsv(rgb.r, rgb.g, rgb.b);
        colorChanged();
    }
    function hsvChanged()
    {
        rgb = hsvToRgb(hsv.h, hsv.s, hsv.v);
        colorChanged();
    }
    
    var colorSelectorDiv = document.createElement('div');
    colorSelectorDiv.style.padding = '15px';
    colorSelectorDiv.style.position = 'relative';
    colorSelectorDiv.style.height = '275px';
    colorSelectorDiv.style.width = '250px';
    
    var satValDiv = document.createElement('div');
    satValDiv.style.position = 'relative';
    satValDiv.style.width = '200px';
    satValDiv.style.height = '200px';
    var newSatValImg = fixPNG(satValImg);
    satValDiv.appendChild(newSatValImg);
    var crossHairs = crossHairsImg.cloneNode(false);
    satValDiv.appendChild(crossHairs);
    function satValDragged(x, y)
    {
        hsv.s = 1-(y/199);
        hsv.v = (x/199);
        hsvChanged();
    }
    trackDrag(satValDiv, satValDragged)
    colorSelectorDiv.appendChild(satValDiv);

    var hueDiv = document.createElement('div');
    hueDiv.style.position = 'absolute';
    hueDiv.style.left = '230px';
    hueDiv.style.top = '15px';
    hueDiv.style.width = '35px';
    hueDiv.style.height = '200px';
    var huePos = fixPNG(huePositionImg);
    hueDiv.appendChild(hueSelectorImg.cloneNode(false));
    hueDiv.appendChild(huePos);
    function hueDragged(x, y)
    {
        hsv.h = y/199;
        hsvChanged();
    }
    trackDrag(hueDiv, hueDragged);
    colorSelectorDiv.appendChild(hueDiv);
    
    var previewDiv = document.createElement('div');
    previewDiv.style.height = '50px'
    previewDiv.style.width = '50px';
    previewDiv.style.position = 'absolute';
    previewDiv.style.top = '225px';
    previewDiv.style.left = '15px';
    previewDiv.style.border = '1px solid black';
    colorSelectorDiv.appendChild(previewDiv);
    
    function inputBoxChanged()
    {
        rgb = hexToRgb(inputBox.value, {r: 0, g: 0, b: 0});
        rgbChanged();
    }
    myAddEventListener(inputBox, 'change', inputBoxChanged);
    inputBox.size = 8;
    inputBox.style.position = 'absolute';
    inputBox.style.right = '100px';
    inputBox.style.top = '239px';
    colorSelectorDiv.appendChild(inputBox);
    
	var okButton = document.createElement('input');
	okButton.type='button';
	okButton.value='ok';
	okButton.onclick=ok;
    okButton.style.position = 'absolute';
    okButton.style.right= '15px';
    okButton.style.width= '35px';
    okButton.style.width= '75px';
    okButton.style.top = '239px';	
    
    if ((c1 != null) && (c1 != ''))
    {   
    	inputBox.style.top = '250px';
    
	    var selectCombo = document.createElement('select');
	    selectCombo.id= 'selectCombo';
	    selectCombo.style.width= '75px';
	    selectCombo.style.right= '100px';
	    selectCombo.style.top = '225px';
	    selectCombo.style.position = 'absolute';
	    selectCombo.onchange=okCombo;
	  
	    var opt = document.createElement('option');
	    opt.value = '';
	    opt.text = '';
	    selectCombo.options.add(opt);      
	    
	    var opt1 = document.createElement('option');
	    opt1.value = c1;
	    opt1.text = '';
	    opt1.style.backgroundColor = c1;
	    selectCombo.options.add(opt1);    
	    
	    var opt2 = document.createElement('option');
	    opt2.value = c2;
	    opt2.text = '';
	    opt2.style.backgroundColor = c2;
	    selectCombo.options.add(opt2);
	    
	    var opt3 = document.createElement('option');
	    opt3.value = c3;
	    opt3.text = '';
	    opt3.style.backgroundColor = c3;
	    selectCombo.options.add(opt3);   
	    
	    var opt4 = document.createElement('option');
	    opt4.value = c4;
	    opt4.text = '';
	    opt4.style.backgroundColor = c4;
	    selectCombo.options.add(opt4);   
	    
	    var opt5 = document.createElement('option');
	    opt5.value = c5;
	    opt5.text = '';
	    opt5.style.backgroundColor = c5;
	    selectCombo.options.add(opt5);   
	    
	    var opt6 = document.createElement('option');
	    opt6.value = c6;
	    opt6.text = '';
	    opt6.style.backgroundColor = c6;
	    selectCombo.options.add(opt6);   
	    
	    var opt7 = document.createElement('option');
	    opt7.value = c7;
	    opt7.text = '';
	    opt7.style.backgroundColor = c7;
	    selectCombo.options.add(opt7);   
	    
	    var opt8 = document.createElement('option');
	    opt8.value = c8;
	    opt8.text = '';
	    opt8.style.backgroundColor = c8;
	    selectCombo.options.add(opt8);   
	    
	    var opt9 = document.createElement('option');
	    opt9.value = c9;
	    opt9.text = '';
	    opt9.style.backgroundColor = c9;
	    selectCombo.options.add(opt9);   
	    
	    var opt10 = document.createElement('option');
	    opt10.value = c10;
	    opt10.text = '';
	    opt10.style.backgroundColor = c10;
	    selectCombo.options.add(opt10); 
	    
	    var opt11 = document.createElement('option');
	    opt11.value = c11;
	    opt11.text = '';
	    opt11.style.backgroundColor = c11;
	    selectCombo.options.add(opt11);   
	    
	    var opt12 = document.createElement('option');
	    opt12.value = c12;
	    opt12.text = '';
	    opt12.style.backgroundColor = c12;
	    selectCombo.options.add(opt12);   
	    
	    var opt13 = document.createElement('option');
	    opt13.value = c13;
	    opt13.text = '';
	    opt13.style.backgroundColor = c13;
	    selectCombo.options.add(opt13);   
	    
	    var opt14 = document.createElement('option');
	    opt14.value = c14;
	    opt14.text = '';
	    opt14.style.backgroundColor = c14;
	    selectCombo.options.add(opt14);   
	    
	    var opt15 = document.createElement('option');
	    opt15.value = c15;
	    opt15.text = '';
	    opt15.style.backgroundColor = c15;
	    selectCombo.options.add(opt15);   
	    
	    var opt16 = document.createElement('option');
	    opt16.value = c16;
	    opt16.text = '';
	    opt16.style.backgroundColor = c16;
	    selectCombo.options.add(opt16);   
	    
	    var opt17 = document.createElement('option');
	    opt17.value = c17;
	    opt17.text = '';
	    opt17.style.backgroundColor = c17;
	    selectCombo.options.add(opt17);   
	    
	    var opt18 = document.createElement('option');
	    opt18.value = c18;
	    opt18.text = '';
	    opt18.style.backgroundColor = c18;
	    selectCombo.options.add(opt18);   
	    
	    var opt19 = document.createElement('option');
	    opt19.value = c19;
	    opt19.text = '';
	    opt19.style.backgroundColor = c19;
	    selectCombo.options.add(opt19);   
	    
	    var opt20 = document.createElement('option');
	    opt20.value = c20;
	    opt20.text = '';
	    opt20.style.backgroundColor = c20;
	    selectCombo.options.add(opt20);   
                   
	    
	    colorSelectorDiv.appendChild(selectCombo);
    }
    
    colorSelectorDiv.appendChild(okButton);      
    
    inputBoxChanged();
    
    return colorSelectorDiv;
}

function makeColorSelectors(ev)
{
    var inputNodes = document.getElementsByTagName('input');
    var node = inputNodes[0];
    
    if (node.className == 'color')
    {   
        var parent = node.parentNode;
        var prevNode = node.previousSibling;
        var selector = makeColorSelector(node);
        parent.insertBefore(selector, (prevNode ? prevNode.nextSibling : null));
    }   
}

function getURLParam(strParamName){
  var strReturn = "";
  var strHref = window.location.href;
  if ( strHref.indexOf("?") > -1 ){
    var strQueryString = strHref.substr(strHref.indexOf("?")).toLowerCase();
    var aQueryString = strQueryString.split("&");
    for ( var iParam = 0; iParam < aQueryString.length; iParam++ ){
      if (
aQueryString[iParam].indexOf(strParamName.toLowerCase() + "=") > -1 ){
        var aParam = aQueryString[iParam].split("=");
        strReturn = aParam[1];
        break;
      }
    }
  }
  return unescape(strReturn);
}

function ok(e)
{
	window.opener.document.getElementById(inputName).style.color = document.getElementById('pickerInput').value;
	window.opener.document.getElementById(inputFieldName).value = document.getElementById('pickerInput').value;
	relateColor(inputName,inputFieldName,document.getElementById('pickerInput').value);	

	window.close();
}

function okCombo(e)
{
	window.opener.setPickerColor(document.getElementById('selectCombo').value);
	window.close();
}


myAddEventListener(window, 'load', makeColorSelectors);
