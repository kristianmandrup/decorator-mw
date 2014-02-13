require 'sugar'

rek = require 'rekuire'
_   = require 'prelude-ls'

underscore = (...items) ->
  items = items.flatten!
  strings = items.map (item) ->
    String(item)
  _.map (.underscore!), strings

full-path = (base, ...paths) ->
  upaths = underscore(...paths)
  ['.', base, upaths].flatten!.join '/'

lib-path = (base, ...paths) ->
  upaths = underscore(...paths)
  ['./lib', base, upaths].flatten!.join '/'

test-path = (...paths) ->
  full-path 'test', ...paths

class-path = (...paths) ->
  full-path 'classes', ...paths


module.exports =
  test: (...paths) ->
    require test-path(...paths)

  clazz: (...paths) ->
    @fixture 'classes', paths

  fixture: (...paths) ->
    @test 'fixtures', paths

  file: (...paths) ->
    require lib-path('.', paths)

  # m - alias for module
  m: (path) ->
    @file path

  files: (...paths) ->
    paths.flatten!.map (path) ->
      @file path

  fixtures: (...paths) ->
    paths.flatten!.map (path) ->
      @fixture path

  tests: (...paths) ->
    paths.flatten!.map (path) ->
      @test path