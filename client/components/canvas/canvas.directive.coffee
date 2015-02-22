angular.module 'syncDrawWebApp'
.directive 'drawing', ($http, $rootScope, socket) ->
  return {
    restrict: 'A'
    # requre: 'ngModel'
    link: (scope, element, attrs) ->
      ctx = element[0].getContext('2d')
      # variable that decides if something should be drawn on mousemove
      drawing = false
      # the last coordinates before the current move
      lastX = undefined
      lastY = undefined
      # canvas reset

      reset = ->
        element[0].width = element[0].width
        console.log(ctx, element[0])
        return

      draw = (lX, lY, cX, cY) ->
        # line from
        ctx.moveTo lX, lY
        # to
        ctx.lineTo cX, cY
        # color
        ctx.strokeStyle = '#4bf'
        # draw it
        ctx.stroke()
        return

      element.bind 'mousedown', (event) ->
        if event.offsetX != undefined
          lastX = event.offsetX
          lastY = event.offsetY
        else
          lastX = event.layerX - event.currentTarget.offsetLeft
          lastY = event.layerY - event.currentTarget.offsetTop
        # begins new line
        ctx.beginPath()
        drawing = true
        return

      element.bind 'mousemove', (event) ->
        if drawing
          # get current mouse position
          if event.offsetX != undefined
            currentX = event.offsetX
            currentY = event.offsetY
          else
            currentX = event.layerX - event.currentTarget.offsetLeft
            currentY = event.layerY - event.currentTarget.offsetTop
          draw lastX, lastY, currentX, currentY
          # set current coordinates to last one
          lastX = currentX
          lastY = currentY
        return

      element.bind 'mouseup', (event) ->
        # stop drawing
        drawing = false
        dataUrl = ctx.canvas.toDataURL()
        _.debounce $http.post('/api/images', info: dataUrl), 100
        return

      return
  }
