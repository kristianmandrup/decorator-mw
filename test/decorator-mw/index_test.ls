requires = require '../../requires'
decorator = requires.file 'index'

requires.test 'test_setup'

assert  = require('chai').assert
expect  = require('chai').expect

describe 'index' ->
  describe 'DecoratorMw' ->
    specify 'loads ok' ->
      expect(decorator.DecoratorMw.constructor).to.not.equal void

    specify 'can create instance' ->
      expect(new decorator.DecoratorMw).to.not.throw

  describe 'Decorations' ->
    specify 'loads ok' ->
      expect(decorator.Decorations.klass.display-name).to.equal 'Class'

  describe 'CtxDecorations' ->
    specify 'loads ok' ->
      expect(decorator.CtxDecorations.klass.display-name).to.equal 'Class'

  describe 'BaseModel' ->
    specify 'loads ok' ->
      expect(decorator.BaseModel.klass.display-name).to.equal 'Class'