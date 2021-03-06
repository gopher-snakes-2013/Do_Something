require 'capybara/rspec'
require './do_something_app'

Capybara.app = Sinatra::Application

feature "User can sign up" do


  scenario "enter their email" do
    visit "/"
    fill_in("First Name", :with => "Steven")
    fill_in("Email", :with => "steven@example.com")
    fill_in("Password", :with => "password")
    click_button("Sign Up")
    expect(page).to have_content("Welcome, Steven")
  end

  scenario "new user can logout" do
    visit "/logout"
    expect(page).to_not have_content("Welcome, Steven")
  end

  scenario "enter user account information" do
    visit "/"
    fill_in("User Email", with: "steven@example.com")
    fill_in("User Password", with: "password")
    click_button("Sign In")

    expect(page).to have_content("Welcome, Steven")
  end


  after :all do
    User.last.destroy
  end
end
