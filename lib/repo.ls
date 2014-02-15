Class   = require('jsclass/src/core').Class
Hash   = require('jsclass/src/hash').Hash

# keeps its keys in insertion order at all times.
# http://jsclass.jcoglan.com/hash.html
OrderedHash   = require('jsclass/src/hash').OrderedHash

_       = require 'prelude-ls'
lo      = require 'lodash'
require 'sugar'

requires  = require '../requires'

Debugger  = require '../debugger'

Repo = new Class(
  include: Debugger

  initialize: (hash) ->
    @repository = new OrderedHash
    return if hash is void

    @init-repo hash
    @repository.setDefault(void)
    @

  init-repo: (hash) ->
    self = @
    switch typeof hash
    case 'Hash', 'OrderedHash'
      hash.forEach (pair) ->
        self.repository.store pair.key, pair.value
    case 'object'
      _.keys(hash).each (name) ->
        self.repository.store name, hash[name]
    default
      throw Error "Must be a Hash like object, was : #{typeof klass} #{hash}"
)

module.exports = Repo