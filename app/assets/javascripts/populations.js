// Copied from https://stackoverflow.com/questions/37358652/how-to-refresh-a-page-with-turbolinks
var reloadWithTurbolinks = (function() {
  var scrollPosition;

  function reload() {
    scrollPosition = [window.scrollX, window.scrollY];
    Turbolinks.visit(window.location.toString(), { action: "replace" });
  }

  document.addEventListener("turbolinks:load", function() {
    if (scrollPosition) {
      window.scrollTo.apply(window, scrollPosition);
      scrollPosition = null;
    }
  });

  return reload;
})();
