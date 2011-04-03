Raphael.el.randomColor = function() { return this.attr({fill: ["#F00", "#0F0", "black", "#00F", "black"][Math.floor(Math.random() * 5)]}); }


paper = null;
var fillWindow = function () {
  if(paper == null) {
    paper = Raphael('background', 200, 400);
  }
  paper.clear();
  for(var row=0; row * 20 < paper.height; row++) {
    for(var col=0; col * 20 < paper.width; col++) {
      paper.rect(col*20, row*20, 20,20).randomColor();
    }
  }
  setTimeout(fillWindow, 1500);
};
window.onload = fillWindow;

