# Decorator Mw

Middleware to serialize object to server and back to client

## Usage

Using `klass` attribute to lookup "class" on client class Repo (Hash).

Simple example

```LiveScript
Person = (data-obj)->
  lo.extend data-obj, {  
    fullName: ->
      [@firstName, @lastName].join ' '
  }
)

person =
    name: 'Joe 6 Pack'
age: 28
clazz: 'person' # important!

decorated-person = decotor-mw.decorate person
```

*Advanced example*

Loaded data object is decorated to become a Class instance:

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

## TODO

Create better test suite!

Please help out ;)

## License

MIT 2014
Copyright 2014 Kristian Mandrup
