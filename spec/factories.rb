FactoryGirl.define do
  factory :user do
    first_name    "Fred"
    last_name     "Sharma"
    email         "fred@sharma.com"
    gender        "male"
    date_of_birth "20/12/1991"
    password      "foobarfoobar"
    password_confirmation "foobarfoobar"
  end
end
