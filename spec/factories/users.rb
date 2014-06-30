# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "hoge@hoge.com"
    password "hogehoge"
    confirmed_at Time.now
  end
end
