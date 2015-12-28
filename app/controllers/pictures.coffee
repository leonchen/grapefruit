PicturesController =
  resource: "pictures"

  list: (ctx, next) ->
    user = User.find ctx.params.parentId
    user.pictures = Picture.getUserPictures(user)

    ctx.body = user

  show: (ctx, next) ->
    ctx.body = Picture.get(ctx.params.id)


module.exports = PicturesController
