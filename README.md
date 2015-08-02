## [Formtastic](https://github.com/justinfrench/formtastic) JS Port

Formtastic JS is a JS FormBuilder DSL that aims to duplicate the API given by the [Rails Gem Formtastic](https://github.com/justinfrench/formtastic). The goal of this project is to simply duplicate assumptions from the Rails Gem into the JavaScript project. Please see examples and tests for better coverage details.

### Usage

```javascript
var model = new Backbone.Model({ .... });
var form = Formtastic.new(model, {as: 'blog', url: '/some/path'}, function(f) {
  var c = [];

  c.push(
    f.inputs({name: 'Basic'}, function(b) {
      var bf = [];
      bf.push(b.input('title'));
      bf.push(b.input('body', {as: 'text'}));
      bf.push(b.input('section'));
      bf.push(b.input('publication_state', {as: 'radio'}));
      bf.push(b.input('category'));
      bf.push(b.input('allow_comments', {as: 'checkbox', label: "Allow commenting on this article"}));
      bf.push(b.input('body'));
      return bf.join("\n");
    })
  );

  c.push(
    f.inputs("Advanced", function(b) {
      var bf = [];
      bf.push(b.input('keywords', {required: false, hint: "Example: ruby, rails, forms"}));
      bf.push(b.input('extract', {required: false}));
      bf.push(b.input('description', {required: false}));
      bf.push(b.input('url_title', {required: false}));
      return bf.join("\n");
    })
  );

  c.push(
    f.inputs({name: "Author", for: 'author'}, function(b) {
      var bf = [];
      bf.push(b.input('first_name'));
      bf.push(b.input('last_name'));
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
});

html = f.render();
```


### The Available Inputs

* `{as: 'select'}` - a select menu. _requires collection to be passed_
* TODO: `{as: 'check_boxes'}` - a set of check_box inputs. Alternative to _select_
* `{as: 'radio'}`- a set of radio inputs. Alternative to _select_
* TODO: `{as: 'time_zone'}` - a select input. Default for column types: name matching _"time_zone"_.
* `{as: 'password'}`- a password input. Default for column types: _string_ with name matching _"password"_.
* `{as: 'text'}` - a textarea.
* TODO: `{as: 'date_select'}` - a date select.
* TODO: `{as: 'datetime_select'}` - a date and time select.
* TODO: `{as: 'time_select'}` - a time select. Default for column types: @:time@.
- `{as: 'boolean|checkbox|bool|check_box'}` - a checkbox.
- `{as: 'string'}` - a text field. Default type for all inputs.
- `{as: 'number'}` - a text field (just like string).
* `{as: 'file'}` - a file field.
* TODO: `{as: 'country'}` - a select menu of country names. Default for column types: name _"country"_
* `{as: 'email'}` - a text field (just like string). Default for columns with name matching _"email"_. New in HTML5. Works on some mobile browsers already.
* TODO: `{as: 'url'}` - a text field (just like string). Default for columns with name matching _"url"_. New in HTML5. Works on some mobile browsers already.
* `{as: 'phone'}` - a text field (just like string). Default for columns with name matching _"phone"_ or _"fax"_. New in HTML5.
* TODO: `{as: 'search'}` - a text field (just like string). Default for columns with name matching @"search"@. New in HTML5. Works on Safari.
* `{as: 'hidden'}` - a hidden field. Creates a hidden field (added for compatibility).
* TODO: `{as: 'range'}` - a slider field.
* TODO: `{as: 'datalist'}` - a text field with a accompanying "datalist tag":https://developer.mozilla.org/en/docs/Web/HTML/Element/datalist which provides options for autocompletion

### Templating

This setup, by default follows the original Formtastic Rails Gem. However, alot of people have been using the forked version, [formtastic-bootstrap3](https://github.com/nickl-/formtastic-bootstrap3). In order to be as dynamic as possible,
the JS Port uses Underscore's Templating system `_.template()` to allow custom templates.

#### Bootstrap 3

```javascript
Formtastic.template = '<%= label %>' +
                      '<div class="col-xs-10<% if (!label) { %> col-xs-offset-2<% } %>">' +
                        '<%= input %>' +
                        '<%= hint %>' +
                      '</div>';
Formtastic.default_form_class = 'form-horizontal'
Formtastic.default_wrapper_tag = 'div'
Formtastic.default_wrapper_class = 'form-group'
Formtastic.default_label_class = 'col-xs-2 control-label'
Formtastic.required_string = ' <strong data-toggle="tooltip" data-title="Required" class="required text-danger">*</strong>'
```

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