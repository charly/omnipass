#
#
#
#
module Omnipass
  class Email < ActiveRecord::Base
    self.table_name = 'identities'
    has_secure_password
    paramount
    # paramount :form_admin, Admin::ScanForm

    validates :email, uniqueness: true

    def self.find_by_token(token)
      unless token.blank?
        all.where(confirmation_token: token).first
      end
    end

    def self.authenticate(params)
      login_pass_hash = params.symbolize_keys

      instance = locate(login_pass_hash.slice(:email))
      return false unless instance
      instance.authenticate(login_pass_hash[:password])
    end

    def self.locate(search_hash)
      where(search_hash).first
    end

    alias uid id

    def info
      {name: email, email: email}
    end

    def generate_confirmation_token
      self.confirmation_token = SecureRandom.base58(24)
    end

    def confirm
      generate_confirmation_token
      self.confirmed_at= Time.now.utc
      save
    end

    def confirmed?
      !!confirmed_at
    end

    def form_admin(params = nil)
      Admin::Users::IdentityForm.new(params, self)
    end

  end
end
