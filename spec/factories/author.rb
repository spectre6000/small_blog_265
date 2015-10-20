FactoryGirl.define do
  
  sequence :username do | n |
    "author#{ n }"
  end

  sequence :email do | n |
    "author#{ n }@example.com"
  end

  sequence :admin do
    false
  end

  sequence :location do | n |
    "location#{ n }"
  end

  sequence :bio do | n |
    "Author#{ n } was born #{ n } years ago in location#{ n }."
  end

end

FactoryGirl.define do

  factory :author, :class => 'Author' do
    username
    email
    admin
    location
    bio
    password 'password'
    password_confirmation 'password'
    confirmed_at = Time.now

    trait :admin do
      admin true
    end
  end

end