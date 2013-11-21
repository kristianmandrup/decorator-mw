require '../test_setup'

ObjDecorator = require '../../obj_decorator'

describe 'ObjDecorator', ->
  objDecorator = null

  before ->
    objDecorator = ObjDecorator()

  specify 'creates a objDecorator', ->
    # Decoration
