class Climb < ActiveRecord::Base
  has_many :ascents
  has_many :users, through: :ascents
  
  validates :name,    presence: true, length: { maximum: 50 }
  validates :grade,   length: { maximum: 5 }
  validates :rating,  numericality: { greater_than_or_equal_to: 0.0, less_than_or_equal_to: 5.0 }
end
