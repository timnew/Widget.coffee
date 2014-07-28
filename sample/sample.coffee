class @Timer extends Widget
  bindDom: ->
    @timeSpan = @element.find('.time')
    @startButton = @element.find('.start-button')
    @lapButton = @element.find('.lap-button')
    @resetButton = @element.find('.reset-button')
    @scoreBoard = Widget.findWidgetByType('ScoreBoard')

  enhancePage: ->        
    @startButton.click @startStop
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
    
  startStop: =>       
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
      @startButton.text('Stop')        
      @lapButton.removeAttr('disabled')        
      @resetButton.attr('disabled', 'disabled')
    else
      @startButton.text('Start')  
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


