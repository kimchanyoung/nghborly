FactoryGirl.define do
  factory :group do
    primary_number     { Faker::Number.number(3) }
    street_name        { Faker::Address.street_name }
    city_name          { Faker::Address.city }
    state_abbreviation { Faker::Address.state_abbr }
    zipcode            { Faker::Address.zip_code }
  end

  factory :user, aliases: [:requester, :responder] do
    user_id    { Faker::Number.number(15)}
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email      { Faker::Internet.email }
    association :group
  end

  factory :request do
    content { Faker::Lorem.paragraph }
    association :requester
    group_id requester.id

    trait :has_neighbor do
      association :responder
    end

    trait :is_fulfilled do
      is_fulfilled true
    end

    trait :created_one_day_ago do
      created_at { 1.day.ago }
    end

    factory :request_with_neighbor, traits: [:has_neighbor]
    factory :fulfilled_request , traits: [:has_neighbor, :is_fulfilled]
    factory :day_old_request, traits: [:created_one_day_ago]
  end
end
