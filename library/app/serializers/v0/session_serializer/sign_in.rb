module V0
  module SessionSerializer
    class SignIn < ::ApplicationSerializer::Model

      attribute(:message) { I18n.t('devise.sessions.signed_in') }
    end
  end
end

