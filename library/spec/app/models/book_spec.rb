require 'rails_helper'

describe ::Book, type: :model do

  describe '#validates' do
    let(:title) { 'Test' }
    let(:description) { 'Test' }
    let(:public_url) { 'https://library-test-files.s3.amazonaws.com/07aasda00c25-2b06-475e-be08-4d3c42705a30.png' }
    let(:file_name) { '07a00c25-2b06-475e-be08-4d3c42705a30.png' }
    let(:user_id) { create(:user).id }
    let(:author_id) { create(:author, user_id: user_id).id }
    let(:book) do
      create(:book, title: title, description: description, public_url: public_url,
                    file_name: file_name, user_id: user_id,
                    author_id: author_id)
    end

    context 'when title is blank' do
      let(:title) { nil }

      it 'raises an error' do
        expect { book }.to raise_error(::ActiveRecord::RecordInvalid, /não pode ficar em branco/)
      end
    end

    context 'when description is blank' do
      let(:description) { nil }

      it 'raises an error' do
        expect { book }.to raise_error(::ActiveRecord::RecordInvalid, /não pode ficar em branco/)
      end
    end

    context 'when public_url is blank' do
      let(:public_url) { nil }

      it 'raises an error' do
        expect { book }.to raise_error(::ActiveRecord::RecordInvalid, /não pode ficar em branco/)
      end
    end

    context 'when file_name is blank' do
      let(:file_name) { nil }

      it 'raises an error' do
        expect { book }.to raise_error(::ActiveRecord::RecordInvalid, /não pode ficar em branco/)
      end
    end

    context 'when user_id is blank' do
      let(:user_id) { nil }
      let(:author_id) { nil }

      it 'raises an error' do
        expect { book }.to raise_error(::ActiveRecord::RecordInvalid, /não pode ficar em branco/)
      end
    end

    context 'when author_id is blank' do
      let(:author_id) { nil }

      it 'raises an error' do
        expect { book }.to raise_error(::ActiveRecord::RecordInvalid, /não pode ficar em branco/)
      end
    end
  end
end
