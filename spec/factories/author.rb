include ActionDispatch::TestProcess

FactoryGirl.define do

  sequence :username do | n |
    "author#{ n }"
  end

  sequence :location do | n |
    "location#{ n }"
  end

  factory :author, :class => 'Author' do
    username { generate( :username ) }
    email { username + '@example.com' }
    location { generate( :location ) }
    bio { username + " was born in " + location + "."}
    password 'password'
    password_confirmation 'password'
    confirmed_at { Time.now }
    invitation_accepted_at { Time.zone.now }
    profile_image { fixture_file_upload( Rails.root.join( 'spec', 'factories', 'images', "test_image.png" ), 'image/png' ) }

    factory :admin do
      admin true
    end
  end

end