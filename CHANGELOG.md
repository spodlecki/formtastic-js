## 0.0.1

- Initial Launch
  - UNTESTED: `{as: 'select'}` - a select menu. _requires collection to be passed_
  - `{as: 'password'}`- a password input. Default for column types: _string_ with name matching _"password"_.
  - `{as: 'text'}` - a textarea.
  - `{as: 'boolean|checkbox|bool|check_box'}` - a checkbox.
  - `{as: 'string'}` - a text field. Default type for all inputs.
  - `{as: 'number'}` - a text field (just like string).
  - `{as: 'file'}` - a file field.
  - `{as: 'email'}` - a text field (just like string). Default for columns with name matching _"email"_. New in HTML5. Works on some mobile browsers already.
  - `{as: 'url'}` - a text field (just like string). Default for columns with name matching _"url"_. New in HTML5. Works on some mobile browsers already.
  - `{as: 'phone'}` - a text field (just like string). Default for columns with name matching _"phone"_ or _"fax"_. New in HTML5.
  - `{as: 'search'}` - a text field (just like string). Default for columns with name matching _"search"_. New in HTML5. Works on Safari.
  - `{as: 'hidden'}` - a hidden field. Creates a hidden field (added for compatibility).