module V0
  class BooksController < ::V0::ApplicationController

    before_action :authenticate_user!

    def index
      lister_params = params.permit(:title, :description, :author)
      lister = ::BookManager::Lister.new(params[:page], params[:per_page], lister_params)
      render json: lister.build, serializer: ::V0::BookSerializer::ListResource
    end

    def create
      creator = ::BookManager::Creator.new(current_user, book_params)
      render json: creator.create, status: :created, serializer: ::V0::BookSerializer::Model
    end

    def update
      updater = ::BookManager::Updater.new(book_params[:id], current_user, book_params)
      render json: updater.update, status: :created, serializer: ::V0::BookSerializer::Model
    end

    def show
      shower = ::BookManager::Shower.new(params[:id])
      render json: shower.build, serializer: ::V0::BookSerializer::Shower
    end

    def destroy
      destroyer = ::BookManager::Destroyer.new(params[:id], user)
      render json: destroyer.destroy, serializer: ::V0::BookSerializer::Model
    end

    private

    def book_params
      params.permit(:id, :title, :description, :file, author: [:name])
    end
  end
end
