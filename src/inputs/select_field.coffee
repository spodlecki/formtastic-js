###*
Build basic input with a given type.


```
object = {}
f = new Formtastic(object)
str = f.select_field()
// str.label => DOM String for label
// str.input => DOM String for Input
// str.wrapper => Attributes for wrapper (Object)
```
@for Formtastic
@method select_field
@param field {String} Name of the field
@param attributes {Object} Field Attributes
@returns {Object} `ret.label` and `ret.input` are both html strings
###

window.Formtastic ||= {}
window.Formtastic.Inputs ||= {}

Formtastic.Inputs.select_field = (field, attributes)->
  throw new Error("Missing :collection for select box.") if typeof(attributes['collection']) == 'undefined'

  cfg = @getConfig(field, attributes)
  input = cfg.input
  label = cfg.label
  hint = cfg.hint
  collection = attributes.collection

  defaults =
    tag: 'select'
    type: 'select'
    name: input.name
    multiple: attributes['multiple']

  input_cfg = _.extend(defaults, input.config)

  input = @createNode(input_cfg, true)

  option = (item)=>
    n = @createNode({tag: 'option'}, true)
    n.innerHTML = item.text

    if _.isArray(item)
      n.value = item[1]
      n.innerHTML = item[0]
    else if _.isObject(item)
      n.value = item.value
      n.innerHTML = item.text
    else
      n.value = item
      n.innerHTML = item

    n.outerHTML

  for item in collection
    input.innerHTML = input.innerHTML + option(item)

  result =
    label: @label(label.name, label.config)
    input: input.outerHTML
    hint: @hint(hint)
    wrapper: cfg.wrapper

  @generate(result, attributes)