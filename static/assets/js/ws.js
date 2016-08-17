function WSSHClient() {
};

WSSHClient.prototype._generateEndpoint = function() {
    if (window.location.protocol == 'https:') {
        var protocol = 'wss://';
    } else {
        var protocol = 'ws://192.168.8.127:8080';
    }
    /*var endpoint = protocol + window.location.host + '/ws';*/
    var endpoint = protocol + '/ws';
    return endpoint;
};

WSSHClient.prototype.connect = function(options) {
    var endpoint = this._generateEndpoint();
    if (window.WebSocket) {
        var endpoint = endpoint + '?hostname=192.168.8.133&port=22&username=root&password=123qwe'
        this._connection = new WebSocket(endpoint);
    }
    else if (window.MozWebSocket) {
        this._connection = MozWebSocket(endpoint);
    }
    else {
        options.onError('WebSocket Not Supported');
        return ;
    }

    this._connection.onopen = function() {
        options.onConnect();
    };

    this._connection.onmessage = function (evt) {
        var data=evt.data.toString()
        options.onData(data);
    };


    this._connection.onclose = function(evt) {
        options.onClose();
    };
};

WSSHClient.prototype.send = function(data) {
    this._connection.send(JSON.stringify(data));
};

/*WSSHClient.prototype.sendInitData=function(options){
    var data= {
        hostname: options.host,
        port: options.port,
        username: options.username,
        password: options.password
    }
    this._connection.send(JSON.stringify({"tp":"init","data":data}))
}*/

WSSHClient.prototype.sendClientData=function(data){
    this._connection.send(JSON.stringify({"tp":"client","data":data}))
}

var client = new WSSHClient();
