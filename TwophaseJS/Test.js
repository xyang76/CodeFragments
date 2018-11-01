const http = require('http');

const hostname = '127.0.0.1';
const port = 8080;

function sleep(ms) {
	var start = new Date();
	while(new Date() - start < ms) {
		
	}
}

const server = http.createServer((req, res) => {
  console.log('This message 3.0 print out!' + process.pid);
  sleep(15000); 
  console.log('This message 3.1 print out!' + process.pid);
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello World\n');
});
server.listen(port, hostname, () => {
  console.log('Server running at http://${hostname}:${port}/`');
});
console.log('This message 1 print out!' + process.pid);
sleep(20000);
console.log('This message 2 print out!' + process.pid);