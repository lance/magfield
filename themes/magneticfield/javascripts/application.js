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

var observe_hover = function() {
  if ($('event_picker')) {
    $$('#event_picker .event_icon .logo img').each(function(elem) {
      elem.observe('mouseover', function(e) {
        Event.element(e).up().previous().show();
      });
      elem.observe('mouseout', function(e) {
        Event.element(e).up().previous().hide();
      });
      elem.observe('click', function(e) {
        // alert(Event.element(e).identify());
        info = $(Event.element(e).identify().gsub('logo','info'));
        current = $$("#events .showing").first();

        current.removeClassName('showing');
        info.addClassName('showing');

        current.setStyle('z-index:0');
        info.setStyle('z-index:1');

        current.hide();
        info.show();
      });
    });
  }
}

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

document.observe('dom:loaded', observe_hover);
document.observe('dom:loaded', observe_listings);
