/**
 *  Version 2.0
 *      -Contributors: "mindinquiring" : filter to exclude any stylesheet other than print.
 *  Tested ONLY in IE 8 and FF 3.5.3. No official support for other browsers, but will
 *      TRY to accomodate challenges in other browsers.
 *  Example:
 *      Print Button: <div id="print_button">Print</div>
 *      Print Area  : <div class="PrintArea"> ... html ... </div>
 *      Javascript  : <script>
 *                       $("div#print_button").click(function(){
 *                           $("div.PrintArea").printArea( [OPTIONS] );
 *                       });
 *                     </script>
 *  options are passed as json (json example: {mode: "popup", popClose: false})
 *
 *  {OPTIONS} | [type]    | (default), values    | Explanation
 *  --------- | --------- | -------------------- | -----------
 *  @mode     | [string]  | ("iframe"), "popup"  | printable window is either iframe or browser popup
 *  @popHt    | [number]  | (500)                | popup window height
 *  @popWd    | [number]  | (400)                | popup window width
 *  @popX     | [number]  | (500)                | popup window screen X position
 *  @popY     | [number]  | (500)                | popup window screen Y position
 *  @popTitle | [string]  | ('')                 | popup window title element
 *  @popClose | [boolean] | (false), true        | popup window close after printing
 */
(function($) {
    var counter = 0;
    var modes = { iframe : "iframe", popup : "popup" };
    var defaults = { mode     : modes.popup,
                     popHt    : 500,
                     popWd    : 400,
                     popX     : 0,
                     popY     : 0,
                     popTitle : '',
                     popClose : false,
                     trimSelect:false};

    var settings = {};//global settings

    $.fn.printArea = function( options )
        {
            $.extend( settings, defaults, options );

            counter++;
            var idPrefix = "printArea_";
            $( "[id^=" + idPrefix + "]" ).remove();
            var ele = $(this);

            settings.id = idPrefix + counter;

            var writeDoc;
            var printWindow;

            switch ( settings.mode )
            {
                case modes.iframe :
                    var f = new Iframe();
                    writeDoc = f.doc;
                    printWindow = f.contentWindow || f;
                    break;
                case modes.popup :
                    printWindow = new Popup();
                    writeDoc = printWindow.doc;
            }


            writeDoc.open();
            writeDoc.write("<html>" + getHead() + getBody(ele) + "</html>" );
            writeDoc.close();

            printWindow.focus();
            printWindow.print();

            if ( settings.mode == modes.popup && settings.popClose )
                printWindow.close();
        }

    function getHead()
    {
        var head = "<head><title>" + settings.popTitle + "</title>";
        /*$(document).find("link")
            .filter(function(){
                    return $(this).attr("rel").toLowerCase() == "stylesheet";
                })
            .filter(function(){ // this filter contributed by "mindinquiring"
                    var media = $(this).attr("media");
                    return (media.toLowerCase() == "" || media.toLowerCase() == "print")
                })
            .each(function(){
                    head += '<link type="text/css" rel="stylesheet" href="' + $(this).attr("href") + '" >';
                });*/
		head += "";
		head += '<script src="resources/js/dwz/jquery-1.7.1.js" type="text/javascript"></script>';
		head += '<script src="resources/js/app.util.js" type="text/javascript"></script>';
		head += "<style>";
		head += "html,body,table,tr,td,span,label,div {margin:0; padding:0;font-size:9pt;font-family:arial;} ";
		head += "table {border-collapse:collapse;border-color:#444444;table-layout:fixed;} ";
		head += "table td{text-align:center;} table th{background-color:#DDD;} ";
		head += "#tblexp td.banner {line-height:'25px';font-size: 18px; font-weight: bold; text-align: center; margin: 0;} ";
		head += "#tblexp td.field {background-color: #CFDBEC; line-height: '25px'; text-align: center; margin: 0; width: 120px; font-size: 9pt;} ";
		head += "#tblexp input.textInput {float:none;margin: 5px; width: 80px;} ";
		head += ".print_area{font-size:9pt;} ";
		head += ".print_toptitle{line-height: 30px; font-weight: bold; font-size: 130%;text-align:center;margin:15px 0;} ";
		head += '</style>';
		//head += '<link type="text/css" rel="stylesheet" href="resources/css/print.css" >';
		//head += '<link type="text/css" rel="stylesheet" href="resources/css/common.css" >';
		head += "<script>";
		head += "$(function(){";
		head += 'if($("#cnRMB").size() > 0) {$("#cnRMB").val(Arabia_to_Chinese($("#enRMB").val()))};'
		head += "});";
		head += "</script>";
        head += "</head>";
        return head;
    }
	
	function getTopText()
	{
		return settings.popTitle != "" ? ("<h1 class='print_toptitle'>" + settings.popTitle + "</h1>") : "";
	}

    function getBody( printElement )
    {
		var ele_clone = $(printElement).clone();
		ele_clone.find("table").attr("bordercolor","#444");

        var body = "<body>";
		body += getTopText();
		var bodyHtml;
		if(settings.trimSelect == true)
			bodyHtml = trimSelect($(ele_clone));
		else
			bodyHtml = $(ele_clone).html();
        body += '<div id="'+settings.id+' "class="print_area ' + $(printElement).attr("class") + '">' + bodyHtml + '</div>';
        body += "</body>";
        return body;
    }
    
    function trimSelect($body){
    	$body.find("select").each(function(){
    		$(this).parent().text($(this).val());
    	});
    	$body.find("td.pjf").each(function(){
    		$(this).text("");
    	});
    	return $body.html();
    	
    }

    function Iframe()
    {
        var frameId = settings.id;

        var iframeStyle = 'border:0;position:absolute;width:0px;height:0px;left:0px;top:0px;';
        var iframe;

        try
        {
            iframe = document.createElement('iframe');
            document.body.appendChild(iframe);
            $(iframe).attr({ style: iframeStyle, id: frameId, src: "" });
            iframe.doc = null;
            iframe.doc = iframe.contentDocument ? iframe.contentDocument : ( iframe.contentWindow ? iframe.contentWindow.document : iframe.document);
        }
        catch( e ) { throw e + ". iframes may not be supported in this browser."; }

        if ( iframe.doc == null ) throw "Cannot find document.";

        return iframe;
    }

    function Popup()
    {
        var windowAttr = "location=yes,statusbar=no,directories=no,menubar=no,titlebar=no,toolbar=no,dependent=no";
        //windowAttr += ",width=" + settings.popWd + ",height=" + settings.popHt;
        windowAttr += ",resizable=yes,personalbar=no,scrollbars=yes"; 
		//screenX=" + settings.popX + ",screenY=" + settings.popY + ",personalbar=no,scrollbars=yes";

        var newWin = window.open( "", "_blank",  windowAttr );

        newWin.doc = newWin.document;

        return newWin;
    }
})(jQuery);
