window.Formtastic ||= {}
window.Formtastic.Input ||= {}

class Formtastic.Input.Base
  ###*
  See `Formtastic.merge_css_strings`
  @method merge_css_strings
  @private
  ###
  merge_css_strings = Formtastic.merge_css_strings

  # https://gist.github.com/cyberfox/1301931
  humanize = (property)->
    property.replace(/_/g, ' ').replace /(\w+)/g, (match) ->
      match.charAt(0).toUpperCase() + match.slice(1)

  ###*
  Build a form-group using Bootstrap 3
  @method build_template
  @param builder {Object} Object returned from input methods
  @returns {String} Compiled DOM Node based on template
  @private
  ###
  build_template = (builder)->
    container = builder.wrapper
    template = _.template(Formtastic.template)
    container.innerHTML = template({input: builder['input'], label: builder['label'], hint: builder['hint']})
    container.outerHTML

  ###*
  Determine field type (`:as`) automagically by reading the field's name.

  @example
    =f.input('password') // turns into a password field
    =f.input('password_confirmation') // turns into a password field
    =f.input('post_id') // turns into a number field
    =f.input('categories', collection: [{value: '1', text: 'Green'}, {value: '2', text: 'Yellow'}]) // turns into a select field

  @method translate_field
  @param field {String} String value of field name
  @param attributes {Object} Attributes being passed to the builder
  @return {String} Returns autotranslated field type (`:as`)
  @private
  ###
  translate_field = (field, attrs)->
    attrs = _.extend({}, attrs)
    as = attrs['as']

    return as if as
    return if /^(.+\_)?password(\_.+)?$/.test(field)
      'password'
    else if /^.+\_id$/.test(field)
      'number'
    else if typeof(attrs['collection']) != 'undefined' and attrs['collection'].length > 0
      'select'
    else if /^(.+)?(phone|fax)$/.test(field)
      'phone'
    else if /^(.+)?email(.+)?$/.test(field)
      'email'
    else
      Formtastic.default_input_type

  ###*
  Determines field type based on `:as` declaration and other translations. (See specs for detailed information)

  @method get_inputs_by_config
  @param field {String} String value of field name
  @param attributes {Object} Attributes being passed to the builder
  @static
  ###
  @get_inputs_by_config: (field, attrs, prefix)->
    as = translate_field(field, attrs)
    attrs = _.extend({as: as, prefix: prefix}, attrs)

    result = switch as
      when 'hidden', 'email', 'file', 'number', 'password', 'phone', 'string'
        new Formtastic.Input.TextFieldHelper(field, attrs)
      when 'text'
        throw("TODO: textarea")
      when 'datetime_picker'
        throw("TODO datetime_picker")
      when 'boolean', 'bool', 'checkbox', 'check_box'
        new Formtastic.Input.BooleanFieldHelper(field, attrs)
      when 'date'
        throw("TODO date")
      when 'date_picker'
        throw("TODO date_picker")
      when 'radio'
        throw("TODO radio")
      when 'range'
        throw("TODO range")
      when 'search'
        throw("TODO search")
      when 'select'
        new Formtastic.Input.SelectFieldHelper(field, attrs)
      when 'time'
        throw("TODO time")
      when 'url'
        throw("TODO url")
      else
        throw new Error('\''+as+'\' is not a valid field type.')

    result.render()

  constructor: (field, attrs)->
    attrs = _.extend({required: false}, attrs)

    @field = field
    @attrs = attrs
    @as = attrs['as']
    @required = attrs['required']
    @prefix = attrs['prefix']

  ###*
  See `Formtastic.createNode`
  @method createNode
  @public
  ###
  createNode: =>
    Formtastic.createNode.apply(this, arguments)

  ###*
  Call render to show your form item
  @method render
  @return outerHTML of wrapped form-group
  @public
  ###
  render: =>
    result =
      label: @label()
      input: @input()
      hint: @hint()
      wrapper: @wrapper()

    @generate(result)

  ###*
  @method label
  @return {String} Outer HTML of Label DOM Node
  @public
  ###
  label: (dom)=>
    return null unless @label_name()

    defaults =
      tag: 'label'
      class: merge_css_strings(Formtastic.default_label_class, @attrs, 'label_html.class')
      for: @generated_id()

    try
      delete @attrs.label_html['class']
    catch

    label_config = _.extend(defaults, @attrs['label_html'])

    ele = @createNode(label_config, true)
    ele.innerHTML = @label_name() + (if @required then Formtastic.required_string else '')

    return if dom then ele else ele.outerHTML

  ###*
  Returns label name based off :label option
  @method label_name
  @return {String}
  @public
  ###
  label_name: =>
    return if @attrs['label'] is false
    @attrs['label'] || humanize(@field)

  ###*
  @method input
  @return {String} Outer HTML of Input DOM Node
  @public
  ###
  input: =>
    # value: @object[input.name]

    defaults =
      placeholder: @label_name()
      tag: 'input'
      type: (if @as == 'string' then 'text' else @as)
      name: @input_name()
      required: @required
      class: @constructor.default_input_class
      id: @generated_id()

    delete defaults['required'] unless @required

    input_config = _.extend(defaults, @attrs['input_html'])
    ele = @createNode(input_config, true)
    ele.outerHTML

  ###*
  @method input_name
  @return {String} Built Input Name based on params
  @public
  ###
  input_name: =>
    if @attrs['input_html'] and @attrs['input_html']['name']
      @attrs['input_html']['name']
    else
      if @prefix
        _.template('<%= prefix %>[<%= name %>]')({prefix: @prefix, name: @field})
      else
        _.template('<%= name %>')({prefix: @prefix, name: @field})

  input_value: =>
    null

  generated_id: =>
    return @attrs['id'] if @attrs['id']

    _.compact([
      @prefix,
      @field
    ]).join('_').replace(/\[|\]/,'_').replace(/\s/,'')

  ###*
  @method hint
  @return {String} Outer HTML of Hint DOM Node
  @public
  ###
  hint:=>
    return null unless @attrs['hint']
    hint = @createNode({tag: Formtastic.default_hint_tag, class: Formtastic.default_hint_class}, true)
    hint.innerHTML = @attrs['hint']
    hint.outerHTML

  ###*
  @method wrapper
  @return {DOMNode} HTML DOM Node
  @public
  ###
  wrapper: =>
    wrapper_css = _.compact([
      @as,
      Formtastic.default_wrapper_class,
      (if @required then 'required' else 'optional'),
      'input'
    ]).join(' ')
    wrapper_css = merge_css_strings(wrapper_css, @attrs, 'wrapper_html.class')

    try
      delete @attrs.wrapper_html['class']
    catch

    defaults =
      tag: Formtastic.default_wrapper_tag
      class: wrapper_css
      id: @generated_id()+'_input'

    wrapper_config = _.extend(defaults, @attrs['wrapper_html'])
    @createNode(wrapper_config, true)

  ###*
  Generates the HTML for the input group. Overwrite this method to make your own HTML Format or simply overwrite property `template`

  @method generate
  @param builder {Object} Hash that is returned by Formtastic.Helpers
  @return {String} HTML String
  ###
  generate: (builder)=>
    build_template.apply(this, [builder])
