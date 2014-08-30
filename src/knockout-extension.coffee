mutator =
  mutate: (instance, klass, args = []) ->
    throw 'Instance must be an object' if typeof instance isnt 'object'
    throw 'Klass must be a class' if typeof klass isnt 'function'

    instance.__proto__ = klass.prototype
    klass.apply(instance, args)
    instance

  fixForIE: (instance, klass, args = []) ->
    throw 'Instance must be an object' if typeof instance isnt 'object'
    throw 'Klass must be a class' if typeof klass isnt 'function'

    for k,v of klass.prototype when instance[k] is undefined
      instance[k] = v

    klass.apply(instance, args)
    instance

mutate = if ({}).__proto__ is undefined
            console.warn '__proto__ is not supported by current browser, fallback to hard-copy approach' if window.console?
            mutator.fixForIE
          else
            mutator.mutate

ko.bindingHandlers.widget =
  init: (element, valueAccessor, allBindings, viewModel, bindingContext) ->
    widgetKlass = valueAccessor()
    widgetName = widgetKlass.name
    $element = $(element)

    $element.attr('data-widget', widgetName)
    $element.data('widget', viewModel)

    mutate(viewModel, widgetKlass, $element)

    viewModel.bindDom()
    viewModel.enhancePage()
    viewModel.initialize()

Widget.prototype.applyBindings = (viewModel = this, context = @element[0]) ->
    ko.applyBindings(viewModel, context)
