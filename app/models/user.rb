class User < ActiveRecord::Base
  attr_reader :password
  after_initialize :ensure_session_token

  validates :email, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :email, :password_digest, :session_token, :name, presence: true

  has_many(
    :projects,
    class_name: "Project",
    foreign_key: :user_id
  )

  belongs_to(
    :location,
    class_name: "Location",
    foreign_key: :location_id,
    primary_key: :id
  )

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    (user && user.is_password?(password)) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.base64
    self.save!
    self.session_token
  end

  private
  def ensure_session_token
    self.session_token ||= SecureRandom.base64
  end
end