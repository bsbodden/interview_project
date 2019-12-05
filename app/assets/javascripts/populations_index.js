document.addEventListener("DOMContentLoaded", function() {
  // load only page containing the specific class in the body
  if (document.querySelectorAll("body.page_populations_index").length > 0) {
    const yearInput = document.getElementById("year");
    const checkboxSpan = document.getElementById("growth_model_checkbox");

    yearInput.addEventListener("input", function(evt) {
      if (this.value.match(new RegExp("^\\d{4}$"))) {
        const year = parseInt(this.value, 10);
        if (!isNaN(year) && year > 1990) {
          checkboxSpan.classList.remove("hidden");
        } else {
          checkboxSpan.classList.add("hidden");
        }
      } else {
        checkboxSpan.classList.add("hidden");
      }
    });
  }
});
