_.mixin
  isBlank: (object) ->
    switch typeof object
      when 'number' then isNaN(object)
      else _.isEmpty(object)
  isPresent: (object) ->
    !_.isBlank(object)
,
  chain: false

window.Formtastic ||= {}
window.Formtastic.Inputs ||= {}

###*
Formtastic builder, for javascript.

@class Formtastic
@param object {Object} Backbone Model or Hash
@param attributes {Object} Attributes to pass on to the <form> element
@param fn {Function} Callback (includes html and inputs being built)
@constructor
###

class Form

  ###*
  Collection of builders for formtastic
  @property builders
  @type Object
  @default {}
  ###
  @builders = {}

  ###*
  Default Form Wrapper Tag Name
  @property default_wrapper_tag
  @default 'li'
  @type String
  ###
  @default_wrapper_tag = 'li'

  ###*
  Default Wrapper CSS Class Name(s)
  @property default_wrapper_class
  @default ''
  @type String
  ###
  @default_wrapper_class = ''


  ###*
  Default Input CSS Class Name(s)
  @property default_input_class
  @default ''
  @type String
  ###
  @default_input_class = ''

  ###*
  Default Form CSS Class Name
  @property default_form_class
  @default 'formtastic'
  @type String
  ###
  @default_form_class = 'formtastic'

  ###*
  Default Label CSS Class Name
  @property default_label_class
  @default 'label'
  @type String
  ###
  @default_label_class = 'label'

  ###*
  Default Input Type to be used if we were not able to guess `:as` value
  @property default_input_type
  @default 'string'
  @type String
  ###
  @default_input_type = 'string'

  ###*
  Default HTML String to use when a field is required. This is appended to the label dom node.
  @property required_string
  @default '*'
  @type String
  ###
  @required_string = '*'

  ###*
  CSS Class applied to all hint dom nodes
  @property default_hint_class
  @default 'inline-hints'
  @type String
  ###
  @default_hint_class = 'inline-hints'

  ###*
  DOM Node Tag to use when writing hints
  @property default_hint_tag
  @default 'p'
  @type String
  ###
  @default_hint_tag = 'p'

  ###*
  Default DOM TagName for fieldset containers.

  @example
  ```
  <fieldset>
    <legend>Names</legend>
    <default_fieldset_inner_tag>
      ... inputs ...
    </default_fieldset_inner_tag>
  </fieldset>
  ```
  @property default_fieldset_inner_tag
  @default 'ol'
  @type String
  ###
  @default_fieldset_inner_tag = 'ol'

  ###*
  Default Form Action for all Formtastic forms
  @property default_form_action
  @default 'javascript:void(0);'
  @type String
  ###
  @default_form_action = 'javascript:void(0);'

  ###*
  Underscore Template to build the form group. Passed attributes are:

  - `label` Compiled Label DOM String
  - `input` Compiled Input DOM String
  - `hint` Compiled Hint DOM String

  @example
  ```
  <%= label %>
  <div class="col-xs-10<% if (!label) { %> col-xs-offset-2<% } %>">
    <%= input %>
  </div>
  ```
  @property template
  @type String
  @default [see example]
  ###
  @template = '<%= label %><%= input %><%= hint %>'

  ###*
  Used to return :as value from the configuration (mainly just convience)
  @method field_prefix
  @return {String} Returns :as from form config
  @private
  ###
  field_prefix = ->
    @attrs['as'] or null

  ###*
  Generate the fields name
  @method field_name
  @param field {String} Field name
  @private
  ###
  field_name = (field)->
    prefix = field_prefix.apply(this, [])
    if prefix?
      _.template('<%= prefix %>[<%= name %>]')({prefix: prefix, name: field})
    else
      _.template('<%= name %>')({prefix: prefix, name: field})

  ###*
  Merge Default CSS Classes together along with custom specific
  @method merge_css_classes
  @param default_css {String} CSS String to prefix
  @param attrs {Object} Attributes passed on through from initial config
  @param path {String} Path to attr value, ex: `label_html.class`
  @return {String} Merged CSS Class value
  ###
  merge_css_classes = (default_css, attrs, path)->
    try
      # Look into replacing eval.
      other_css = eval('attrs.'+path)
      throw new Error("Go to default css.") unless other_css

      _.flatten([
        default_css,
        other_css
      ]).join(' ')

    catch
      default_css

  ###*
  Build an HTML DOM Node and either returns DOMNode or Outer HTML based on 2nd param.
  @method dom
  @param attributes {Object} HTML Attributes to set
  @param [dom_node=false] Return true to get DOMNode instead of string
  @returns {String|DOMNode}
  @private
  ###
  dom = (attributes, dom_node=false)->
    throw new Error("Can't create a DOM Node without a tag.") unless attributes.tag

    ele = document.createElement(attributes.tag)
    delete attributes['tag']

    for own key, value of attributes
      if typeof(value) != 'undefined' and value != null and value != ''
        ele.setAttribute(key, value)

    if dom_node == true then ele else ele.outerHTML

  ###*
  Builds the initial Form Element
  @method form
  @param attrs {Object} HTML Attributes to set
  @returns {DOMNode}
  @private
  ###
  form = (attrs)->
    attrs['action'] ||= attrs['url']
    css_class = merge_css_classes(@constructor.default_form_class, attrs, 'class')
    delete attrs['class']

    attrs = _.extend({tag: 'form', action: @constructor.default_form_action, class: css_class}, attrs)
    delete attrs['as']
    delete attrs['wrapper_html']
    delete attrs['input_html']
    delete attrs['label']
    delete attrs['url']
    delete attrs['label_html']
    delete attrs['hint']
    dom(attrs, true)

  ###*
  Build a form-group using Bootstrap 3
  @method build_template
  @param builder {Object} Object returned from input methods
  @returns {String} Compiled DOM Node based on template
  @private
  ###
  build_template = (builder)->
    container = dom(builder.wrapper, true)
    template = _.template(@constructor.template)
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
  translate_field = (field, attributes)->
    attributes = _.extend({}, attributes)
    as = attributes['as']

    return as if as
    return if /^(.+\_)?password(\_.+)?$/.test(field)
      'password'
    else if /^.+\_id$/.test(field)
      'number'
    else if typeof(attributes['collection']) != 'undefined' and attributes['collection'].length > 0
      'select'
    else if /^(.+)?(phone|fax)$/.test(field)
      'phone'
    else if /^(.+)?email(.+)?$/.test(field)
      'email'
    else
      @constructor.default_input_type


  ###*
  Determines field type based on `:as` declaration and other translations. (See specs for detailed information)

  @method get_inputs_by_config
  @param field {String} String value of field name
  @param attributes {Object} Attributes being passed to the builder
  @private
  ###
  get_inputs_by_config = (field, attributes)->
    as = translate_field.apply(this, [field, attributes])
    attributes = _.extend({as: as}, attributes)

    result = switch as
      when 'text', 'hidden', 'email', 'file', 'number', 'password', 'phone'
        @input_field(field, attributes)
      when 'string'
        @text_field(field, attributes)
      when 'datetime_picker'
        throw("TODO datetime_picker")
      when 'boolean', 'bool', 'checkbox', 'check_box'
        @check_box_field(field, attributes)
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
        @select_field(field, attributes)
      when 'time'
        throw("TODO time")
      when 'url'
        throw("TODO url")
      else
        throw new Error('\''+as+'\' is not a valid field type.')

    result

  constructor: (object, attrs, fn) ->
    @attrs = attrs
    @el = form.apply(this, [attrs])
    @object = object
    @callback = fn

  ###*
  Renders the Form HTML
  @method render
  @returns {String} Outer HTML of Form Element including inputs and inner html
  @public
  ###
  render: =>
    @el.innerHTML = ''
    @el.innerHTML = @callback.apply(window, [this])
    @el.outerHTML

  ###*
  @method label
  @param name {String} Humanized name of the field
  @param attrs {Object} Attributes passed to the label by :label_html
  @return {String} Outer HTML of Label DOM Node
  @public
  ###
  label: (name, attrs)=>
    return null unless name
    cfg = _.extend({required: false, tag: 'label', class: @constructor.default_label_class}, attrs)
    required = cfg['required']
    delete cfg['required']

    ele = @createNode(cfg, true)
    ele.innerHTML = name + (if required then @constructor.required_string else '')
    ele.outerHTML

  ###*
  @method hint
  @param text {String} String for hint
  @return {String} Outer HTML of Hint DOM Node
  @public
  ###
  hint: (text)=>
    return '' unless text
    hint = @createNode({tag: @constructor.default_hint_tag, class: @constructor.default_hint_class}, true)
    hint.innerHTML = text
    hint.outerHTML

  ###*
  ```
  // Generate Text Input
  =f.input('name', {label: "Full Name", wrapper_html: {...}, input_html: {...}, label_html: {...}})
  // Generate a check box
  =f.input('featured', {as: 'bool', label: "Is this featured?", wrapper_html: {...}, input_html: {...}, label_html: {...}})
  ```
  @method input
  @param field {String} Name of the input
  @param attributes {Object} Key/value pair of configs for inputs
  @return {String} HTML String of built form input and label
  @public
  ###
  input: (field, attributes) =>
    throw new Error("Required Parameter Missing: 'field'") unless field
    get_inputs_by_config.apply(this, [field, attributes])

  ###*
  ###
  inputs: =>
    options = _.first(arguments)
    fn = _.last(arguments)
    legend_html = ''

    if !_.isFunction(options) and _.isObject(options)
      legend_name = options['name'] or options['title']
      if legend_name
        legend = @createNode({tag: 'legend'}, true)
        legend.innerHTML = legend_name
        legend_html = legend.outerHTML

      options = _.extend({}, options)
      delete options['name']
      delete options['title']

    else if _.isString(options)
      legend = @createNode({tag: 'legend'}, true)
      legend.innerHTML = options
      legend_html = legend.outerHTML
      options = {}
    else
      options = {}

    fieldset = @createNode( _.extend({tag: 'fieldset', class: 'inputs'}, options), true)
    container = @createNode( _.extend({tag: 'ol'}), true)

    container.innerHTML = fn.apply(window, [this])
    fieldset.innerHTML = legend_html + container.outerHTML
    fieldset.outerHTML

  ###*
  Generates the HTML for the input group. Overwrite this method to make your own HTML Format or simply overwrite property `template`

  @method generate
  @param builder {Object} Hash that is returned by Formtastic.Helpers
  @param attributes {Object} Attributes passed to build the input field
  @return {String} HTML String
  ###
  generate: (builder, attributes)=>
    build_template.apply(this, [builder, attributes])

  ###*
  When creating individual builders, use this.getConfig(field, attributes) to receive information
  about the input and label.

  @example
  ```javascript
  o = {}
  c = new Formtastic(o)
  c.getConfig('name', {label: 'Hi'})
  // {label: {config: {...}, name: 'Hi'}, input: {config: {...}, name: 'name'}, as: 'text', hint: '', attributes: {...}}
  ```
  @method getConfig
  @param field {String} Name of field
  @param attributes {Object} Attributes to be used in the configuration
  @return {Object} (see example)
  ###
  getConfig: (field, attributes)=>
    # Built and split out initial attributes
    attributes = _.extend({as: 'string', required: false}, attributes)
    as = attributes['as']
    required = attributes['required']

    # WRAPPER
    wrapper_css = _.compact([as, @constructor.default_wrapper_class, (if required then 'required' else 'optional')]).join(' ')
    wrapper_css = merge_css_classes(wrapper_css, attributes, 'wrapper_html.class')
    try
      delete attributes.wrapper_html['class']
    catch
    wrapper_config = _.extend({tag: @constructor.default_wrapper_tag, class: wrapper_css}, attributes['wrapper_html'])

    # LABEL
    label_css = merge_css_classes(@constructor.default_label_class, attributes, 'label_html.class')
    try
      delete attributes.label_html['class']
    catch
    label_config = _.extend({required: required, class: label_css}, attributes['label_html'])

    # INPUT
    input_config = _.extend({required: required, class: @constructor.default_input_class}, attributes['input_html'])

    unless required
      delete label_config['required']
      delete input_config['required']

    label_name = attributes['label']
    name = field_name.apply(this, [field])

    delete attributes['wrapper_html']
    delete attributes['label_html']
    delete attributes['input_html']
    delete attributes['label']
    delete attributes['required']

    label =
      config: label_config
      name: label_name

    input =
      config: input_config
      name: name

    {
      attributes: attributes
      wrapper: wrapper_config
      label: label
      input: input
      hint: attributes['hint']
      as: as
    }

  ###*
  Giving access to the private function `dom` - given ability to overwrite if wanted by using the prototype.

  @example
  ```javascript
  o = {}
  c = new Formtastic(o)
  ele = c.createNode({tag: 'span', 'data-url': 'hi'}, true)
  // HTMLDOMNode <span data-url="hi"></span>

  ele = c.createNode({tag: 'span', 'data-url': 'hi'})
  // String <span data-url="hi"></span>
  ```
  @method createNode
  @param attributes {Object} Key/Value pair for all HTML Attributes
  @param [dom_node=false] {Boolean} Determine wether to return DOMNode or String
  @return {Mixed}
  ###
  createNode: =>
    dom.apply(this, arguments)


for own key, fn of Formtastic.Inputs
  Form.prototype[key] = fn

window.Formtastic = Form