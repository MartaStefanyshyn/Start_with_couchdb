require 'couchrest_model'
class User < CouchRest::Model::Base
  property :email, String
  property :password, String
  property :password_confirmation, String
  property :password_salt, String
  property :password_hash, String
  before_save :encrypt_password
  design do
    view :by_email
    view :by_id,
           map: "function(doc) {
                  if (doc['type'] == 'User') {
                     emit(doc._id, doc);
                  }
                }"
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
