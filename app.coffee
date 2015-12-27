koa = require 'koa'
co = require 'co'

PORT= process.env.PORT || 3000

co ->
  console.log "111"
  app = koa()
  require('./boot')(app)

  console.log $
  console.log $.ApplicationController

  app.listen(PORT)
