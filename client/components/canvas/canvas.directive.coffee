angular.module 'syncDrawWebApp'
.directive 'drawing', ($http, $rootScope, socket) ->
  {
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
      # ngModel.$modelValue = ctx

      reset = ->
        element[0].width = element[0].width
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
        # ctx.closePath()
        return

      getDataUrl = (canvas) ->
        canvas.toDataUrl()

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

        $http.post('/api/images', info: dataUrl)
          # .success () ->
          #   $http.get('/api/images')
          #     .success (images) ->
          #       if images.length > 0
          #         $rootScope.images = images
          #         $rootScope.canvas = _.last $rootScope.images
          #       socket.syncUpdates 'image', $rootScope.images

        return

      return
  }
