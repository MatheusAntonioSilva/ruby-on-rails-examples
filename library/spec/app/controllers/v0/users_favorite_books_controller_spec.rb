require 'rails_helper'

describe ::V0::UsersFavoriteBooksController, type: :controller do

  describe '#create' do
    let(:file) { Tempfile.new }
    let(:user_kind) { ::User::READER }

    let(:user) { create(:user, kind: user_kind) }
    let(:book_id) { create(:book, user_id: user.id, author_id: create(:author, user_id: user.id).id).id }

    let(:params) { { book_id: book_id } }

    context 'when user is not authenticated' do
      before do
        post :create, params: params
      end

      it 'responses 401' do
        expect(response.code).to eq('401')
        expect(response.body).to eq(I18n.t('devise.failure.unauthenticated'))
      end
    end

    context 'when user is authenticated' do
      before do
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)

        post :create, params: params
      end

      context 'successfully' do
        it 'responses 201' do
          expect(response.code).to eq('201')
          expect(JSON.parse(response.body).keys).to eq(["id", "user", "book", "created_at", "updated_at"])
        end
      end

      context 'when goes something wrong' do
        context 'when user cannot create books' do
          let(:user_kind) { ::User::LIBRARIAN }

          it 'responses 401' do
            expect(response.code).to eq('401')
            expect(JSON.parse(response.body).keys).to eq(['tag', 'error'])
          end
        end
      end
    end
  end
end
