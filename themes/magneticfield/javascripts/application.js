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

var observe_listings = function() {
  if ($('events')) {
    $$('#events .event .title').each(function(elem) {
        elem.observe('click', function(e) {
          var element = Event.element(e);
          // $(element).next('.more').toggle();
          Effect.toggle($(element).next('.more'), 'blind', { delay: 0.5 });
          });
        });
  }
}

var observe_filters = function() {
  $$('#filters .filter').each(function(elem) {
    elem.observe('click', function(e) {
      alert('wtf')
      alert($(e).classNames());
      $(e).toggleClassName('active');
    });
  });
}

document.observe('dom:loaded', observe_listings);
document.observe('dom:loaded', observe_filters);
