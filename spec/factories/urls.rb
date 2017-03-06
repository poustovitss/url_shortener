FactoryGirl.define do
  factory :url do
    original_url Faker::Internet.url
    short_url 'http://localhost/qx2fas'
    unique_hash UniqueHashGeneratorService.new(:url).generate_unique_hash
  end
end
