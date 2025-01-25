require 'rails_helper'

describe ::V0::BooksController, type: :controller do

  describe '#create' do
    let(:file) { Tempfile.new }
    let(:user_kind) { ::User::LIBRARIAN }
    let(:user) { create(:user, kind: user_kind) }
    let(:params) do
      {
        title: 'Test',
        description: 'Test Pipe',
        author: { name: 'Test' },
        file: file
      }
    end

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
          expect(JSON.parse(response.body).keys).to eq(["id", "title", "description", "public_url", "user", "author", "created_at", "updated_at"])
        end
      end

      context 'when goes something wrong' do
        context 'when user cannot create books' do
          let(:user_kind) { ::User::READER }

          it 'responses 401' do
            expect(response.code).to eq('401')
            expect(JSON.parse(response.body).keys).to eq(['tag', 'error'])
          end
        end
      end
    end
  end
end
