Promise = require 'bluebird'
pm = Promise.promisifyAll(require 'path')
fs = Promise.promisifyAll(require 'fs')

Route = require './route'

global.ROOT_PATH = pm.join __dirname, ".."
INCLUDE_FILES = /\.(coffee|js)$/

global.include = (p, cb) ->
  path = pm.join ROOT_PATH, p
  stat = fs.lstatSync path
  if stat.isDirectory()
    files = fs.readdirSync path
    for f in files
      continue unless f.match INCLUDE_FILES
      include pm.join(p, f), cb
  else
    m = require(path)
    return cb(m) if cb
    for k, v of m
      throw "#{k} has already been loaded" if global[k]?
      global[k] = v

module.exports = (app) ->
  include 'lib'
  include 'app/models'

  app.router = Route
