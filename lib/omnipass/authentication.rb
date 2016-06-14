
module Omnipass
  class Authentication < ActiveRecord::Base
    belongs_to :user
    belongs_to :account

    # CAUTION : this can be used in a has_on :through: :authentications
    belongs_to :identity, class_name: "Users::Identity"

    # before_save :copy_uid_to_identity_id # uncomment after migration

    def copy_uid_to_identity_id
      self.identity_id = uid if provider == "identity"
    end

  end
end