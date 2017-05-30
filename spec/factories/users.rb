FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "gsamokovarov+test#{n}@gmail.com"
    end

    password 'test1234'
  end
end
