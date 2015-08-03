###*
@class BooleanFieldHelper
@module Formtastic.Input
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###

window.Formtastic ||= {}
window.Formtastic.Inputs ||= {}

class BooleanFieldHelper extends Formtastic.Input.Base
  label: =>
    null

  input: =>
    _checked_value = =>
      try
        @attrs['checked_value'] || @attrs['value'] || @attrs['input_html']['value']
      catch
        1

    _unchecked_value = =>
      @attrs['unchecked_value'] || '0'

    _hidden_field = (defaults)=>
      input_cfg = _.clone(@attrs['input_html'])
      delete input_cfg['checked'] if input_cfg
      delete defaults['required']
      hidden_config = _.extend(defaults, {type: 'hidden', id: null, value: _unchecked_value()})
      hidden_config = _.extend(hidden_config, input_cfg)
      @createNode(hidden_config)

    defaults =
      tag: 'input'
      type: 'checkbox'
      name: @input_name()
      required: @required
      id: @generated_id()
      value: _checked_value()

    delete defaults['required'] unless @required

    input_config = _.extend(_.clone(defaults), @attrs['input_html'])
    checkbox = @createNode(input_config)
    container = Formtastic.Input.Base.prototype.label.apply(this, [true])
    container.innerHTML = checkbox + ' ' + @label_name()
    container.className = ''

    (_hidden_field(_.clone(defaults)) + container.outerHTML)

window.Formtastic.Input.BooleanFieldHelper = BooleanFieldHelper


###*
@for Formtastic
@method check_box
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###
window.Formtastic.Inputs.check_box = (field, attrs)->
  attrs = _.extend({input_html: {}, attrs})
  attrs['input_html']['type'] = 'checkbox'
  @input(field, attrs)