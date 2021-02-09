class Url < ApplicationRecord
  # Key length in bytes
  KEY_LENGTH = 8
  KEY_GENERATION_RETRIES = 10

  validates :source, presence: true, format: URI::regexp(%w[http https])
  validates :key, uniqueness: true

  before_validation :generate_key

  def self.shorten(source:, custom_key: nil)
    if custom_key.present?
      url = Url.find_by(key: custom_key)
      if url.present?
        url.errors.add(:key, :uniqueness, message: "Key already taken!") if source != url.source
        return url
      end
    end

    return Url.create(source: source, key: custom_key)
  end

  def generate_key
    self.key = SecureRandom.base64(KEY_LENGTH) if self.key.blank?
  end

  def redirect_url
    Rails.application.routes.url_helpers.redirect_url(key: self.key)
  end
end
