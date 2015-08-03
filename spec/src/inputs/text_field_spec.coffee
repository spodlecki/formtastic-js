describe '#text', ->
  describe 'generic', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.input('post', as: 'text', input_html: {value: 'hello'}))
      @el = $('<div>'+@form.render()+'</div>')

    it 'has the form in @el', ->
      expect(@el.find('form').length).toEqual 1

    itBehavesLike('input_wrapper_with_class', 'text')
    itBehavesLike('input_wrapper_with_class', 'input')
    itBehavesLike('input_wrapper_with_id', 'blog_post_input')
    itBehavesLike('label_with_text', 'Post')

    it 'builds a text area', ->
      expect(@el.find('form li textarea#blog_post').length).toEqual 1

    it 'builds a text area with default input class css', ->
      Formtastic.default_input_class = 'form-control'
      @form = new Formtastic(@object, @attrs, (f)-> f.input('post', as: 'text', input_html: {value: 'hello'}))
      @el = $('<div>'+@form.render()+'</div>')
      expect(@el.find('form li textarea.form-control').length).toEqual 1
      Formtastic.default_input_class = ''

    it 'builds a text area with name', ->
      expect(@el.find('form li textarea[name="blog[post]"]').length).toEqual 1

    it 'does not have a type attr', ->
      expect(@el.find('form li textarea').attr('type')).toBeUndefined()

    it 'builds a text area value', ->
      expect(@el.find('form li textarea').attr('value')).toBeUndefined()
      expect(@el.find('form li textarea').text()).toEqual 'hello'