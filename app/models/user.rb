# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  username        :string
#  password_digest :string
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_many :user_events
  has_many :events, through: :user_events

  after_initialize :ensure_session_token

  # Validations
  validates :session_token, :password_digest, presence: true
  validates :email, uniqueness: true, presence: true
  # TODO: Possibly add additional validations for password. Require a sym? num?
  validates :password, length: { minimum: 8 }, allow_nil: true

  # Readers, Writers, and Accessors
  attr_reader :password

  # @return User object is email and password are found
  # @return nil if either user isn't found or password isn't correct
  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    user&.correct_password?(password) ? user : nil
  end

  # @return session_token after a new one is randomly generated
  def reset_session_token!
    update!(session_token: self.class.generate_session_token)
    session_token
  end

  # @return boolean
  # Converts the password digest string back to BCrypt object
  # and checks to match the password the user enters
  def correct_password?(password)
    encrypted_password = BCrypt::Password.new(password_digest)
    encrypted_password.is_password?(password)
  end

  # @return password_digest
  # Takes a user made password and saves a hashed string into password_digest
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  private

  # @return [String]
  # random set of characters
  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  # @return session_token
  # Retrieves current session_token of assigns a new one.
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
