namespace :db do
  desc "Fill database with sample climb data"
  task populate: :environment do
    25.times do
      name    = Faker::Name.first_name
      grade   = "#{rand(0..5)}"
      rating  = "#{rand(0.0..5.0)}"
      Climb.create!(
        name: name,
        grade: grade,
        rating: rating
      )
    end
  end
end