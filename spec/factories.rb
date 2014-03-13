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
  
  factory :climb do
    name    "Dreamcatcher"
    grade   "35"
    rating  "5"
    # ascent
  end
  
  factory :ascent do
    # user_id   "1"
    # climb_id  "1"
    # date      "1/1/2001"
  end
end
