FactoryBot.define do
  factory :cart do
    session_id { SecureRandom.hex(10) }
  end
end
