FactoryGirl.define do
  factory :post do
    title 'foo'
    description 'bar'

    trait :active do
      activated_at { Time.current }
    end

    user
  end
end

