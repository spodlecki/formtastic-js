describe '#phone', ->
  describe 'generic', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.input('ph_one', as: 'phone'))
      @el = $('<div>'+@form.render()+'</div>')

    it 'has the form in @el', ->
      expect(@el.find('form').length).toEqual 1

    itBehavesLike('input_wrapper_with_class', 'phone')
    itBehavesLike('input_wrapper_with_class', 'input')
    itBehavesLike('input_wrapper_with_id', 'blog_ph_one_input')
    itBehavesLike('label_with_text', 'Ph One')
    itBehavesLike('input_with_', 'id', 'blog_ph_one')
    itBehavesLike('input_with_', 'name', 'blog[ph_one]')
    itBehavesLike('input_with_', 'type', 'phone')

  describe 'auto-detection', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}

    describe '"phone"', ->
      beforeEach ->
        @form = new Formtastic(@object, @attrs, (f)-> f.input('phone'))
        @el = $('<div>'+@form.render()+'</div>')

      it 'has the form in @el', ->
        expect(@el.find('form').length).toEqual 1

      itBehavesLike('input_wrapper_with_class', 'phone')
      itBehavesLike('input_wrapper_with_class', 'input')
      itBehavesLike('input_wrapper_with_id', 'blog_phone_input')
      itBehavesLike('label_with_text', 'Phone')
      itBehavesLike('input_with_', 'id', 'blog_phone')
      itBehavesLike('input_with_', 'name', 'blog[phone]')
      itBehavesLike('input_with_', 'type', 'phone')

    describe '"phone number"', ->
      beforeEach ->
        @form = new Formtastic(@object, @attrs, (f)-> f.input('phone_number'))
        @el = $('<div>'+@form.render()+'</div>')

      it 'has the form in @el', ->
        expect(@el.find('form').length).toEqual 1

      itBehavesLike('input_wrapper_with_class', 'phone')
      itBehavesLike('input_wrapper_with_class', 'input')
      itBehavesLike('input_wrapper_with_id', 'blog_phone_number_input')
      itBehavesLike('label_with_text', 'Phone Number')
      itBehavesLike('input_with_', 'id', 'blog_phone_number')
      itBehavesLike('input_with_', 'name', 'blog[phone_number]')
      itBehavesLike('input_with_', 'type', 'phone')

    describe '"fax"', ->
      beforeEach ->
        @form = new Formtastic(@object, @attrs, (f)-> f.input('fax'))
        @el = $('<div>'+@form.render()+'</div>')

      it 'has the form in @el', ->
        expect(@el.find('form').length).toEqual 1

      itBehavesLike('input_wrapper_with_class', 'phone')
      itBehavesLike('input_wrapper_with_class', 'input')
      itBehavesLike('input_wrapper_with_id', 'blog_fax_input')
      itBehavesLike('label_with_text', 'Fax')
      itBehavesLike('input_with_', 'id', 'blog_fax')
      itBehavesLike('input_with_', 'name', 'blog[fax]')
      itBehavesLike('input_with_', 'type', 'phone')

    describe '"fax number"', ->
      beforeEach ->
        @form = new Formtastic(@object, @attrs, (f)-> f.input('fax_number'))
        @el = $('<div>'+@form.render()+'</div>')

      it 'has the form in @el', ->
        expect(@el.find('form').length).toEqual 1

      itBehavesLike('input_wrapper_with_class', 'phone')
      itBehavesLike('input_wrapper_with_class', 'input')
      itBehavesLike('input_wrapper_with_id', 'blog_fax_number_input')
      itBehavesLike('label_with_text', 'Fax Number')
      itBehavesLike('input_with_', 'id', 'blog_fax_number')
      itBehavesLike('input_with_', 'name', 'blog[fax_number]')
      itBehavesLike('input_with_', 'type', 'phone')