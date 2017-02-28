FactoryGirl.define do
  factory :url do
    original_url Faker::Internet.url
    short_url 'http://localhost/qx2fas'
    unique_hash 'qx2fas'
  end
end
