require_relative "../test_helper"

class AuthenticationTest < MiniTest::Unit::TestCase

  def setup
    @authentication = Omnipass::Authentication.create(
      email: "charly@gmail.com",
      provider: "omnipass",
      uid: "23")
  end

  def test_id_creation
    assert @authentication.id > 0
  end

  def test_form
    assert @authentication.respond_to?(:user)
  end

  def test_form_class
    assert_equal Omnipass::Authentication, @authentication.class
  end

end