require 'capybara/rspec'
require './do_something_app'

Capybara.app = Sinatra::Application

feature "the create activity page" do

  before(:each) do
    visit "/"
    fill_in("First Name", :with => "Steven")
    fill_in("Email", :with => "steven@example.com")
    fill_in("Password", :with => "password")
    click_button("Sign Up")
    click_link("Create an activity")
  end

  scenario "expect error if all fields not filled in" do
    click_button("Add Activity")
    expect(page).to have_content("Oops!")
  end

  scenario "says Remember an Activity" do
    expect(page).to have_content("Remember an Activity")
  end

  scenario "expect error if activity title not filled in" do
    visit('/create_activity')
    fill_in("city", with: "go bowling")
    choose('low_cost')
    select("Extreme", from: "category")
    fill_in("comment", with: "go bowling")
    select("4", from: "rating")
    click_button("Add Activity")
    expect(page).to have_content("Title can't be blank!")
  end

  after(:each) do
    users = User.all
    users.each {|user| user.destroy}
  end

end
