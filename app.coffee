koa = require 'koa'
co = require 'co'

koaJson = require 'koa-json'
koaBody = require 'koa-body'

PORT= process.env.PORT || 3000

co ->
  try
    app = koa()
    require('./boot')(app)

    app.use koaJson()
    app.use koaBody()

    # custom routes defined here
    # app.router.registerRoute "all", "/login", (ctx, next) ->

    app.router.loadResources(app)

    app.listen(PORT)

  catch e
    console.warn e
    process.exit(1)
