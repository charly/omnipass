require_relative "../test_helper"

class AuthenticateTest < MiniTest::Unit::TestCase

  def setup
    create_authentication
    @authenticate = Omnipass::Authenticate.build(env_hash)
  end


  def test_account_init
    assert @authenticate.account.attributes ==
           Omnipass::Account.new(email: "charlysisto@gmail.com").attributes
  end

  def test_authentication_found
    assert_equal @authenticate.authentication, @authentication
  end

private

  def env_hash
    {
      "uid" => "23",
      "provider" => "omnipass",
      "info"=> {
        "name"=>"charlysisto@gmail.com",
        "email"=>"charlysisto@gmail.com"},
      "credentials" => {},
      "extra" => {}
    }
  end

  def create_authentication
    @authentication = Omnipass::Authentication.first_or_create(
      email: "charlysisto@gmail.com",
      provider: "omnipass",
      uid: "23")
  end

end