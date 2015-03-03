angular.module 'syncDrawWebApp'
.directive 'drawing', ($http) ->
  link = (scope, element, attrs) ->
    ctx = element[0].getContext('2d')
    ctx.canvas.width = element.parent().width()
    ctx.canvas.height = screen.availHeight

    drawing = false
    lastX = undefined
    lastY = undefined

    reset = ->
      element[0].width = element[0].width
      return

    draw = (lastX, lastY, currentX, currentY) ->
      ctx.moveTo lastX, lastY
      ctx.lineTo currentX, currentY
      ctx.strokeStyle = '#4bf'
      ctx.stroke()
      return

    element.bind 'mousedown', (event) ->
      if event.offsetX != undefined
        lastX = event.offsetX
        lastY = event.offsetY
      else
        lastX = event.layerX - event.currentTarget.offsetLeft
        lastY = event.layerY - event.currentTarget.offsetTop
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
        lastX = currentX
        lastY = currentY
      return

    element.bind 'mouseup', (event) ->
      drawing = false
      dataUrl = ctx.canvas.toDataURL()
      $http.post '/api/images', info: dataUrl
      return

    return

  return {
    restrict: 'A'
    link: link
  }
