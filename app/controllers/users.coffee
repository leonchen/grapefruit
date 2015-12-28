UsersController =
  resource: "users"

  list: (ctx, next) ->
    ctx.body = User.all()

  show: (ctx, next) ->
    user = User.find(ctx.params.id)
    ctx.body = user

module.exports = UsersController
