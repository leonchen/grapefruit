MOCK_DATA = Object.freeze [
  {id: 1, name: "Tom"}
  {id: 2, name: "Jerry"}
]

class User
  all: ->
    return MOCK_DATA

  find: (id) ->
    return MOCK_DATA.find((u) -> u.id == parseInt(id))


module.exports =
  User: new User()
