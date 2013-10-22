require 'capybara/rspec'
require './do_something_app'

Capybara.app = Sinatra::Application

feature "User can sign up" do

  # before :each do
  #   User.create(email: "steven@example.com", password: "password")
  # end

  scenario "enter their email" do
    visit "/"
    fill_in("First Name", :with => "Steven")
    fill_in("Email", :with => "steven@example.com")
    fill_in("Password", :with => "password")
    click_button("Sign Up")
    expect(page).to have_content("Welcome, Steven")
  end

  # after :each do
  #   users = User.all
  #   users.each {|user| user.destroy}
  # end
end
