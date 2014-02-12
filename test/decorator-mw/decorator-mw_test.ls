Person = require 'person'

DecorateMw = require 'decorate-mw'

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