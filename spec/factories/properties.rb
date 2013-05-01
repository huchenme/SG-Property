# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :property do
    name "MyString"
    bedroom 1
    bathroom 1
    price 1
    size 1
    sitename "MyString"
    link "MyString"
    phone "MyString"
    agent_name "MyString"
    image_url "MyString"
  end
end
