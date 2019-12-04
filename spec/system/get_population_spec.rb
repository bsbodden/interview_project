require "rails_helper"

RSpec.describe "Get population by year", type: :system do
  it "User is presented with an input form" do
    visit populations_path
    assert_selector "input[name=year]"
    assert_selector "button[type=submit]"
  end

  describe "When user enters a valid year" do
    it "redirects to a results page"
    it "shows a population figure"
  end

  describe "When the user enters Javascript in the form" do
    it "prevents the JavaScript from executing" do
      visit populations_path
      fill_in "year", with: %["><script>alert("XSS")</script>&]
      click_button "Submit"
      expect { accept_alert }.to raise_exception(Capybara::ModalNotFound)
    end
  end

  describe "When the user enters Javascript in the query param" do
    it "prevents the JavaScript from executing" do
      visit populations_by_year_path(year: %["><script>alert("XSS")</script>&])
      expect { accept_alert }.to raise_exception(Capybara::ModalNotFound)
    end
  end
end
