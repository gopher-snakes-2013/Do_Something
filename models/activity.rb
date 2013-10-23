class Activity < ActiveRecord::Base
  validates :category, :rating, :title, :city, :cost, presence: true
  belongs_to :user

end
