class ::V0::Users::RegistrationsController < Devise::RegistrationsController

  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: resource, status: :created, serializer: ::V0::UserSerializer::Model
    else
      raise ::Exceptions::RegistrationError.new(resource.errors.full_messages.to_sentence)
    end
  end
end
