describe '#boolean_field', ->
  describe 'generic', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host', wrapper_html: {}, label_html: {}, input_html: {}}
      @form = new Formtastic(@object, @attrs, (f)-> f.input('allow_comments', as: 'boolean'))
      @el = $('<div>'+@form.render()+'</div>')

    it 'is here', ->
      expect(@el.find('form').length).toEqual 1

    it 'should have the input wrapper with class', ->
      wrapper_class(@el, 'boolean')

    it 'should have the input wrapper with class input', ->
      wrapper_class(@el, 'input')

    it 'should have the input wrapper id', ->
      wrapper_id(@el, 'blog_allow_comments_input')

    it 'should generate a label containing the input', ->
      expect(@el.find('label.label').length).toEqual 0
      expect(@el.find('form li label').length).toEqual 1
      expect(@el.find('form li label[for="blog_allow_comments"]').length).toEqual 1
      expect(@el.find('form li label > input[type="checkbox"]').length).toEqual 1
      expect(@el.find('form li > input[type="hidden"]').length).toEqual 1
      expect(@el.find('form li label > input[type="hidden"]').length).toEqual 0  # invalid HTML5

    it 'should not add a "name" attribute to the label', ->
      expect(@el.find('form li label').attr('name')).toBeUndefined()

    it 'should generate a checked input if :input_html is passed :checked => checked', ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.input('allow_comments', as: 'boolean', input_html: {checked: true}))
      @el = $('<div>'+@form.render()+'</div>')

      expect(@el.find('form li label input').attr('checked')).toEqual 'checked'
      expect(@el.find('form li > input').attr('checked')).toBeUndefined()

    it 'should name the hidden input with the :name html_option', ->
      expect(@el.find('form li label input').attr('name')).toEqual @el.find('form li > input').attr('name')

    it 'should name the hidden input with the :name html_option', ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.input('allow_comments', as: 'boolean', input_html: {name: 'bar'}))
      @el = $('<div>'+@form.render()+'</div>')

      expect(@el.find('form li label input').attr('name')).toEqual 'bar'
      expect(@el.find('form li > input').attr('name')).toEqual 'bar'

    it "should generate a disabled input and hidden input if :input_html is passed :disabled => 'disabled'", ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.input('allow_comments', as: 'boolean', input_html: {diabled: true}))
      @el = $('<div>'+@form.render()+'</div>')

      expect(@el.find('form li label input').attr('diabled')).toEqual 'true'
      expect(@el.find('form li > input').attr('diabled')).toEqual 'true'

    it 'should allow checked and unchecked values to be sent', ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.input('allow_comments', as: 'boolean', checked_value: 'check value', unchecked_value: 'unchecked value'))
      @el = $('<div>'+@form.render()+'</div>')

      expect(@el.find('form li label input').attr('value')).toEqual 'check value'
      expect(@el.find('form li > input').attr('value')).toEqual 'unchecked value'

    it 'should name the hidden input with the :name html_option', ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.input('allow_comments', as: 'boolean', required: true))
      @el = $('<div>'+@form.render()+'</div>')

      expect(@el.find('form li label input').attr('required')).toEqual 'required'
      expect(@el.find('form li > input').attr('required')).toBeUndefined()