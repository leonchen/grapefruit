R = require('koa-router')()
P = require 'pluralize'

class Route
  constructor: ->
    @resources = {}

  loadResources: (app)->
    include 'app/controllers', (c) =>
      @registerResource c if c.resource
    @dispatch(app)

  registerResource: (controller) ->
    throw "resource is required" unless controller.resource
    @resources[controller.resource] = controller

  registerRoute: (method, path, handler) ->
    R[method.toLowerCase()](path, handler)

  dispatch: (app) ->
    R.get "/:resource", @getAction("list", {p: true})
    R.post "/:resource", @getAction("create", {p: true})
    R.get "/:resource/:id", @getAction("show", {p: false})
    R.put "/:resource/:id", @getAction("update", {p: false})
    R.delete "/:resource/:id", @getAction("delete", {p: false})

    R.get "/:parentResource/:parentId/:resource", @getAction("list", {p: true})
    R.post "/:parentResource/:parentId/:resource", @getAction("create", {p: true})
    R.get "/:parentResource/:parentId/:resource/:id", @getAction("show", {p: false})
    R.put "/:parentResource/:parentId/:resource/:id", @getAction("update", {p: false})
    R.delete "/:parentResource/:parentId/:resource/:id", @getAction("delete", {p: false})

    app.use R.routes()
    app.use R.allowedMethods()

  getAction: (action, opts) ->
    self = @
    return (next) ->
      if pr = @.params.parentResource
        unless self.resources[P(pr)]
          @.status = 404
          yield next
          return

      r = @.params.resource
      resource = if opts.p then r else P(r)
      handler = self.resources[resource]?[action]
      unless handler
        @.status = 404
        yield next
        return

      yield handler(@, next)


module.exports = new Route()
