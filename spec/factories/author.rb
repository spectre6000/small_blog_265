FactoryGirl.define do
  sequence :email do |n|
    "author#{n}@example.com"
  end
end

FactoryGirl.define do
  sequence :username do |n|
    "author#{n}"
  end
end

FactoryGirl.define do
  factory :author, :class => 'Author' do
    email
    username
    confirmed_at = Time.now
    password 'password'
    password_confirmation 'password'
  end
end

FactoryGirl.define do
  factory :admin_author, :class => 'Author' do
    email
    username
    admin true
    confirmed_at = Time.now
    password 'password'
    password_confirmation 'password'
  end
end