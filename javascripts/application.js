Effect.SlideTab = function(element, xoffset) {
  new Effect.Move(element, {
    x: xoffset, y: 0, mode: 'relative',
    transition: Effect.Transitions.subtle_spring
  });
};


var animate_tab = function() {
  if ($('follow').offsetLeft == 0) {
    Effect.SlideTab('follow', -70);
  } else {
    Effect.SlideTab('follow', 70);
  }
};
