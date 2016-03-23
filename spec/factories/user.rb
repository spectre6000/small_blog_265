include ActionDispatch::TestProcess

FactoryGirl.define do
  sequence :username do |n|
    "user#{n}"
  end

  sequence :location do |n|
    "location#{n}"
  end

  factory :user, class: 'User' do
    username { generate(:username) }
    email { username + '@example.com' }
    location { generate(:location) }
    bio { username + ' was born in ' + location + '.' }
    password 'password'
    password_confirmation 'password'
    confirmed_at { Time.now }
    invitation_accepted_at { Time.zone.now }
    profile_image { File.new("#{Rails.root}/spec/factories/images/test_image1.png") }
    banner_image { File.new("#{Rails.root}/spec/factories/images/test_image1.png") }

    factory :admin do
      admin true
    end
  end
end
