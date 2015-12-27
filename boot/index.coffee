Promise = require 'bluebird'
path = Promise.promisifyAll(require 'path')
fs = Promise.promisifyAll(require 'fs')

global.$ = {}
global.ROOT_PATH = path.join __dirname, ".."

loadModule = global.loadModule = (p) ->
  try
    dir = path.join ROOT_PATH, p
    stat = fs.lstatSync dir
    if stat.isDirectory()
      files = fs.readdirSync dir
      for f in files
        loadModule path.join(p, f)
    else
      for k, m of require(dir)
        throw "#{k} has already been loaded" if $[k]?
        $[k] = m
  catch e
    throw e

module.exports = (app) ->
  loadModule 'controllers'
  loadModule 'models'
