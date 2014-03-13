namespace :db do
  desc "Fill database with sample ascent data"
  task populate: :environment do
    25.times do |i|
      user_id   = "1"
      climb_id  = "#{i+1}"
      date      = "#{Date.new(2014,1,(i+1))}"
      Ascent.create!(
        user_id: user_id,
        climb_id: climb_id,
        date: date
      )
    end
  end
end