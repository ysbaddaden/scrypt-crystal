require "minitest/autorun"
require "../src/scrypt"

class Scrypt::PasswordTest < Minitest::Test
  def test_initialize
    raw_hash = "400$8$13$bb7cf92fe8429365$bb7441732f14c452cf731c110fa72dc7151adafeaa3b2f8af6f6cb879f03d005"
    pw = Scrypt::Password.new("400$8$13$bb7cf92fe8429365$bb7441732f14c452cf731c110fa72dc7151adafeaa3b2f8af6f6cb879f03d005")

    assert_equal({1024, 8, 19}, pw.cost)
    assert_equal "bb7cf92fe8429365", pw.salt
    assert_equal "bb7441732f14c452cf731c110fa72dc7151adafeaa3b2f8af6f6cb879f03d005", pw.digest
    assert_equal raw_hash, pw.to_s
  end

  def test_equals_ruby_hashes
    pw = Scrypt::Password.new("400$8$13$bb7cf92fe8429365$bb7441732f14c452cf731c110fa72dc7151adafeaa3b2f8af6f6cb879f03d005")
    assert pw == "secret"
    refute pw == "wrong"

    pw = Scrypt::Password.new("400$8$13$1b632959635f453b$5975cc57ff2c24259ca90c1e8633ad70d2a91c866f96dd99e9857f244f065fa3")
    assert pw == "battery-horse"
    refute pw == "wrong"

    pw = Scrypt::Password.new("400$8$13$6757499c1cc67ad3$17f5e8dc499e39b8430e0178295146492ed97ba2e1ba8ed5bc60874989aa3e4c")
    assert pw == "あずまんが大王"
  end

  def test_create
    pw = Password.create("secret", key_len: 32, salt_size: 8)
    assert_match(/\A[a-f0-9]+\$[a-f0-9]+\$[a-f0-9]+\$[a-f0-9]{8}\$[a-z0-9]{64}\Z/, pw.to_s)
    assert pw == "secret"
    refute pw == "guessy"

    pw = Password.create("super secret message", key_len: 64, salt_size: 32)
    assert_match(/\A[a-f0-9]+\$[a-f0-9]+\$[a-f0-9]+\$[a-f0-9]{32}\$[a-z0-9]{128}\Z/, pw.to_s)
    assert pw == "super secret message"
    refute pw == "super wrong message"
  end

  def test_equals
    assert Password.create("あずまんが大王") == "あずまんが大王"
  end
end
