require 'capybara/rspec'
require './do_something_app'

Capybara.app = Sinatra::Application

feature "the create activity page" do
  scenario "says Remember an Activity" do
    visit('/create_activity')
    expect(page).to have_content("Remember an Activity")
  end

  scenario "expect error if all fields not filled in" do
    visit('/create_activity')
    click_button("Add Activity")
    expect(page).to have_content("Oops!")
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

end
