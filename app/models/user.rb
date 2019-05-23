class User < ApplicationRecord
  after_initialize :ensure_session_token

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return unless user&.correct_password?(password)

    user
  end

  def reset_session_token!
    update!(session_token: self.class.generate_session_token)
    session_token
  end

  def correct_password?(password)
    encrypted_password = BCrypt::Password.new(password_digest)
    encrypted_password.is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  private

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
