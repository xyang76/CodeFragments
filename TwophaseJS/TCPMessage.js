/**
 * TCPMessage
 * 
 * Messages are split with '\n'
 * 
 */
var net = require('net');

var splitter = '\n';
var BufferedMessage = function(){
	var msg = '';
	this.append = function(data, callback) {
		var j = 0;
		var value = data.toString();
		for(i = 0; i < value.length; i++) {
			if(value.charAt(i) == splitter) {
				msg = msg.concat(value.substring(j, i));
	            console.log('[Recv message]:' + msg); 
				callback(JSON.parse(msg));
				msg = '';
				j = i + 1;
			}
		}
		msg = msg.concat(value.substring(j));
	}
}

var TCPServer = function(host, port) {
	var me = this;
	this.host = host;
	this.port = port;
	this.sockets = [];
	// For server part, publish is broadcast
	this.publish = function(message) {
		var str = JSON.stringify(message) + splitter;
		this.sockets.forEach(function(socket){
			socket.write(str);
		})
	}
	// Subscribe is a callback
	this.subscribe = function(callback) {
		this.subcb = callback;
	}
	this.event = {
		"newclient" : function(me){}	
	}
	this.server = net.createServer();
	this.server.on("connection", function(sock) {
		me.sockets.push(sock);
		var buffer = new BufferedMessage();
		sock.on("data", function(data) {
			buffer.append(data, me.subcb);
		});
		sock.on("close", function(){   
            var index = sockets.indexOf(socket);  
            sockets.splice(index, 1);  
        });  
		
		me.event.newclient(me);
	});
	this.server.listen(port, host);
	this.close = function(){
		this.server.destory();
	}
	console.log("Server Init!");
}

var TCPClient = function(host, port) {
	var me = this;
	var buffer = new BufferedMessage();
	this.host = host;
	this.port = port;
	this.client = new net.Socket();
	this.isConnected = false;
	
	// For client part, publish is send to Server
	this.publish = function(message) {
		if(!this.isConnected) {
			this.connect();
		}
		this.client.write(JSON.stringify(message) + splitter);
		console.log("[Client publish]: " + JSON.stringify(message));
	}
	// Subscribe is also a callback
	this.subscribe = function(callback) {
		this.subcb = callback;
	}
	this.close = function() {
		this.client.end();
	}
	this.connect = function() {
		this.isConnected = true;
		this.client.connect(this.port, this.host, function(){});
		this.client.on("data", function(data) {
			buffer.append(data, me.subcb);
		})
	}
	console.log("Client Init!");
}

module.exports = function(host, port, isServer){
	if(isServer) {
		return new TCPServer(host, port);
	} else {
		return new TCPClient(host, port);
	}
}