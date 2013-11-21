require '../test_setup'

ClientDecorator = require '../../client_decorator'

class UserDecorator extends ClientDecorator
  @setter('fullName').on 'firstName', 'lastName', ->
    @fullName = [@firstName, @lastName].join ' '

  (@model, @context) ->
    super ...

  decorate: ->
    super

