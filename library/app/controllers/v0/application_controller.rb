class ::V0::ApplicationController < ::ApplicationController

  private

  def authenticate_v0_user!
    return if v0_user_signed_in?

    raise ::Exceptions::UnauthorizedError
  end
end
