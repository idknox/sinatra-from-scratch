require 'spec_helper'

feature "Email Page" do
  scenario "User can fill out Registration form" do
    visit "/"
    click_link("Register")

    fill_in("first_name", :with => "Ian")
    fill_in("last_name", :with => "Knox")
    fill_in("email", :with => "knoxid@gmail.com")
    fill_in("password", :with => "123")
    fill_in("birthdate", :with => "08/08/1984")

    click_button("Submit")

    expect(page).to have_content("Thank you for registering")

  end
end