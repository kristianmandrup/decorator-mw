rek       = require 'rekuire'
requires  = rek 'requires'

requires.test 'test_setup'

assert = require('chai').assert
expect = require('chai').expect

Person = require 'person'

DecorateMw = requires.file 'decorate-mw'

load-mw-stack = new Middleware('model').use(decorate: DecorateMw)

app ||= {}

# should be a global repo
app.decorators.register 'person', Person

person =
    name: 'Joe 6 Pack'
age: 28
clazz: 'person' # important!

# find and instantiate model class via clazz attribute (= 'person')
decorated-person = load-mw-stack.run person