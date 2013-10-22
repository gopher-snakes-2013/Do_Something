require 'capybara/rspec'
require './do_something_app'

Capybara.app = Sinatra::Application

feature "the homepage" do
  scenario "says Welcome to Do Something" do
    visit('/')
    expect(page).to have_content "Welcome to Do Something"
  end
end
