module Omnipass
  class Authenticate

    include Virtus.model
    include ActiveModel::Model

    attribute :provider
    attribute :uid
    attribute :info, Hash
    attribute :credentials, Hash

    validates :provider, :uid, :info, presence: true

    # instantiate OmniauthSession with the controller env
    def self.build( omni_hash )
      self.new omni_hash.slice("provider", "uid", "info", "credentials")
    end

    def email
      info.fetch("email") { "nomail" }
    end

    def save
      link_or_create_account
      authentication.transaction do
        authentication.save
      end
    end

    def authentication
      @authentication ||= Omnipass::Authentication.
        where(attributes.slice(:provider, :uid)).first_or_create
    end

    def account
      @account ||= Omnipass::Account.where(email: email).first_or_initialize
    end

  # private
    def link_or_create_account
      authentication.account || (authentication.account = account)
    end
  end
end