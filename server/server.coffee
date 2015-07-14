express = require 'express'

PORT = '8080'

app = express()
app.get '/', (req, res) ->
  res.send 'Hello, Marky'

app.listen PORT
console.log 'Runniing on http://localhost:'+PORT
