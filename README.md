# Decorator Mw

Middleware to serialize object to server and back to client

## TODO

Create test suite

## Decorator

Using `klass` attribute to lookup class on client class Repo (Hash).

Instantiate Class with object

```LiveScript
BaseModel           = requires.file 'base_model'
ContextDecorators   = require('decorator-mw').ContextDecorators

Person = new Class(BaseModel,
  initialize: (obj) ->
    @callSuper!

  fullName: ->
    [@firstName, @lastName].join ' '
)

DecorateMw = requires.file 'decorate-mw'

load-mw-stack = new Middleware('model').use(decorate: DecorateMw)

app ||=
  decorators: new ContextDecorators

# should be a global repo
app.decorators.set 'person', Person

person =
    name: 'Joe 6 Pack'
age: 28
clazz: 'person' # important!

# find and instantiate model class via clazz attribute (= 'person')
decorated-person = load-mw-stack.run person
```

Yeah!

## License

MIT 2014
Copyright 2014 Kristian Mandrup