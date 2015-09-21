module RandomIdHelper

  # Base 58 alphabet
  ALPHABET = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"
    .split("").freeze

  def self.random_id
    ALPHABET.sample(6).join("")
  end

  def random_username
    Faker::Internet.user_name(Faker::Name.name, %w(_ -))
  end
end