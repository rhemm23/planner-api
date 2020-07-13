class PasswordSecurity
  def self.hash(password)
    Base64.encode64(
      get_hash_bytes(
        OpenSSL::Digest::SHA256.new,
        OpenSSL::Random.random_bytes(16),
        password
      )
    )
  end

  def self.verify(password_digest, password)
    raw = Base64.decode64(password_digest)
    raw[16..-1] == get_hash_bytes(
      OpenSSL::Digest::SHA256.new,
      raw[0..16],
      password
    )
  end

  private

  def self.get_hash_bytes(hash, salt, password)
    OpenSSL::KDF.pbkdf2_hmac(
      password,
      salt: salt,
      hash: hash,
      iterations: 20_000,
      length: hash.digest_length
    )
  end
end