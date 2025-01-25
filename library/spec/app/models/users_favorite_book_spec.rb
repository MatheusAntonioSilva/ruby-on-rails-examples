require 'rails_helper'

describe ::UsersFavoriteBook, type: :model do

  describe '#validates' do
    context 'when there is already persisted record with same user and book the new record' do
      let(:user_id) { create(:user).id }
      let(:book_id) { create(:book, user_id: user_id, author_id: create(:author, user_id: user_id).id).id }
      let(:create_object) { create(:users_favorite_book, user_id: user_id, book_id: book_id) }

      before do
        create(:users_favorite_book, user_id: user_id, book_id: book_id)
      end

      it 'raises an error' do
        expect { create_object }.to raise_error(::ActiveRecord::RecordInvalid, /já está em uso/)
      end
    end

    context 'when there are not persisted record with same user and book the new record' do
      let(:user_id) { create(:user).id }
      let(:book_id) { create(:book, user_id: user_id, author_id: create(:author, user_id: user_id).id).id }
      let(:create_object) { create(:users_favorite_book, user_id: user_id, book_id: book_id) }

      context 'when user_id is blank' do
        let(:user_id) { nil }

        it 'raises an error' do
          expect { create_object }.to raise_error(::ActiveRecord::RecordInvalid, /não pode ficar em branco/)
        end
      end

      context 'when book_id is blank' do
        let(:book_id) { nil }

        it 'raises an error' do
          expect { create_object }.to raise_error(::ActiveRecord::RecordInvalid, /não pode ficar em branco/)
        end
      end
    end
  end
end
