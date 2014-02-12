require '../test_setup'

Decoration = require '../../client_decorator'
Decoration = require '../../decoration'

class UserDecorator extends ClientDecorator
  @setter('fullName').on 'firstName', 'lastName', ->
    @fullName = [@firstName, @lastName].join ' '

  (@model, @context) ->
    super ...

  decorate: ->
    super

userDecorator = new UserDecorator

describe 'Decoration', ->
  decoration = null

  before ->
    decoration := new Decoration()

  specify 'creates a decoration', ->
    decoration.should.be.an.instanceOf(Decoration)

  describe 'decorate', ->
    before ->
      Decoration.add userDecorator, 'user'

      decoration = new Decoration(obj, model)
      decorated = decoration.decorateFor(context)

    specify 'creates a decoration', ->
      decoration.should.be.an.instanceOf(Decoration)
