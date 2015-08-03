(function() {
  var BooleanFieldHelper, Form, FormFieldset, FormtasticHelpers, FormtasticInput, FormtasticInputs, HiddenFieldHelper, InputBase, SelectFieldHelper, StringFieldHelper, TextFieldHelper, extend,
    hasProp = {}.hasOwnProperty,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend1 = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.Formtastic || (this.Formtastic = {});

  FormtasticInput = {};

  FormtasticInputs = {};

  FormtasticHelpers = {};

  extend = function(src, dest) {
    var fn, key, results;
    results = [];
    for (key in src) {
      if (!hasProp.call(src, key)) continue;
      fn = src[key];
      results.push(dest.prototype[key] = fn);
    }
    return results;
  };

  _.mixin({
    isBlank: function(object) {
      switch (typeof object) {
        case 'number':
          return _.isNaN(object);
        default:
          return _.isEmpty(object);
      }
    },
    isPresent: function(object) {
      return !_.isBlank(object);
    }
  }, {
    chain: false
  });


  /**
  @for Formtastic
  @method check_box
  @param field {String} Name of the field
  @param attributes {Object} Field Attributes
   */

  FormtasticHelpers.check_box = function(field, attrs) {
    attrs = _.extend({
      as: 'boolean'
    }, attrs);
    return this.input(field, attrs);
  };


  /**
  @for Formtastic
  @method email_field
  @param field {String} Name of the field
  @param attributes {Object} Field Attributes
   */

  FormtasticHelpers.email_field = function(field, attrs) {
    attrs = _.extend({
      as: 'email'
    }, attrs);
    return this.input(field, attrs, void 0, true);
  };


  /**
  @for Formtastic
  @method file_field
  @param field {String} Name of the field
  @param attributes {Object} Field Attributes
   */

  FormtasticHelpers.file_field = function(field, attrs) {
    attrs = _.extend({
      as: 'file'
    }, attrs);
    return this.input(field, attrs, void 0, true);
  };


  /**
  @for Formtastic
  @method string_field
  @param field {String} Name of the field
  @param attributes {Object} Field Attributes
   */

  FormtasticHelpers.hidden_field = function(field, attrs) {
    attrs = _.extend({
      as: 'hidden'
    }, attrs);
    return this.input(field, attrs, void 0, true);
  };


  /**
  @for Formtastic
  @method label
  @param field {String} Name of the field
  @param attributes {Object} Field Attributes
   */

  FormtasticHelpers.label = function(name, attrs) {
    var cfg, ele, required;
    if (!name) {
      return null;
    }
    cfg = _.extend({
      required: false,
      tag: 'label',
      "class": Formtastic.default_label_class
    }, attrs);
    required = cfg.required;
    delete cfg.required;
    ele = this.createNode(cfg, true);
    ele.innerHTML = name + (required ? Formtastic.required_string : '');
    return ele.outerHTML;
  };


  /**
  @for Formtastic
  @method number_field
  @param field {String} Name of the field
  @param attributes {Object} Field Attributes
   */

  FormtasticHelpers.number_field = function(field, attrs) {
    attrs = _.extend({
      as: 'number'
    }, attrs);
    return this.input(field, attrs, void 0, true);
  };


  /**
  @for Formtastic
  @method password_field
  @param field {String} Name of the field
  @param attributes {Object} Field Attributes
   */

  FormtasticHelpers.password_field = function(field, attrs) {
    attrs = _.extend({
      as: 'password'
    }, attrs);
    return this.input(field, attrs, void 0, true);
  };


  /**
  @for Formtastic
  @method search_field
  @param field {String} Name of the field
  @param attributes {Object} Field Attributes
   */

  FormtasticHelpers.search_field = function(field, attrs) {
    attrs = _.extend({
      as: 'search'
    }, attrs);
    return this.input(field, attrs, void 0, true);
  };


  /**
  @for Formtastic
  @method select_field
  @param field {String} Name of the field
  @param attributes {Object} Field Attributes
   */

  FormtasticHelpers.select = function(field, attrs) {
    attrs = _.extend({
      as: 'select'
    }, attrs);
    return this.input(field, attrs);
  };


  /**
  @for Formtastic
  @method telephone_field
  @param field {String} Name of the field
  @param attributes {Object} Field Attributes
   */

  FormtasticHelpers.phone_field = FormtasticHelpers.telephone_field = function(field, attrs) {
    attrs = _.extend({
      as: 'phone'
    }, attrs);
    return this.input(field, attrs, void 0, true);
  };


  /**
  @for Formtastic
  @method text_area
  @param field {String} Name of the field
  @param attributes {Object} Field Attributes
   */

  FormtasticHelpers.text_area = function(field, attrs) {
    attrs = _.extend({}, attrs);
    attrs.as = 'text';
    return this.input(field, attrs, void 0, true);
  };


  /**
  @for Formtastic
  @method text_field
  @param field {String} Name of the field
  @param attributes {Object} Field Attributes
   */

  FormtasticHelpers.text_field = function(field, attrs) {
    attrs = _.extend({
      as: 'string'
    }, attrs);
    return this.input(field, attrs, void 0, true);
  };


  /**
  @for Formtastic
  @method text_field
  @param field {String} Name of the field
  @param attributes {Object} Field Attributes
   */

  FormtasticHelpers.url_field = function(field, attrs) {
    attrs = _.extend({
      as: 'url'
    }, attrs);
    return this.input(field, attrs, void 0, true);
  };


  /**
  Formtastic builder, for javascript.
  
  @class Formtastic
  @param object {Object} Backbone Model or Hash
  @param attributes {Object} Attributes to pass on to the <form> element
  @param fn {Function} Callback (includes html and inputs being built)
  @constructor
   */

  Form = (function() {

    /**
    Collection of builders for formtastic
    @property builders
    @type Object
    @default {}
     */
    var dom, form, merge_css_strings, set_callback, set_options;

    Form.builders = {};


    /**
    Default Form Wrapper Tag Name
    @property default_wrapper_tag
    @default 'li'
    @type String
     */

    Form.default_wrapper_tag = 'li';


    /**
    Default Wrapper CSS Class Name(s)
    @property default_wrapper_class
    @default ''
    @type String
     */

    Form.default_wrapper_class = '';


    /**
    Default Input CSS Class Name(s)
    @property default_input_class
    @default ''
    @type String
     */

    Form.default_input_class = '';


    /**
    Default Form CSS Class Name
    @property default_form_class
    @default 'formtastic'
    @type String
     */

    Form.default_form_class = 'formtastic';


    /**
    Default Label CSS Class Name
    @property default_label_class
    @default 'label'
    @type String
     */

    Form.default_label_class = 'label';


    /**
    Default Input Type to be used if we were not able to guess `:as` value
    @property default_input_type
    @default 'string'
    @type String
     */

    Form.default_input_type = 'string';


    /**
    Default HTML String to use when a field is required. This is appended to the label dom node.
    @property required_string
    @default '*'
    @type String
     */

    Form.required_string = '*';


    /**
    CSS Class applied to all hint dom nodes
    @property default_hint_class
    @default 'inline-hints'
    @type String
     */

    Form.default_hint_class = 'inline-hints';


    /**
    DOM Node Tag to use when writing hints
    @property default_hint_tag
    @default 'p'
    @type String
     */

    Form.default_hint_tag = 'p';


    /**
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
     */

    Form.default_fieldset_inner_tag = 'ol';


    /**
    Default Form Action for all Formtastic forms
    @property default_form_action
    @default '#'
    @type String
     */

    Form.default_form_action = '#';


    /**
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
     */

    Form.template = '<%= label %><%= input %><%= hint %>';


    /**
    Merge Default CSS Classes together along with custom specific
    @method merge_css_strings
    @param default_css {String} CSS String to prefix
    @param attrs {Object} Attributes passed on through from initial config
    @param path {String} Path to attr value, ex: `label_html.class`
    @return {String} Merged CSS Class value
    @static
     */

    Form.merge_css_strings = function(default_css, attrs, path) {
      var other_css;
      try {
        other_css = eval('attrs.' + path);
        if (!other_css) {
          throw new Error("Go to default css.");
        }
        return _.flatten([default_css, other_css]).join(' ');
      } catch (_error) {
        return default_css;
      }
    };


    /**
    See static method `merge_css_strings`
    @method merge_css_strings
    @private
     */

    merge_css_strings = Form.merge_css_strings;


    /**
    Build an HTML DOM Node and either returns DOMNode or Outer HTML based on 2nd param.
    @method dom
    @param attributes {Object} HTML Attributes to set
    @param [dom_node=false] Return true to get DOMNode instead of string
    @returns {String|DOMNode}
    @private
     */

    dom = function(attributes, dom_node) {
      var ele, key, value;
      if (typeof dom_node === 'undefined') {
        dom_node = false;
      }
      if (!attributes.tag) {
        throw new Error("Can't create a DOM Node without a tag.");
      }
      ele = document.createElement(attributes.tag);
      delete attributes.tag;
      for (key in attributes) {
        if (!hasProp.call(attributes, key)) continue;
        value = attributes[key];
        if (typeof value !== 'undefined' && value !== null && value !== '') {
          ele.setAttribute(key, value);
        }
      }
      if (dom_node === true) {
        return ele;
      } else {
        return ele.outerHTML;
      }
    };


    /**
    Builds the initial Form Element
    @method form
    @param attrs {Object} HTML Attributes to set
    @returns {DOMNode}
    @private
     */

    form = function(attrs) {
      var css_class;
      attrs.action || (attrs.action = attrs.url);
      css_class = merge_css_strings(this.constructor.default_form_class, attrs, 'class');
      delete attrs['class'];
      attrs = _.extend({
        tag: 'form',
        action: this.constructor.default_form_action,
        "class": css_class
      }, attrs);
      delete attrs.as;
      delete attrs.wrapper_html;
      delete attrs.input_html;
      delete attrs.label;
      delete attrs.url;
      delete attrs.label_html;
      delete attrs.hint;
      return this.createNode(attrs, true);
    };

    set_options = function(attrs) {
      if (_.isFunction(attrs)) {
        return {};
      } else if (_.isObject(attrs)) {
        return attrs;
      } else if (_.isString(attrs)) {
        return {
          as: attrs
        };
      } else {
        return {};
      }
    };

    set_callback = function(fn) {
      if (_.isFunction(fn)) {
        return fn;
      } else {
        return null;
      }
    };

    function Form(object, attrs) {
      this.createNode = bind(this.createNode, this);
      this.inputs = bind(this.inputs, this);
      this.input = bind(this.input, this);
      this.render = bind(this.render, this);
      this.attrs = set_options(attrs);
      this.el = form.apply(this, [this.attrs]);
      this.object = object;
      this.callback = set_callback(_.last(arguments));
    }


    /**
    Renders the Form HTML
    @method render
    @returns {String} Outer HTML of Form Element including inputs and inner html
    @public
     */

    Form.prototype.render = function() {
      this.el.innerHTML = '';
      this.el.innerHTML = this.callback.apply(window, [this]);
      return this.el.outerHTML;
    };


    /**
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
     */

    Form.prototype.input = function(field, attributes, prefix, raw) {
      var i;
      if (!field) {
        throw new Error("Required Parameter Missing: 'field'");
      }
      i = FormtasticInput.Base.get_inputs_by_config(field, attributes, prefix || (this.attrs && this.attrs.as));
      if (raw) {
        return i.input();
      } else {
        return i.render();
      }
    };


    /**
    @method inputs
    @param [options={}] {Object} Object hash
    @param fn {Function} Inner Input Fields
    @return {String} HTML String built
     */

    Form.prototype.inputs = function() {
      var fn, options;
      options = _.first(arguments);
      fn = _.last(arguments);
      return new FormtasticInputs(options, fn, this.attrs.as).render();
    };


    /**
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
     */

    Form.createNode = function() {
      return dom.apply(Form, arguments);
    };

    Form.prototype.createNode = function() {
      return this.constructor.createNode.apply(this, arguments);
    };

    return Form;

  })();

  extend(FormtasticHelpers, Form);

  this.Formtastic = Form;


  /**
  @class Base
  @module FormtasticInput
  @param object {Object} Backbone Model or Hash
  @param attributes {Object} Attributes to pass on to the <form> element
  @param fn {Function} Callback (includes html and inputs being built)
  @constructor
   */

  InputBase = (function() {

    /**
    See `Formtastic.merge_css_strings`
    @method merge_css_strings
    @private
     */
    var build_template, humanize, merge_css_strings, translate_field;

    merge_css_strings = Formtastic.merge_css_strings;


    /**
    Equivilant to rails' "blog_post".humanize
    @method humanize
    @param property {String}
    @credit https://gist.github.com/cyberfox/1301931
     */

    humanize = function(property) {
      return property.replace(/_/g, ' ').replace(/(\w+)/g, function(match) {
        return match.charAt(0).toUpperCase() + match.slice(1);
      });
    };


    /**
    Build a form-group using Bootstrap 3
    @method build_template
    @param builder {Object} Object returned from input methods
    @returns {String} Compiled DOM Node based on template
    @private
     */

    build_template = function(builder) {
      var container, template;
      container = builder.wrapper;
      template = _.template(Formtastic.template);
      container.innerHTML = template({
        input: builder.input,
        label: builder.label,
        hint: builder.hint,
        attrs: this.attrs
      });
      return container.outerHTML;
    };


    /**
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
     */

    translate_field = function(field, attrs) {
      var as;
      attrs = _.extend({}, attrs);
      as = attrs.as;
      if (as) {
        return as;
      }
      if (/^(.+\_)?password(\_.+)?$/.test(field)) {
        return 'password';
      } else if (/^.+\_id$/.test(field)) {
        return 'number';
      } else if (typeof attrs.collection !== 'undefined' && attrs.collection.length > 0) {
        return 'select';
      } else if (/^(.+)?(phone|fax)(\_.+)?$/.test(field)) {
        return 'phone';
      } else if (/^(.+)?email(.+)?$/.test(field)) {
        return 'email';
      } else if (/^(.+\_)?url(\_.+)?$/.test(field)) {
        return 'url';
      } else if (/^(.+\_)?search(\_.+)?$/.test(field)) {
        return 'search';
      } else {
        return Formtastic.default_input_type;
      }
    };


    /**
    Determines field type based on `:as` declaration and other translations. (See specs for detailed information)
    
    @method get_inputs_by_config
    @param field {String} String value of field name
    @param attributes {Object} Attributes being passed to the builder
    @static
     */

    InputBase.get_inputs_by_config = function(field, attrs, prefix) {
      var as, result;
      as = translate_field(field, attrs);
      attrs = _.extend({
        as: as,
        prefix: prefix
      }, attrs);

      /**
      TODO:
        datetime_picker, date, date_picker, radio, range, time
       */
      return result = (function() {
        switch (as) {
          case 'email':
          case 'file':
          case 'number':
          case 'password':
          case 'phone':
          case 'string':
          case 'url':
          case 'search':
            return new FormtasticInput.StringFieldHelper(field, attrs);
          case 'hidden':
            return new FormtasticInput.HiddenFieldHelper(field, attrs);
          case 'text':
            return new FormtasticInput.TextFieldHelper(field, attrs);
          case 'boolean':
          case 'bool':
          case 'checkbox':
          case 'check_box':
            return new FormtasticInput.BooleanFieldHelper(field, attrs);
          case 'select':
            return new FormtasticInput.SelectFieldHelper(field, attrs);
          default:
            throw new Error('\'' + as + '\' is not a valid field type.');
        }
      })();
    };

    function InputBase(field, attrs) {
      this.generate = bind(this.generate, this);
      this.wrapper = bind(this.wrapper, this);
      this.hint = bind(this.hint, this);
      this.generated_id = bind(this.generated_id, this);
      this.input_value = bind(this.input_value, this);
      this.input_name = bind(this.input_name, this);
      this.input = bind(this.input, this);
      this.label_name = bind(this.label_name, this);
      this._label_node = bind(this._label_node, this);
      this.render = bind(this.render, this);
      this.createNode = bind(this.createNode, this);
      attrs = _.extend({
        required: false
      }, attrs);
      this.field = field;
      this.attrs = attrs;
      this.as = attrs.as;
      this.required = attrs.required;
      this.prefix = attrs.prefix;
    }


    /**
    See `Formtastic.createNode`
    @method createNode
    @public
     */

    InputBase.prototype.createNode = function() {
      return Formtastic.createNode.apply(this, arguments);
    };


    /**
    Call render to show your form item
    @method render
    @return outerHTML of wrapped form-group
    @public
     */

    InputBase.prototype.render = function() {
      var result;
      result = {
        label: this._label_node(),
        input: this.input(),
        hint: this.hint(),
        wrapper: this.wrapper()
      };
      return this.generate(result);
    };


    /**
    @method label
    @return {String} Outer HTML of Label DOM Node
    @public
     */

    InputBase.prototype._label_node = function(dom) {
      var defaults, ele, label_config;
      if (!this.label_name()) {
        return null;
      }
      defaults = {
        tag: 'label',
        "class": merge_css_strings(Formtastic.default_label_class, this.attrs, 'label_html.class'),
        "for": this.generated_id()
      };
      try {
        delete this.attrs.label_html['class'];
      } catch (_error) {

      }
      label_config = _.extend(defaults, this.attrs.label_html);
      ele = this.createNode(label_config, true);
      ele.innerHTML = this.label_name() + (this.required ? Formtastic.required_string : '');
      if (dom) {
        return ele;
      } else {
        return ele.outerHTML;
      }
    };


    /**
    Returns label name based off :label option
    @method label_name
    @return {String}
    @public
     */

    InputBase.prototype.label_name = function() {
      if (this.attrs.label === false) {
        return;
      }
      return this.attrs.label || humanize(this.field);
    };


    /**
    @method input
    @return {String} Outer HTML of Input DOM Node
    @public
     */

    InputBase.prototype.input = function(config) {
      var defaults, ele, input_config;
      defaults = {
        placeholder: this.label_name(),
        tag: 'input',
        type: (this.as === 'string' ? 'text' : this.as),
        name: this.input_name(),
        required: this.required,
        "class": Formtastic.default_input_class,
        id: this.generated_id()
      };
      defaults = _.extend(defaults, config);
      if (!this.required) {
        delete defaults.required;
      }
      input_config = _.extend(defaults, this.attrs.input_html);
      ele = this.createNode(input_config, true);
      return ele.outerHTML;
    };


    /**
    @method input_name
    @return {String} Built Input Name based on params
    @public
     */

    InputBase.prototype.input_name = function() {
      if (this.attrs.input_html && this.attrs.input_html.name) {
        return this.attrs.input_html.name;
      } else {
        if (this.prefix) {
          return _.template('<%= prefix %>[<%= name %>]')({
            prefix: this.prefix,
            name: this.field
          });
        } else {
          return _.template('<%= name %>')({
            prefix: this.prefix,
            name: this.field
          });
        }
      }
    };


    /**
    TODO: Return the objects value and set value on input
    @method input_value
    @return {Mixed}
    @public
    @beta
     */

    InputBase.prototype.input_value = function() {
      return null;
    };


    /**
    Generates the ID for the input field.
    @method generate_id
    @return {String}
    @public
     */

    InputBase.prototype.generated_id = function() {
      if (this.attrs.id) {
        return this.attrs.id;
      }
      return _.compact([this.prefix, this.field]).join('_').replace(/\[|\]/, '_').replace(/\s/, '');
    };


    /**
    @method hint
    @return {String} Outer HTML of Hint DOM Node
    @public
     */

    InputBase.prototype.hint = function() {
      var hint;
      if (!this.attrs.hint) {
        return null;
      }
      hint = this.createNode({
        tag: Formtastic.default_hint_tag,
        "class": Formtastic.default_hint_class
      }, true);
      hint.innerHTML = this.attrs.hint;
      return hint.outerHTML;
    };


    /**
    @method wrapper
    @return {DOMNode} HTML DOM Node
    @public
     */

    InputBase.prototype.wrapper = function() {
      var defaults, wrapper_config, wrapper_css;
      wrapper_css = _.compact([this.as, Formtastic.default_wrapper_class, (this.required ? 'required' : 'optional'), 'input']).join(' ');
      wrapper_css = merge_css_strings(wrapper_css, this.attrs, 'wrapper_html.class');
      try {
        delete this.attrs.wrapper_html['class'];
      } catch (_error) {

      }
      defaults = {
        tag: Formtastic.default_wrapper_tag,
        "class": wrapper_css,
        id: this.generated_id() + '_input'
      };
      wrapper_config = _.extend(defaults, this.attrs.wrapper_html);
      return this.createNode(wrapper_config, true);
    };


    /**
    Generates the HTML for the input group. Overwrite this method to make your own HTML Format or simply overwrite property `template`
    
    @method generate
    @param builder {Object} Hash that is returned by Formtastic.Helpers
    @return {String} HTML String
    @public
     */

    InputBase.prototype.generate = function(builder) {
      return build_template.apply(this, [builder]);
    };

    return InputBase;

  })();

  FormtasticInput.Base = InputBase;


  /**
  @class Inputs
  @module Formtastic
  @param object {Mixed} Options
  @param fn {Function} Callback (includes html and inputs being built)
  @param prefix {String} Prefix / Name of Fieldset
  @param nested {Boolean} If the fieldset is nested within another fieldset
  @constructor
   */

  FormFieldset = (function() {
    var set_callback, set_options;

    set_options = function(options) {
      if (_.isFunction(options)) {
        return this.options = {};
      } else if (_.isObject(options)) {
        options.name || (options.name = options.title);
        delete options.title;
        return this.options = options;
      } else if (_.isString(options)) {
        return this.options = {
          name: options
        };
      } else {
        return this.options = {};
      }
    };

    set_callback = function(fn) {
      return this.cb = _.isFunction(fn) ? fn : null;
    };

    function FormFieldset(options, fn, prefix, nested) {
      this.namespace = bind(this.namespace, this);
      this.inputs = bind(this.inputs, this);
      this.input = bind(this.input, this);
      this.container = bind(this.container, this);
      this.legend = bind(this.legend, this);
      this.fieldset = bind(this.fieldset, this);
      this.render = bind(this.render, this);
      this.createNode = bind(this.createNode, this);
      set_options.apply(this, [options]);
      set_callback.apply(this, [fn]);
      this.prefix = prefix;
      this.nested = nested;
    }


    /**
    See `Formtastic.createNode`
    @method createNode
    @public
     */

    FormFieldset.prototype.createNode = function() {
      return Formtastic.createNode.apply(this, arguments);
    };


    /**
    Call render to show your form item
    @method render
    @return outerHTML of wrapped form-group
    @public
     */

    FormFieldset.prototype.render = function() {
      var container, fieldset, legend, li;
      fieldset = this.fieldset();
      container = this.container();
      legend = this.legend();
      if (this.cb) {
        container.innerHTML = this.cb.apply(window, [this]);
        fieldset.innerHTML = legend + container.outerHTML;
      }
      if (this.nested) {
        li = this.createNode({
          tag: Formtastic.default_wrapper_tag
        }, true);
        li.innerHTML = fieldset.outerHTML;
        return li.outerHTML;
      } else {
        return fieldset.outerHTML;
      }
    };


    /**
    @method fieldset
    @return {DOMNode} DOM Node for the Fieldset
    @public
     */

    FormFieldset.prototype.fieldset = function() {
      var cfg, defaults;
      defaults = {
        tag: 'fieldset',
        "class": 'inputs'
      };
      cfg = _.extend(defaults, this.options);
      return this.createNode(cfg, true);
    };


    /**
    @method legend
    @return {String} Legend's Outer HTML
    @public
     */

    FormFieldset.prototype.legend = function() {
      var legend;
      if (!this.options.name) {
        return '';
      }
      legend = this.createNode({
        tag: 'legend'
      }, true);
      legend.innerHTML = this.options.name;
      return legend.outerHTML;
    };


    /**
    @method container
    @return {DOMNode} Container DOM Node that holds all inputs
    @public
     */

    FormFieldset.prototype.container = function() {
      return this.createNode({
        tag: Formtastic.default_fieldset_inner_tag
      }, true);
    };


    /**
    @method input
    @param field {String} Name of the input
    @param attributes {Object} Key/value pair of configs for inputs
    @return {String} HTML String of built form input and label
    @public
     */

    FormFieldset.prototype.input = function(field, attributes, prefix) {
      return Formtastic.prototype.input.apply(this, [field, attributes, this.namespace() || prefix]);
    };


    /**
    @method inputs
    @param [options={}] {Object} Object hash
    @param fn {Function} Inner Input Fields
    @return {String} HTML String built
     */

    FormFieldset.prototype.inputs = function() {
      var fn, options;
      options = _.first(arguments);
      fn = _.last(arguments);
      return new FormtasticInputs(options, fn, this.namespace(), true).render();
    };


    /**
    @method namespace
    @return {String} Namespace for fieldset and inputs within
     */

    FormFieldset.prototype.namespace = function() {
      if (this.options['for']) {
        return _.template('<%= prefix %>[<%= name %>]')({
          prefix: this.prefix,
          name: this.options['for']
        });
      } else {
        return _.template('<%= name %>')({
          prefix: this.prefix
        });
      }
    };

    return FormFieldset;

  })();

  extend(FormtasticInputs, FormFieldset);

  FormtasticInputs = FormFieldset;


  /**
  @class BooleanFieldHelper
  @module FormtasticInput
  @param field {String} Name of the field
  @param attributes {Object} Field Attributes
   */

  BooleanFieldHelper = (function(superClass) {
    extend1(BooleanFieldHelper, superClass);

    function BooleanFieldHelper() {
      this.input = bind(this.input, this);
      this._label_node = bind(this._label_node, this);
      return BooleanFieldHelper.__super__.constructor.apply(this, arguments);
    }

    BooleanFieldHelper.prototype._label_node = function() {
      return null;
    };

    BooleanFieldHelper.prototype.input = function() {
      var _checked_value, _hidden_field, _unchecked_value, checkbox, container, defaults, input_config;
      _checked_value = (function(_this) {
        return function() {
          try {
            return _this.attrs.checked_value || _this.attrs.value || _this.attrs.input_html.value;
          } catch (_error) {
            return 1;
          }
        };
      })(this);
      _unchecked_value = (function(_this) {
        return function() {
          return _this.attrs.unchecked_value || '0';
        };
      })(this);
      _hidden_field = (function(_this) {
        return function(defaults) {
          var hidden_config, input_cfg;
          input_cfg = _.clone(_this.attrs.input_html);
          if (input_cfg) {
            delete input_cfg.checked;
          }
          delete defaults.required;
          hidden_config = _.extend(defaults, {
            type: 'hidden',
            id: null,
            value: _unchecked_value()
          });
          hidden_config = _.extend(hidden_config, input_cfg);
          return _this.createNode(hidden_config);
        };
      })(this);
      defaults = {
        tag: 'input',
        type: 'checkbox',
        name: this.input_name(),
        required: this.required,
        id: this.generated_id(),
        value: _checked_value()
      };
      if (!this.required) {
        delete defaults.required;
      }
      input_config = _.extend(_.clone(defaults), this.attrs.input_html);
      checkbox = this.createNode(input_config);
      container = FormtasticInput.Base.prototype._label_node.apply(this, [true]);
      container.innerHTML = checkbox + ' ' + this.label_name();
      container.className = '';
      return _hidden_field(_.clone(defaults)) + container.outerHTML;
    };

    return BooleanFieldHelper;

  })(FormtasticInput.Base);

  FormtasticInput.BooleanFieldHelper = BooleanFieldHelper;


  /**
  @class HiddenFieldHelper
  @module FormtasticInput
  @param field {String} Name of the field
  @param attributes {Object} Field Attributes
   */

  HiddenFieldHelper = (function(superClass) {
    extend1(HiddenFieldHelper, superClass);

    function HiddenFieldHelper() {
      this.wrapper = bind(this.wrapper, this);
      this._label_node = bind(this._label_node, this);
      return HiddenFieldHelper.__super__.constructor.apply(this, arguments);
    }

    HiddenFieldHelper.prototype._label_node = function() {
      return null;
    };

    HiddenFieldHelper.prototype.wrapper = function() {
      var node;
      node = HiddenFieldHelper.__super__.wrapper.apply(this, arguments);
      node.style = "display: none;";
      return node;
    };

    return HiddenFieldHelper;

  })(FormtasticInput.Base);

  FormtasticInput.HiddenFieldHelper = HiddenFieldHelper;


  /**
  @class SelectFieldHelper
  @module FormtasticInput
  @param field {String} Name of the field
  @param attributes {Object} Field Attributes
  @param prefix {String} Form input name's prefix ex: `blog[title]` where prefix='blog'
   */

  SelectFieldHelper = (function(superClass) {
    extend1(SelectFieldHelper, superClass);

    function SelectFieldHelper(field, attributes, prefix) {
      this.input = bind(this.input, this);
      if (typeof attributes.collection === 'undefined') {
        throw new Error("Missing :collection for select box.");
      }
      SelectFieldHelper.__super__.constructor.call(this, field, attributes, prefix);
    }

    SelectFieldHelper.prototype.input = function() {
      var collection, defaults, ele, input_config, item, j, len, option;
      collection = this.attrs.collection;
      defaults = {
        tag: 'select',
        name: this.input_name(),
        multiple: this.attrs.multiple,
        required: this.required,
        "class": this.constructor.default_input_class
      };
      input_config = _.extend(defaults, this.attrs.input_html);
      ele = this.createNode(input_config, true);
      option = (function(_this) {
        return function(item) {
          var n;
          n = _this.createNode({
            tag: 'option'
          }, true);
          n.innerHTML = item.text;
          if (_.isArray(item)) {
            n.value = item[1];
            n.innerHTML = item[0];
          } else if (_.isObject(item)) {
            n.value = item.value;
            n.innerHTML = item.text;
          } else {
            n.value = item;
            n.innerHTML = item;
          }
          return n.outerHTML;
        };
      })(this);
      for (j = 0, len = collection.length; j < len; j++) {
        item = collection[j];
        ele.innerHTML = ele.innerHTML + option(item);
      }
      return ele.outerHTML;
    };

    return SelectFieldHelper;

  })(FormtasticInput.Base);

  FormtasticInput.SelectFieldHelper = SelectFieldHelper;


  /**
  @class StringFieldHelper
  @module FormtasticInput
  @param field {String} Name of the field
  @param attributes {Object} Field Attributes
   */

  StringFieldHelper = (function(superClass) {
    extend1(StringFieldHelper, superClass);

    function StringFieldHelper(field, attributes, prefix) {
      StringFieldHelper.__super__.constructor.call(this, field, attributes, prefix);
    }

    return StringFieldHelper;

  })(FormtasticInput.Base);

  FormtasticInput.StringFieldHelper = StringFieldHelper;


  /**
  @class TextFieldHelper
  @module FormtasticInput
  @param field {String} Name of the field
  @param attributes {Object} Field Attributes
  @param prefix {String} Form input name's prefix ex: `blog[title]` where prefix='blog'
   */

  TextFieldHelper = (function(superClass) {
    extend1(TextFieldHelper, superClass);

    function TextFieldHelper(field, attributes, prefix) {
      this.input = bind(this.input, this);
      TextFieldHelper.__super__.constructor.call(this, field, attributes, prefix);
    }

    TextFieldHelper.prototype.input = function() {
      var defaults, ele, input_config, value;
      defaults = {
        placeholder: this.label_name(),
        tag: 'textarea',
        type: (this.as === 'string' ? 'text' : this.as),
        name: this.input_name(),
        required: this.required,
        "class": this.constructor.default_input_class,
        id: this.generated_id()
      };
      if (!this.required) {
        delete defaults.required;
      }
      input_config = _.extend(defaults, this.attrs.input_html);
      value = input_config['value'];
      delete input_config['value'];
      delete input_config.type;
      delete input_config['as'];
      ele = this.createNode(input_config, true);
      ele.innerHTML = value;
      return ele.outerHTML;
    };

    return TextFieldHelper;

  })(FormtasticInput.Base);

  FormtasticInput.TextFieldHelper = TextFieldHelper;

}).call(this);
