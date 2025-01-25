module V0
  class UsersFavoriteBooksController < ::V0::ApplicationController

    before_action :authenticate_user!

    def create
      permited_params = params.permit(:book_id)
      creator = ::UsersFavoriteBookManager::Creator.new(current_user, permited_params)
      render json: creator.create, status: :created, serializer: ::V0::UsersFavoriteBookSerializer::Model
    end

    def destroy
      destroyer = ::UsersFavoriteBookManager::Destroyer.new(current_user, params[:book_id])
      render json: destroyer.destroy, serializer: ::V0::UsersFavoriteBookSerializer::Model
    end
  end
end
