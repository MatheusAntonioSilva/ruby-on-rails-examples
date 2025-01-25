require 'rails_helper'

describe ::UsersFavoriteBookManager::Creator do
  let(:user_kind) { ::User::READER }
  let(:user) { create(:user, kind: user_kind) }
  let(:book_id) { create(:book, user_id: user.id, author_id: create(:author, user_id: user.id).id).id }
  let(:args) do
    {
      book_id: book_id
    }
  end

  let(:instance) { described_class.new(user, args) }

  describe '#initialize' do
    it 'sets reader attribute' do
      expect(instance.user).to eq(user)
      expect(instance.args).to eq(args)
    end
  end

  describe '#create' do
    context 'succesfully' do
      it 'creates favorite book' do
        expect(instance.create.persisted?).to eq(true)
      end
    end

    context 'when goes something wrong' do
      let(:user_kind) { ::User::LIBRARIAN }
      let(:exception) { ::Exceptions::AccessNotAllowedError.new }

      it 'raises an error' do
        expect { instance.create }.to raise_error(exception.class, exception.message)
      end
    end
  end
end
