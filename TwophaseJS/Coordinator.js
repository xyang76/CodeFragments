/**
 * 
 */
var Coordinator = function(cohorts) {
	var TCPMessage = require('./TCPMessage');
	var tms = new TCPMessage('127.0.0.1', 8888, true); // TCP version JMS
	var me = this;
	this.proposals = [];
	this.propId = 0;
	this.counter = 0;
	
	var callbackFunction = function(proposal) {
		switch(proposal.code) {
			case 'CONNECT':
				break;
			case 'ABORT': 
				me.abort(proposal);
				break;
			case 'COMMIT':
				me.commit(proposal);
				break;
		}
	}
	
	this.run = function() {
		// A callback only if all cohorts are ready
		tms.subscribe(callbackFunction);
		tms.event.newclient = function(){
			if(tms.sockets.length == cohorts) {
				console.log("Coord ready!");
				me.start = new Date();
				for(var i = 0; i < 500; i++) {
					me.request("Hello world" + i, callbackFunction);
				}
			}
		}
	}
	
	this.request = function(msg, callbackFunction) {
		var Proposal = function(msg){
			return {	
				message : msg,
				code : 'REQUEST',
				counter : 0,
				id : me.proposals.length
			}
		}
		var prop = new Proposal(msg);
		this.proposals.push(prop);
		tms.publish(prop);
	}
	
	this.abort = function(prop) {
		var fp = this.proposals[prop.id];
		fp.code = 'DECISIONABORT';
		me.decisionAbort(fp);
	}
	
	this.commit = function(prop) {
		var fp = this.proposals[prop.id];
		fp.counter++;
		if(fp.counter == cohorts) {
			fp.code = 'DECISIONCOMMIT';
			me.decisionCommit(fp);
		}
	}
	
	this.decisionCommit = function(prop) {
		tms.publish(prop);
		me.counter++;
		
		if(me.counter > 400) {
			me.end = new Date();
			var diff = me.end - me.start;
			console.log('[TIME ELAPSE(ms)]' + diff);
		}
	}
	
	this.decisionAbort = function(prop) {
		tms.publish(prop);
		me.counter++;

		if(me.counter> 400) {
			me.end = new Date();
			var diff = me.end - me.start;
			console.log('[TIME ELAPSE(ms)]' + dif);
		}
	}
}

console.log('[Coordinator pid] ' + process.pid);
process.on('message', function(msg){
	if(msg.type == 'init') {
		console.log('[Init] Coordinator init.');
		new Coordinator(msg.cohorts).run();
	}
});