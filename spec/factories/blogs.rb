FactoryBot.define do
  factory :blog do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraphs(number: rand(1..3)).join("\n\n") }
  end
end
