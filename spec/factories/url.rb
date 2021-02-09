FactoryBot.define do
  factory :url do
    key { "aj9+LCqfeKw=" }
    source  { "https://example.com" }
    clicked { 2 }
  end
end
