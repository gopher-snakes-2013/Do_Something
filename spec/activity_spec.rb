require './do_something_app'
require 'shoulda-matchers'

describe Activity do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:cost) }
  it { should belong_to(:user) }
end
