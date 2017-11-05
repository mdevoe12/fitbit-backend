require 'rails_helper'


RSpec.feature "user logs in" do
  scenario "using fitbit oauth" do
    visit root_path

    expect(page).to have_content("Fitbit Sign In")

    # click_link "Fitbit Sign In"

    # expect(page).to have_content("fitbit")


  end


end
