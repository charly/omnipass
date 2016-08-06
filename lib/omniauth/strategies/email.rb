module OmniAuth
  module Strategies
    # The identity strategy allows you to provide simple internal
    # user authentication using the same process flow that you
    # use for external OmniAuth providers.
    class Email
      include OmniAuth::Strategy

      option :fields, [:name, :email]
      # option :on_login, nil
      # option :on_rèegistration, nil
      # option :on_failed_registration, nil
      # option :locate_conditions, lambda{|req| {model.auth_key => req['auth_key']} }

      def callback_phase
        return fail!(:invalid_credentials) unless identity
        super
      end

      uid  { identity.uid }
      info { identity.info }

      def identity
        if request["session"]
          find_identity_with_session
        else
          find_identity_with_token
        end
      end

      def model
        options[:model] || Omnipass::Email
      end

    private
      def find_identity_with_session
        @identity ||= ::Omnipass::Email.authenticate(
          # request["session"].slice("email"),
          # request["session"]['password']
          request["session"]
        )
      end

      def find_identity_with_token
        @identity||= ::Omnipass::Email.find_by_token(
          request["confirmation_token"]
        )
      end

    end
  end
end
