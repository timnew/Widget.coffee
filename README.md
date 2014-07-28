widget.coffee [![Bower version][bower-image]][homepage]
================

> `widget.coffee` is a light-weight framework to help developer write front-end javascript in a more easier way.


Install
-------

Install using [bower][bower-url]:

    $ bower install widget.coffee --save

Quick Start
------------

### Html:

```html
<html>
  <head>    
    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript" src="widget.js"></script>
    <script type="text/javascript" src="sample_widgets.js"></script>
  </head>
  <body>
    <div data-widget="Page">
      <button data-action-handler='resetAll'>Reset All</button>
      <hr>
      <div data-widget="Timer" data-widget-part='timer'>
        <div class="time">no record!</div>
        <button class="toggle-button">start</button>
        <button class="lap-button">lap</button>
        <button class="reset-button">reset</button>
      </div>
      <hr>
      <div data-widget="ScoreBoard">
        <div>History</div>
        <ol data-widget-part="scoreList"></ol>
        <button data-action-handler="clean">Clean</button>
      </div>  
    </div>
  </body>
</html>

```

### Coffeescript:


```coffeescript
# sample_widget.coffee

class @Timer extends Widget
  bindDom: ->
    @timeSpan = @element.find('.time')
    @toggleButton = @element.find('.toggle-button')
    @lapButton = @element.find('.lap-button')
    @resetButton = @element.find('.reset-button')
    @scoreBoard = Widget.findWidgetByType('ScoreBoard')

  enhancePage: ->        
    @toggleButton.click @toggle
    @lapButton.click @lap
    @resetButton.click @reset
        
  initialize: ->
    @running = false
    @refreshButtonStatus()
    @reset()

  tick: =>
    @time++
    @refreshTime()
   
  refreshTime: ->
    @timeSpan.text("#{@time} ms")
    
  toggle: =>       
    @controlTimer !@running

  controlTimer: (running) ->
    @running = running

    @refreshButtonStatus()
   
    if @running
      @time = 0
      @refreshTime()
      @token = setInterval(@tick, 1)
    else
      if @token?
        clearInterval(@token) 
        delete @token

  refreshButtonStatus: ->
    if @running
      @toggleButton.text('Stop')        
      @lapButton.removeAttr('disabled')        
      @resetButton.attr('disabled', 'disabled')
    else
      @toggleButton.text('Start')  
      @lapButton.attr('disabled', 'disabled')
      @resetButton.removeAttr('disabled')  

  lap: =>
    @scoreBoard.addScore(@time)
    
  reset: =>
    delete @time 
    @timeSpan.text('no record!')
  
class @ScoreBoard extends Widget
  bindDom: ->
    @bindWidgetParts()

  enhancePage: ->
    @bindActionHandlers()

  addScore: (score) ->
    $('<li>').text("#{score} ms").appendTo(@scoreList)

  clean: ->
    @scoreList.html('')


class @Page extends Widget
  bindDom: ->
    @scoreBoard = @findSubWidgetByType('ScoreBoard')
    @bindWidgetParts()

  enhancePage: ->
    @bindActionHandlers()

  resetAll: ->
    @timer.controlTimer(false)
    @timer.reset()
    @scoreBoard.clean()
 
```

### Debugging

`widget.coffee` provides some convenient API for developer to debug the widget in runtime.
Open Javascript console(browser built-in or `FireBug`), type 

```javascript
  Widget.findWidgetByType('Timer').toggle()
```

Who uses widget.coffee
-----

`widget.coffee` is original developed for [Sustainable Fishery Partnership](http://www.sustainablefish.org/) Metrics 2.0 system. Later was refined as an independant javascript library uses by variant projects.

* [Metrics 2.0](https://metrics.sustainablefish.org)
* [LiveHall](http://live-hall.herokuapp.com/)
* myMobility (haven't went live yet)

## License
MIT



[homepage]: https://github.com/timnew/widget.coffee
[bower-image]: https://badge.fury.io/bo/widget.coffee.svg

[bower-url]: http://bower.io/

