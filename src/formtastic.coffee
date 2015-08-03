_.mixin
  isBlank: (object) ->
    switch typeof object
      when 'number' then isNaN(object)
      else _.isEmpty(object)
  isPresent: (object) ->
    !_.isBlank(object)
,
  chain: false

this.Formtastic ||= {}
this.Formtastic.Inputs ||= {}

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
  Merge Default CSS Classes together along with custom specific
  @method merge_css_strings
  @param default_css {String} CSS String to prefix
  @param attrs {Object} Attributes passed on through from initial config
  @param path {String} Path to attr value, ex: `label_html.class`
  @return {String} Merged CSS Class value
  @static
  ###
  @merge_css_strings: (default_css, attrs, path)->
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
  See static method `merge_css_strings`
  @method merge_css_strings
  @private
  ###
  merge_css_strings = @merge_css_strings

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
    css_class = merge_css_strings(@constructor.default_form_class, attrs, 'class')
    delete attrs['class']

    attrs = _.extend({tag: 'form', action: @constructor.default_form_action, class: css_class}, attrs)
    delete attrs['as']
    delete attrs['wrapper_html']
    delete attrs['input_html']
    delete attrs['label']
    delete attrs['url']
    delete attrs['label_html']
    delete attrs['hint']
    @createNode(attrs, true)

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
  input: (field, attributes, prefix) =>
    throw new Error("Required Parameter Missing: 'field'") unless field
    Formtastic.Input.Base.get_inputs_by_config(field, attributes, prefix or @attrs['as'])

  ###*
  @method inputs
  @param [options={}] {Object} Object hash
  @param fn {Function} Inner Input Fields
  @return {String} HTML String built
  ###
  inputs: =>
    options = _.first(arguments)
    fn = _.last(arguments)

    new Formtastic.Inputs(options, fn, @attrs['as']).render()

  ###*
  @method label
  @param name {String} Humanized name of the field
  @param attrs {Object} Attributes passed to the label by :label_html
  @return {String} Outer HTML of Label DOM Node
  @public
  ###
  label: (name, attrs)=>
    return null unless name
    cfg = _.extend({required: false, tag: 'label', class: Formtastic.default_label_class}, attrs)
    required = cfg['required']
    delete cfg['required']

    ele = @createNode(cfg, true)
    ele.innerHTML = name + (if required then Formtastic.required_string else '')
    ele.outerHTML

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
  @static
  ###
  @createNode: =>
    dom.apply(this, arguments)

  createNode: =>
    @constructor.createNode.apply(this, arguments)

for own key, fn of Formtastic.Inputs
  Form.prototype[key] = fn

window.Formtastic = Form