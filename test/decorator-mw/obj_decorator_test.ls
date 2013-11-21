require '../test_setup'

ClientDecorator = require '../../client_decorator'

class UserClientDecorator extends ClientDecorator
  (@model, @context) ->
    super ...

  serverBlueprint: (user) ->
    @propertiesOnly!

  clientBlueprint: (user) ->
    copy = _.deepClone user
    copy.delete 'password'
    copy.delete 'encryptedpassword'
    copy

  customizeFor: (context) ->
    @blueprint

class AccountDecorator extends ObjDecorator
  (@model, @context) ->
    super ...

  type: 'client'

  blueprint: (account) ->
    copy = _.deepClone user

    copy.delete 'password'
    copy.delete 'encryptedpassword'

    copy

  customizeFor: (context) ->
    @blueprint


describe 'ObjDecorator', ->
  objDecorator = null

  before ->
    objDecorator := new ObjDecorator()

  specify 'creates a objDecorator', ->
    objDecorator.should.be.an.instanceOf(ObjDecorator)
