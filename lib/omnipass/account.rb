module Omnipass
  class Account < ActiveRecord::Base

    has_many  :authentications, dependent: :destroy,
                class_name: "Users::Authentication"
    has_one   :identity_auth, -> {where(provider: "identity")},
                class_name: "Users::Authentication"
    has_one   :identity, through: :identity_auth


  end
end