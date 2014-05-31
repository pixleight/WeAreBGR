class Creator < ActiveRecord::Base
  serialize :accounts, JSON

  # Hooks
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  # Attachments
  has_attached_file :avatar,
    styles: {
      large: "600x600#",
      medium: "300x300#",
      thumb: "100x100#" },
    convert_options: {
      large: "-quality 75 -strip",
      medium: "-quality 75 -strip",
      thumb: "-quality 75 -strip" },
    default_url: "/images/creators/:style/missing.png"
  validates_attachment :avatar,
    content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
    size: { in: 0..5.megabytes }

  # Relationships
  acts_as_taggable

  # Validations
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, if: :password
  validates :description, length: { maximum: 140 }

  def Creator.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Creator.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = Creator.digest(Creator.new_remember_token)
    end
end
