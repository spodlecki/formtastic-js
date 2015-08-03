describe '#password', ->
  describe 'generic', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.input('pass', as: 'password'))
      @el = $('<div>'+@form.render()+'</div>')

    it 'has the form in @el', ->
      expect(@el.find('form').length).toEqual 1

    itBehavesLike('input_wrapper_with_class', 'password')
    itBehavesLike('input_wrapper_with_class', 'input')
    itBehavesLike('input_wrapper_with_id', 'blog_pass_input')
    itBehavesLike('label_with_text', 'Pass')
    itBehavesLike('input_with_', 'id', 'blog_pass')
    itBehavesLike('input_with_', 'name', 'blog[pass]')
    itBehavesLike('input_with_', 'type', 'password')

  describe 'auto-detection', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}

    describe '"password"', ->
      beforeEach ->
        @form = new Formtastic(@object, @attrs, (f)-> f.input('password'))
        @el = $('<div>'+@form.render()+'</div>')

      it 'has the form in @el', ->
        expect(@el.find('form').length).toEqual 1

      itBehavesLike('input_wrapper_with_class', 'password')
      itBehavesLike('input_wrapper_with_class', 'input')
      itBehavesLike('input_wrapper_with_id', 'blog_password_input')
      itBehavesLike('label_with_text', 'Password')
      itBehavesLike('input_with_', 'id', 'blog_password')
      itBehavesLike('input_with_', 'name', 'blog[password]')
      itBehavesLike('input_with_', 'type', 'password')

    describe '"confirm_password"', ->
      beforeEach ->
        @form = new Formtastic(@object, @attrs, (f)-> f.input('confirm_password'))
        @el = $('<div>'+@form.render()+'</div>')

      it 'has the form in @el', ->
        expect(@el.find('form').length).toEqual 1

      itBehavesLike('input_wrapper_with_class', 'password')
      itBehavesLike('input_wrapper_with_class', 'input')
      itBehavesLike('input_wrapper_with_id', 'blog_confirm_password_input')
      itBehavesLike('label_with_text', 'Confirm Password')
      itBehavesLike('input_with_', 'id', 'blog_confirm_password')
      itBehavesLike('input_with_', 'name', 'blog[confirm_password]')
      itBehavesLike('input_with_', 'type', 'password')