require 'machinist/active_record'
require 'sham'

Sham.name                       { Faker::Name.name }
Sham.email                      { Faker::Internet.email }
Sham.subject                    { Faker::Lorem.sentence }
Sham.body                       { Faker::Lorem.paragraph(30) }
Sham.ip(:unique => false)       { "127.0.0.1" }
Sham.website                    { "http://" + Faker::Internet.domain_name + "/" + Faker::Lorem.words(rand(3)+1).join('/') }
Sham.password                   { Faker::Name.name }
Sham.subdomain                  { Faker::Name.name }

YellowHat.blueprint do
end

Sprint.blueprint do
end

BlackHat.blueprint do
end

GreenHat.blueprint do
end

User.blueprint do
  email
  password
  password_confirmation {password}
  confirmed_at(:unique => false) {Time.now}
end
