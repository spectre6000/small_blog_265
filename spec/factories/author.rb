FactoryGirl.define do
  
  sequence :id do | n |
    "#{ n }"
  end

  sequence :username do | n |
    "author#{ n }"
  end

  sequence :email do | n |
    "email#{ n }@example.com"
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
    location
    bio
    password 'password'
    password_confirmation 'password'
    confirmed_at { Time.now }
    invitation_accepted_at { Time.zone.now }

    factory :admin do
      admin true
    end
  end

end