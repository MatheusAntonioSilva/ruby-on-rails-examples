module V0
  module SessionSerializer
    class SignOut < ::ApplicationSerializer::Model

      type :colletion

      attribute(:message) { I18n.t('devise.sessions.signed_out') }
    end
  end
end

