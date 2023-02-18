const http = require('http')

const port = process.env.APP_PORT || 5000
const host = process.env.APP_HOST || '0.0.0.0'

const server = http.createServer((req, res) => {
  res.statusCode = 200
  res.setHeader('Content-Type', 'application/json')
  res.write( JSON.stringify({response: "DevOps is great"}) )
  res.end()
});

server.listen(port, host, () => {
  console.log(`Server listening on ${host}:${port}`)
});