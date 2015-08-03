## Under Development

While there is a large test suite at the moment, there are [missing inputs still](#the-available-inputs).

## [Formtastic](https://github.com/justinfrench/formtastic) JS Port

Formtastic JS is a JS FormBuilder DSL that aims to duplicate the API given by the [Rails Gem Formtastic](https://github.com/justinfrench/formtastic). The goal of this project is to simply duplicate assumptions from the Rails Gem into the JavaScript project. Please see examples and tests for better coverage details.

### Installation

    bower install formtastic-js

### Production Dependency

- [underscore.js](http://underscorejs.org/)
  - TODO: Remove dependency if possible.
    Using `_.template`, `_.extend`, `_.clone`, `_.is***`, `_.first`, `_.last`, `_.compact`

### Usage

_Examples in [/example/](./tree/master/example) contain a normal Formtastic version along with a Bootstrap 3 version._

**JavaScript**
```javascript
(function(root) {
  var model = {};
  var form = new Formtastic(model, {as: 'blog', url: '/some/path'}, function(f) {
    var c = [];
    c.push(
      f.inputs({name: 'Basic'}, function(b) {
        var bf = [];
        bf.push(b.input('title'));
        bf.push(b.input('body', {as: 'text'}));
        bf.push(b.input('section'));

        // bf.push(b.input('publication_state', {as: 'radio'}));
        bf.push(b.input('category'));
        bf.push(b.input('colors', {as: 'select', collection: [{value: '1', text: 'Blue'}, {value: '2', text: 'Green'}, {value: '3', text: 'Red'}]}));
        bf.push(b.input('more_colors', {as: 'select', collection: [['Blue', 1], ['Green', 2], ['Red', 3]]}));
        bf.push(b.input('allow_comments', {as: 'checkbox', label: "Allow commenting on this article"}));
        bf.push(b.input('body', {as: 'text'}));

        bf.push(b.inputs('Private', {for: 'pm'}, function(b2) {
          var b = [];
          b.push(b2.input('private_category'));
          b.push(b2.input('private_colors', {as: 'select', collection: [{value: '1', text: 'Blue'}, {value: '2', text: 'Green'}, {value: '3', text: 'Red'}]}));
          return b.join("\n");
        }));
        return bf.join("\n");
      })
    );

    c.push(
      f.inputs("Advanced", function(b) {
        var bf = [];
        bf.push(b.input('keywords', {required: false, hint: "Example: ruby, rails, forms"}));
        bf.push(b.input('password', {required: false, input_html: {value: 'hello'}}));
        bf.push(b.input('password_confirmation', {required: false, input_html: {value: 'hello'}}));
        bf.push(b.input('url_title', {required: false}));
        return bf.join("\n");
      })
    );

    c.push(
      f.inputs({name: "Author", for: 'author'}, function(b) {
        var bf = [];
        bf.push(b.input('hidden', {as: 'hidden'}));
        bf.push(b.input('search'));
        return bf.join("\n");
      })
    );

    c.push(
      f.actions(function(b) {
        var bf = [];
        bf.push(b.action('submit', {as: 'button'}));
        bf.push(b.action('cancel', {as: 'link'}));
        return bf.join("\n");
      })
    );

    return c.join("\n");
  });
  html = form.render();
  root.document.getElementById('form').innerHTML = html;
})(this);
```

**HAML Coffee**
```haml
window.semantic_form_for = (object, form_attributes, fn)->
  f = new Formtastic(object, form_attributes, fn)
  return f.render()

=semantic_form_for this, {action: '#', class: 'form form-horizontal'}, (f)->
  =f.inputs "Some field set", (f2)->
    =f2.input('name', {required: true, label: "Name"})
    =f2.input('slug', {required: true, label: "Slug", hint: "Please parameterize your string, or we'll do it for you"})
    =f2.input('featured', {as: 'boolean', label: "Featured?"})

```

### The Available Inputs

* UNTESTED: `{as: 'select'}` - a select menu. _requires collection to be passed_
* TODO: `{as: 'check_boxes'}` - a set of check_box inputs. Alternative to _select_
* TODO: `{as: 'radio'}`- a set of radio inputs. Alternative to _select_
* TODO: `{as: 'time_zone'}` - a select input. Default for column types: name matching _"time_zone"_.
- `{as: 'password'}`- a password input. Default for column types: _string_ with name matching _"password"_.
- `{as: 'text'}` - a textarea.
* TODO: `{as: 'date_select'}` - a date select.
* TODO: `{as: 'datetime_select'}` - a date and time select.
* TODO: `{as: 'time_select'}` - a time select. Default for column types: @:time@.
- `{as: 'boolean|checkbox|bool|check_box'}` - a checkbox.
- `{as: 'string'}` - a text field. Default type for all inputs.
- `{as: 'number'}` - a text field (just like string).
- `{as: 'file'}` - a file field.
* TODO: `{as: 'country'}` - a select menu of country names. Default for column types: name _"country"_
- `{as: 'email'}` - a text field (just like string). Default for columns with name matching _"email"_. New in HTML5. Works on some mobile browsers already.
- `{as: 'url'}` - a text field (just like string). Default for columns with name matching _"url"_. New in HTML5. Works on some mobile browsers already.
- `{as: 'phone'}` - a text field (just like string). Default for columns with name matching _"phone"_ or _"fax"_. New in HTML5.
- `{as: 'search'}` - a text field (just like string). Default for columns with name matching _"search"_. New in HTML5. Works on Safari.
- `{as: 'hidden'}` - a hidden field. Creates a hidden field (added for compatibility).
* TODO: `{as: 'range'}` - a slider field.
* TODO: `{as: 'datalist'}` - a text field with a accompanying "datalist tag":https://developer.mozilla.org/en/docs/Web/HTML/Element/datalist which provides options for autocompletion

### Form Helpers

Those really helpful form_for helpers are also available along side the `input` method.

**`//` indicates it has been implemented**

```
=semantic_form_for({}, {as: 'dummy'}, function(f) {
  var c = [
    f.check_box :field, //
    f.color_field :field,
    f.date_field :field,
    f.datetime_field :field,
    f.datetime_local_field :field,
    f.email_field :field, //
    f.fields_for :field,
    f.file_field :field, //
    f.form_for :field,
    f.hidden_field :field, //
    f.label :field, //
    f.month_field :field,
    f.number_field :field, //
    f.password_field :field, //
    f.phone_field :field, //
    f.radio_button :field,
    f.range_field :field,
    f.search_field :field, //
    f.telephone_field :field, //
    f.text_area :field, //
    f.text_field :field, //
    f.time_field :field,
    f.url_field :field, //
    f.week_field :field,
    f.submit(), //
    f.cancel(), //
    f.reset(), //
    f.action('submit', label: 'Create Dummy') //
    f.action('cancel', label: 'Create Dummy') //
    f.action('reset', label: 'Create Dummy') //
  ];
  return c.join("\n");
});

```

### Templating

By default follows the original Formtastic Rails Gem. However, alot of people use the forked version, [formtastic-bootstrap3](https://github.com/nickl-/formtastic-bootstrap3). This JS Port uses Underscore's Templating system `_.template()` to allow custom templates.

#### Default

```javascript
Formtastic.template = '<%= label %><%= input %><%= hint %>';
Formtastic.default_form_class = 'formtastic';
Formtastic.default_wrapper_tag = 'li';
Formtastic.default_wrapper_class = '';
Formtastic.default_label_class = 'label';
Formtastic.default_input_class = '';
Formtastic.default_fieldset_inner_tag = 'ol';
Formtastic.required_string = '*';
Formtastic.default_hint_class = 'inline-hints';
Formtastic.default_hint_tag = 'p';
```


#### Bootstrap 3

```javascript
Formtastic.template = '<%= label %>' +
                      '<div class="col-xs-10<% if (!label) { %> col-xs-offset-2<% } %>">' +
                        '<%= input %>' +
                        '<%= hint %>' +
                      '</div>';
Formtastic.default_form_class = 'form-horizontal';
Formtastic.default_wrapper_tag = 'div';
Formtastic.default_wrapper_class = 'form-group';
Formtastic.default_label_class = 'col-xs-2 control-label';
Formtastic.default_input_class = 'form-control';
Formtastic.default_fieldset_inner_tag = 'div';
Formtastic.required_string = ' <strong data-toggle="tooltip" data-title="Required" class="required text-danger">*</strong>';
Formtastic.default_hint_class = 'help-block';
Formtastic.default_hint_tag = 'p';
```

[Bootstrap 3 Skinned]: https://www.evernote.com/l/AMuKcEIln9FAUIcneOi7iyBgE5f1NT2gCxQ


### Formtastic Differences (JS vs Rails Gem)

-
  Inputs that pass `for` options will only do singular
  ```
  f.inputs({for: 'author'}, function(f) {f.input('login')}) === f.inputs({for: 'authors'}, function(e) {f.input('login')})
  //= <fieldset for="author" class="inputs"><ol><li class="string optional"><input name="blog[author][login]" type="text"></li></ol></fieldset>
  ```
-
  Inputs that just render themselves are empty fieldsets. The Rails version does DB Column look up
  ```
  f.inputs() //=> <fieldset class="inputs"></fieldset>
  ```
-
  Numbers Input Field
  ```
  # Ruby
  builder.input(:title, :as => :number, :input_html => { :in => 5..102 })
  # JS
  builder.input('title', as: 'number', input_html: { min: 5, max: 102 })
  ```
-
  Namespace concept does not exist
  ```
  # Ruby
  f.inputs(namespace: 'world') do |f2|
    f2.input(:title)
  end
  # JS n/a
  ```
-
  **JavaScript does not currently set the value automatically**
-
  There is a notation to remove f.action from Formtastic. Not going into too much depth for this so skipping the wrapper part. The buttons will still display perfectly.
  **does not exist in JavaScript**
  ```
  f.action(:submit, :wrapper_html => {:class => [ :my_class, :another_class ]})
  ```

### Development

    npm install
    bower install

Run test suite (uses FireFox browser):

    ./node_modules/karma/bin/karma start

### Contrib

Want to contribute to this project?

- Create feature branch prefixed by feature name
- Write Specs for Feature
- Update CHANGELOG.md to reflect fixes, additions, etc.
- Commit changes to branch and push to remote
- Submit Pull Request