widget.coffee [![Bower version][bower-image]][homepage]
================

> `widget.coffee` is a light-weight framework to help developer write front-end javascript in a more easier way.


## Install

Install using [bower][bower-url]:

    $ bower install widget.coffee --save

## Quick Start

Html

```html
	<script src='widget.js'>
	<script src='sample_widget.js'>
	<div data-widget="Dashboard">
		<span class="status"> No data yet! </span>
		<button>Update</button>
	</div>

```

Coffeescript:


```coffeescript
# sample_widget.coffee
class @SampleWidget extends Widget
  bindDom: ->
  	@statusSpan = @element.find('.status')
  	@updateButton = @element.find('button')
  	
  enhancePage: ->
  	@updateButton.click @update
  	  	
  initialize: ->
  	@update()
    
  update: =>
  	$.get '/api/status', @updateStatusSpan
  
  updateStatusSpan: (text) =>
  	@statusSpan.text(text)
      
```
 
## License
MIT



[homepage]: https://github.com/timnew/widget.coffee
[bower-image]: https://badge.fury.io/bo/widget.coffee.svg

[bower-url]: http://bower.io/

