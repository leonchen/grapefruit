MOCK_DATA = Object.freeze [
  {userId: 1, id: 1, name: "hello.jpg"}
  {userId: 1, id: 2, name: "world.jpg"}
  {userId: 2, id: 3, name: "colorful.jpg"}
]

class Picture
  getUserPictures: (user) ->
    return MOCK_DATA.filter((p) -> p.userId == user.id)

  get: (id) ->
    return MOCK_DATA.find((p) -> p.id == parseInt(id))

module.exports =
  Picture: new Picture()
