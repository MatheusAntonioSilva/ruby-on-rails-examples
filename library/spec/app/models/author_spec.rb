require 'rails_helper'

describe ::Author, type: :model do

  describe '#validates' do
    let(:user_id) { create(:user).id }
    let(:name) { 'Test' }
    let(:author) { create(:author, name: name, user_id: user_id) }

    context 'when name is blank' do
      let(:name) { nil }

      it 'raises an error' do
        expect { author }.to raise_error(::ActiveRecord::RecordInvalid, /não pode ficar em branco/)
      end
    end

    context 'when user_id is blank' do
      let(:user_id) { nil }

      it 'raises an error' do
        expect { author }.to raise_error(::ActiveRecord::RecordInvalid, /não pode ficar em branco/)
      end
    end
  end
end
