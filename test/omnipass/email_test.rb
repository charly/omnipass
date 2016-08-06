require_relative "../test_helper"

class EmailTest < MiniTest::Unit::TestCase

  def setup
    @email = Omnipass::Email.new(
      email: "charly@gmail.com",
      password: "omnipass",
      password_confirmation: "omnipass")
  end

  def test_id_creation
    assert_equal @email.save, true
  end

  def test_password
    assert_equal @email.password_digest.size, 60
  end

  def test_form_class
    assert_equal Omnipass::Email, @email.class
  end

end