(function(){
  // get the canvas, 2d context, paragraph for data and set the radius
  var canvas = document.getElementsByTagName('canvas')[0],
      ctx = canvas.getContext('2d'),
      radius = 10;
    
    

    

  // set the canvas to cover the screen
  canvas.width = document.body.clientWidth;
  canvas.height = document.body.clientHeight;

  // move the context co-ordinates to the bottom middle of the screen
  ctx.translate(canvas.width/2, canvas.height);

  ctx.fillStyle = "rgba(0,0,0,0.9)";
 // ctx.lineWidth = 4;

  function draw(frame) {
    // set up variables
     var pos, i, len;

    // cover the canvas in white
    ctx.fillStyle = "rgba(255,255,255,0)";
    ctx.fillRect(-canvas.width/2,-canvas.height,canvas.width,canvas.height);

    // set the fill to black for the points
    ctx.fillStyle = "rgba(142,68,173,1.0)";

    // loop over the frame's pointables
   for (i=0, len=frame.pointables.length; i<len; i++) {
      // get the pointable and its position
      pos = frame.pointables[0].tipPosition;


      // draw the circle where the pointable is
      ctx.beginPath();
      ctx.arc(pos.x-radius/2 ,-(pos.y-radius/2),radius,0,2*Math.PI);
      ctx.fill();
      ctx.stroke();
    }

  };

  // run the animation loop with the draw command
  Leap.loop(draw);
})();
