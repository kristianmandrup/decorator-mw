// Generated by LiveScript 1.2.0
(function(){
  var requires, decorator, assert, expect;
  requires = require('../../requires');
  decorator = requires.file('index');
  requires.test('test_setup');
  assert = require('chai').assert;
  expect = require('chai').expect;
  describe('index', function(){
    describe('DecoratorMw', function(){
      specify('loads ok', function(){
        return expect(decorator.DecoratorMw.constructor).to.not.equal(void 8);
      });
      return specify('can create instance', function(){
        return expect(new decorator.DecoratorMw).to.not['throw'];
      });
    });
    describe('Decorations', function(){
      return specify('loads ok', function(){
        return expect(decorator.Decorations.klass.displayName).to.equal('Class');
      });
    });
    describe('CtxDecorations', function(){
      return specify('loads ok', function(){
        return expect(decorator.CtxDecorations.klass.displayName).to.equal('Class');
      });
    });
    return describe('BaseModel', function(){
      return specify('loads ok', function(){
        return expect(decorator.BaseModel.klass.displayName).to.equal('Class');
      });
    });
  });
}).call(this);