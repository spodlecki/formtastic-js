###*
Build basic input with a given type.


```
object = {}
f = new Formtastic(object)
str = f.input_field()
// str.label => DOM String for label
// str.input => DOM String for Input
// str.wrapper => Attributes for wrapper (Object)
```
@for Formtastic
@method input_field
@param field {String} Name of the field
@param attributes {Object} Field Attributes
@returns {Object} `ret.label` and `ret.input` are both html strings
###

window.Formtastic ||= {}
window.Formtastic.Inputs ||= {}

Formtastic.Inputs.input_field = (field, attributes)->
  cfg = @getConfig(field, attributes)
  input = cfg.input
  label = cfg.label
  hint = cfg.hint

  defaults =
    value: @object[input.name]
    placeholder: label.name
    tag: 'input'
    type: cfg.as
    name: input.name

  input_cfg = _.extend(defaults, input.config)

  result =
    label: @label(label.name, label.config)
    input: @createNode(input_cfg)
    hint: @hint(hint)
    wrapper: cfg.wrapper

  @generate(result, attributes)