###*
@class TextFieldHelper
@module Formtastic.Input
@param field {String} Name of the field
@param attributes {Object} Field Attributes
@param prefix {String} Form input name's prefix ex: `blog[title]` where prefix='blog'
###

window.Formtastic ||= {}
window.Formtastic.Inputs ||= {}

class TextFieldHelper extends Formtastic.Input.Base
  constructor: (field, attributes, prefix)->
    super(field, attributes, prefix)

  input: =>
    defaults =
      placeholder: @label_name()
      tag: 'textarea'
      type: (if @as == 'string' then 'text' else @as)
      name: @input_name()
      required: @required
      class: @constructor.default_input_class
      id: @generated_id()

    delete defaults['required'] unless @required

    input_config = _.extend(defaults, @attrs['input_html'])
    value = input_config['value']
    delete input_config['value']
    delete input_config['type']
    delete input_config['as']

    ele = @createNode(input_config, true)
    ele.innerHTML = value
    ele.outerHTML

window.Formtastic.Input.TextFieldHelper = TextFieldHelper


###*
@for Formtastic
@method textarea_field
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###
window.Formtastic.Inputs.textarea_field = (field, attrs)->
  attrs = _.extend({}, attrs)
  attrs['as'] = 'text'
  @input(field, attrs)
