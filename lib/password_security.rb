class PasswordSecurity
  def self.hash(password)
    salt = OpenSSL::Random.random_bytes(16)
    Base64.encode64(
      salt.concat(
        get_hash_bytes(
          OpenSSL::Digest::SHA256.new,
          salt,
          password
        )
      )
    )
  end

  def self.verify(password_digest, password)
    raw = Base64.decode64(password_digest)
    raw[16..-1] == get_hash_bytes(
      OpenSSL::Digest::SHA256.new,
      raw[0..15],
      password
    )
  end

  private

  def self.get_hash_bytes(digest, salt, password)
    OpenSSL::KDF.pbkdf2_hmac(
      password,
      salt: salt,
      iterations: 20_000,
      length: digest.digest_length,
      hash: digest
    )
  end
end