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