describe '#email', ->
  describe 'generic', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.input('random_name', as: 'email'))
      @el = $('<div>'+@form.render()+'</div>')

    it 'has the form in @el', ->
      expect(@el.find('form').length).toEqual 1

    itBehavesLike('input_wrapper_with_class', 'email')
    itBehavesLike('input_wrapper_with_class', 'input')
    itBehavesLike('input_wrapper_with_id', 'blog_random_name_input')
    itBehavesLike('label_with_text', 'Random Name')
    itBehavesLike('input_with_', 'id', 'blog_random_name')
    itBehavesLike('input_with_', 'name', 'blog[random_name]')
    itBehavesLike('input_with_', 'type', 'email')

  describe 'auto-detection', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.input('email_address'))
      @el = $('<div>'+@form.render()+'</div>')

    it 'has the form in @el', ->
      expect(@el.find('form').length).toEqual 1

    itBehavesLike('input_wrapper_with_class', 'email')
    itBehavesLike('input_wrapper_with_class', 'input')
    itBehavesLike('input_wrapper_with_id', 'blog_email_address_input')
    itBehavesLike('label_with_text', 'Email Address')
    itBehavesLike('input_with_', 'id', 'blog_email_address')
    itBehavesLike('input_with_', 'name', 'blog[email_address]')
    itBehavesLike('input_with_', 'type', 'email')