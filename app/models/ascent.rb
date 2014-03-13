class Ascent < ActiveRecord::Base
  belongs_to :user
  belongs_to :climb
  
  default_scope -> { order('created_at DESC') }
  
  validates :user_id,   presence: true
  validates :climb_id,  presence: true
  validates :date,      presence: true
end
