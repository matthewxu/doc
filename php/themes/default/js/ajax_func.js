var XMLHttp = {

	_xmlhttpPool: [],
	_getInstance: function (){
		 for (var i=0; i<this._xmlhttpPool.length; i++){
            if (this._xmlhttpPool[i].readyState == 0 || this._xmlhttpPool[i].readyState == 4){
                return this._xmlhttpPool[i];
            }
        }
        
        // IE5????push??
        this._xmlhttpPool[this._xmlhttpPool.length] = this._createRequest();
        return this._xmlhttpPool[this._xmlhttpPool.length - 1];
	},

	 _createRequest: function (){
		var http_request = false;
	
		if(window.XMLHttpRequest) { //Mozilla 
			http_request = new XMLHttpRequest();
			if (http_request.overrideMimeType) {
				http_request.overrideMimeType("text/xml");
			}
		}
		else if (window.ActiveXObject) { // IE
			var MSXML = ['MSXML2.XMLHTTP.5.0', 'MSXML2.XMLHTTP.4.0', 'MSXML2.XMLHTTP.3.0', 'MSXML2.XMLHTTP', 'Microsoft.XMLHTTP'];
			for(var n = 0; n < MSXML.length; n ++)
            {
                try
                {
                    http_request = new ActiveXObject(MSXML[n]);
                    break;
                }
                catch(e){}
            }
		}
		// mozilla??????readyState??
        if (http_request.readyState == null)
        {
            http_request.readyState = 0;
    
            http_request.addEventListener("load", function ()
                {
                    http_request.readyState = 4;
    
                    if (typeof http_request.onreadystatechange == "function")
                    {
                        http_request.onreadystatechange();
                    }
                },  false);
        }
		if (!http_request) {
			window.alert("??XMLHttpRequest??.");
			return false;
		}
		return http_request;
	},


	send_request:function(method,url,content,responseType,callback) {//
		var xmlHttpRequest= this._getInstance();
		with(xmlHttpRequest){
			try{
				if(method.toLowerCase()=="get") {
					open(method, url, true);
				}else if(method.toLowerCase()=="post") {
					open(method, url, true);
					setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8");
				}else {
					window.alert("http method ??");
					return false;
				}
				send(content);
				onreadystatechange = function (){
					if (xmlHttpRequest.readyState == 4 && (xmlHttpRequest.status == 200 || xmlHttpRequest.status == 304)){
							callback(xmlHttpRequest);
					}
				}					
			}catch(e){
				alert(e);
			}
		}	
	}
};
