class Activity < ActiveRecord::Base
  validates :category, :rating, presence: true

end
