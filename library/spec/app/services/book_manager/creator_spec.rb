require 'rails_helper'

describe ::BookManager::Creator do
  let(:user_kind) { ::User::LIBRARIAN }
  let(:user) { create(:user, kind: user_kind) }
  let(:title) { 'Test' }
  let(:description) { 'Test' }
  let(:public_url) { 'https://library-test-files.s3.amazonaws.com/07aasda00c25-2b06-475e-be08-4d3c42705a30.png' }
  let(:file_name) { '07a00c25-2b06-475e-be08-4d3c42705a30.png' }
  let(:author_id) { create(:author, user_id: user.id).id }
  let(:args) do
    {
      title: title, description: description, public_url: public_url,
      file_name: file_name, author: { name: 'Test' }
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
      it 'creates book' do
        expect(instance.create.persisted?).to eq(true)
      end
    end

    context 'when goes something wrong' do
      let(:user_kind) { ::User::READER }
      let(:exception) { ::Exceptions::AccessNotAllowedError.new }

      it 'raises an error' do
        expect { instance.create }.to raise_error(exception.class, exception.message)
      end
    end
  end
end
