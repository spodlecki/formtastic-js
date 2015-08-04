###*
@class SelectFieldHelper
@module FormtasticInput
@param field {String} Name of the field
@param attributes {Object} Field Attributes
@param prefix {String} Form input name's prefix ex: `blog[title]` where prefix='blog'
###

class SelectFieldHelper extends FormtasticInputBase
  constructor: (field, attributes, prefix)->
    throw new Error("Missing :collection for select box.") if typeof(attributes.collection) == 'undefined'
    super(field, attributes, prefix)

  input: =>
    # Setup Configs
    defaults =
      placeholder: @label_name()
      tag: 'select'
      name: @input_name()
      class: Formtastic.default_input_class
      id: @generated_id()
      multiple: @attrs.multiple

    collection = @attrs.collection

    # Draw Select Node
    input_config = _.extend(defaults, @attrs.input_html)
    ele = @createNode(input_config, true)

    # Build Options
    for item in collection
      ele.innerHTML = ele.innerHTML + @_buildSelectOption(item)

    # Return
    ele.outerHTML

  _buildSelectOption: (item)=>
    n = @createNode({tag: 'option'}, true)
    n.innerHTML = item.text

    if _.isArray(item)
      n.value = item[1]
      n.innerHTML = item[0]
    else if _.isObject(item)
      n.value = item.value
      if item.text
        n.innerHTML = item.text
      else if item.label
        n.innerHTML = item.label
      else if item.name
        n.innerHTML = item.name
      else
        item.value
    else
      n.value = item
      n.innerHTML = item

    n.outerHTML
FormtasticInput.SelectFieldHelper = SelectFieldHelper