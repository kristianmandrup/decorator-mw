require '../test_setup'

Decoration = require '../../decoration'

describe 'Decoration', ->
  decoration = null

  before ->
    decoration := new Decoration()

  specify 'creates a decoration', ->
    decoration.should.be.an.instanceOf(Decoration)

