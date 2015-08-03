###*
@class SelectFieldHelper
@module Formtastic.Input
@param field {String} Name of the field
@param attributes {Object} Field Attributes
@param prefix {String} Form input name's prefix ex: `blog[title]` where prefix='blog'
###

window.Formtastic ||= {}
window.Formtastic.Inputs ||= {}

class SelectFieldHelper extends Formtastic.Input.Base
  constructor: (field, attributes, prefix)->
    throw new Error("Missing :collection for select box.") if typeof(attributes['collection']) == 'undefined'
    super(field, attributes, prefix)

  input: =>
    collection = @attrs.collection
    defaults =
      tag: 'select'
      name: @input_name()
      multiple: @attrs['multiple']
      name: @field
      required: @required
      class: @constructor.default_input_class

    input_config = _.extend(defaults, @attrs['input_html'])
    ele = @createNode(input_config, true)

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
      ele.innerHTML = ele.innerHTML + option(item)

    ele.outerHTML

window.Formtastic.Input.SelectFieldHelper = SelectFieldHelper


###*
@for Formtastic
@method select_field
@param field {String} Name of the field
@param attributes {Object} Field Attributes
@returns {Object} `ret.label` and `ret.input` are both html strings
###
window.Formtastic.Inputs.select_field = (field, attrs)->
  attrs = _.extend({}, attrs)
  attrs['as'] = 'select'
  @input(field, attrs)
