this.Formtastic ||= {}
this.Formtastic.Input ||= {}
this.Formtastic.Inputs ||= {}

###*
@class Inputs
@module Formtastic
@param object {Mixed} Options
@param fn {Function} Callback (includes html and inputs being built)
@param prefix {String} Prefix / Name of Fieldset
@param nested {Boolean} If the fieldset is nested within another fieldset
@constructor
###

class FormFieldset
  constructor: (options, fn, prefix, nested)->
    if _.isFunction(options)
      @options = {}
    else if _.isObject(options)
      options.name ||= options.title
      delete options.title
      @options = options
    else if _.isString(options)
      @options = {name: options}
    else
      @options = {}

    @prefix = prefix
    @nested = nested
    if _.isFunction(fn)
      @cb = fn
    else
      @cb = null

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
    fieldset = @fieldset()
    container = @container()
    legend = @legend()

    if @cb
      container.innerHTML = @cb.apply(window, [this])
      fieldset.innerHTML = legend + container.outerHTML

    if @nested
      li = @createNode({tag: Formtastic.default_wrapper_tag}, true)
      li.innerHTML = fieldset.outerHTML
      li.outerHTML
    else
      fieldset.outerHTML

  ###*
  @method fieldset
  @return {DOMNode} DOM Node for the Fieldset
  @public
  ###
  fieldset: =>
    defaults =
      tag: 'fieldset'
      class: 'inputs'

    cfg = _.extend(defaults, @options)
    @createNode(cfg, true)

  ###*
  @method legend
  @return {String} Legend's Outer HTML
  @public
  ###
  legend: =>
    return '' unless @options.name
    legend = @createNode({tag: 'legend'}, true)
    legend.innerHTML = @options.name
    legend.outerHTML

  ###*
  @method container
  @return {DOMNode} Container DOM Node that holds all inputs
  @public
  ###
  container: =>
    @createNode({tag: Formtastic.default_fieldset_inner_tag}, true)

  ###*
  @method input
  @param field {String} Name of the input
  @param attributes {Object} Key/value pair of configs for inputs
  @return {String} HTML String of built form input and label
  @public
  ###
  input: (field, attributes) =>
    throw new Error("Required Parameter Missing: 'field'") unless field
    Formtastic.Input.Base.get_inputs_by_config(field, attributes, @namespace())

  ###*
  @method inputs
  @param [options={}] {Object} Object hash
  @param fn {Function} Inner Input Fields
  @return {String} HTML String built
  ###
  inputs:=>
    options = _.first(arguments)
    fn = _.last(arguments)

    new Formtastic.Inputs(options, fn, @namespace(), true).render()

  ###*
  @method namespace
  @return {String} Namespace for fieldset and inputs within
  ###
  namespace: =>
    if @options['for']
      _.template('<%= prefix %>[<%= name %>]')({prefix: @prefix, name: @options['for']})
    else
      _.template('<%= name %>')({prefix: @prefix})

for own key, fn of Formtastic.Inputs
  FormFieldset.prototype[key] = fn

this.Formtastic.Inputs = FormFieldset