const http = require('http');
const server = http.createServer((req, res) => {
	res.writeHead(200, 'OK', { 'Content-Type': 'text/html' });
	res.write('<h1>Hello World</h1>');
	res.end('\n');
});
const port = 3001;
server.listen(port, () => {
	console.log(`Server listening at ${port}...`);
});
