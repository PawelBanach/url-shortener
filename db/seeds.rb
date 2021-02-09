require 'faker'

Url.delete_all


10.times {
  Url.create( short_url: Faker::Internet.url(host: 'localhost:3000'), long_url: Faker::Internet.url)
}
