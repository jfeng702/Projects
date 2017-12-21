class Shortened_URL < ApplicationRecord
  validates :short_url, :long_url, presence: true, uniqueness: true

  def self.random_code # <<<ASK>>>
    random_string = SecureRandom::urlsafe_base64[0..15]
    until !Shortened_URL.exists?({'short_url'=>random_string})
      random_string = SecureRandom::urlsafe_base64[0..15]
    end

    random_string
  end

  def self.CreateShortened_URL(user, long_url)
    Shortened_URL.new({'short_url' => Shortened_URL.random_code,'long_url' => long_url, 'user_id' => user.id})
  end

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
end
