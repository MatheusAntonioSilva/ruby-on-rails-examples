class ::V0::Users::SessionsController < Devise::SessionsController

  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: resource, status: :ok, serializer: ::V0::SessionSerializer::SignIn
  end

  def respond_to_on_destroy
    render json: {}, status: :ok, serializer: ::V0::SessionSerializer::SignOut
  end
end
