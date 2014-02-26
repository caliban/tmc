# not working!
namespace :db do
  desc "Fill database with sample user data"
  task populate: :environment do
    User.create!(
      first_name: "First",
      last_name: "Last",
      email: "first.last@tmc.com",
      gender: "male",
      date_of_birth: "13/12/1991",
      password: "foobarfoobar",
      password_confirmation: "foobarfoobar"
    )
    25.times do |l|
      first_name    = Faker::Name.first_name
      last_name     = Faker::Name.last_name
      email         = "sample-#{(65+l).chr(Encoding::UTF_8)}@tmc.com"
      gender        = "male",
      date_of_birth = "13/12/1991",
      password      = "foobarfoobar",
      password_confirmation = "foobarfoobar"
      User.create!(
        first_name: first_name,
        last_name: last_name,
        email: email,
        gender: gender,
        date_of_birth: date_of_birth,
        password: password,
        password_confirmation: password)
    end
  end
end