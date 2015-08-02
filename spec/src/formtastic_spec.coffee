describe 'Formtastic', ->
  it 'has a global definition', ->
    expect(typeof window.Formtastic).toEqual 'function'

  it 'has a place for many builders', ->
    expect(Formtastic.builders).toEqual {}

  describe '#constructor', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'Blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, -> 'call back methods here')

    it 'sets up a form HTMLNode', ->
      expect(@form.el.tagName).toEqual 'FORM'

    it 'sets an #el', ->
      expect(@form.el.outerHTML).toEqual '<form class="formtastic" action="http://test.host"></form>'

    it 'sets the object', ->
      expect(@form.object).toEqual @object

  describe '#render', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'Blog', url: 'http://test.host'}

    it 'resets the inner html of #el', ->
      @form = new Formtastic(@object, @attrs, -> 'HERE!')
      @form.el.innerHTML = 'I should get replaced'
      expect(@form.el.innerHTML).toEqual 'I should get replaced'
      expect(@form.render()).toEqual '<form class="formtastic" action="http://test.host">HERE!</form>'

    it 'calls the #callback with context of window', ->
      @form = new Formtastic @object, @attrs, (f)->
        expect(this).toEqual window

      @form.render()

    it 'calls the #callback with Form builder as first parameter', ->
      @form = new Formtastic @object, @attrs, (f)=>
        expect(f).toEqual @form
      @form.render()

  describe '#label', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'Blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, -> 'HERE!')
      @form.constructor.required_string = '*'

    describe 'is null when', ->
      it 'no name given', ->
        expect(@form.label('')).toBeNull()

      it 'if undefined', ->
        expect(@form.label()).toBeNull()

    it 'returns a simple label with a name', ->
      expect(@form.label('Kustom')).toEqual '<label class="label">Kustom</label>'

    describe ':required', ->
      it 'returns a label with astrisk', ->
        expect(@form.label('Kustom', {required: true})).toEqual '<label class="label">Kustom*</label>'

      it 'returns a label with custom required text if set', ->
        @form.constructor.required_string = ' <strong data-toggle="tooltip" data-title="Required" class="required">*</strong>'
        expect(@form.label('Kustom', {required: true})).toEqual '<label class="label">Kustom <strong data-toggle="tooltip" data-title="Required" class="required">*</strong></label>'
    describe ':class', ->
      it 'overwrites the default css class', ->
        expect(@form.label('Kustom', {class: 'funkay chicken'})).toEqual '<label class="funkay chicken">Kustom</label>'

  ###
    See Specs for #input within input_spec.coffee
  ###

  describe '#inputs', ->
    xit 'needs specs'

  describe '#generate', ->
    xit 'needs specs'

  describe '#getConfig', ->
    xit 'builds configs for input builders'

  describe '#createNode', ->
    xit 'is a shortcut for private method #dom'