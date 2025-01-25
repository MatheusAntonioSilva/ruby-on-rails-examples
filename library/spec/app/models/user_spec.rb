require 'rails_helper'

describe ::User, type: :model do

  describe '#validates' do
    context 'when there is already persisted email the equals the email of the new record' do
      let(:user) { create(:user) }

      before do
        create(:user)
      end

      it 'raises an error' do
        expect { user }.to raise_error(::ActiveRecord::RecordInvalid, /já está em uso/)
      end
    end

    context 'when there are not persisted record with same user and book the new record' do
      let(:email) { 'test@gmail.com' }
      let(:first_name) { 'Test' }
      let(:last_name) { 'Last Name'}
      let(:password) { 'test123' }
      let(:password_confirmation) { 'test123' }
      let(:user) do
        create(:user, email: email, first_name: first_name, last_name: last_name, password: password, password_confirmation: password_confirmation)
      end

      context 'when email is blank' do
        let(:email) { nil }

        it 'raises an error' do
          expect { user }.to raise_error(::ActiveRecord::RecordInvalid, /não pode ficar em branco/)
        end
      end

      context 'when first_name is blank' do
        let(:first_name) { nil }

        it 'raises an error' do
          expect { user }.to raise_error(::ActiveRecord::RecordInvalid, /não pode ficar em branco/)
        end
      end

      context 'when last_name is blank' do
        let(:last_name) { nil }

        it 'raises an error' do
          expect { user }.to raise_error(::ActiveRecord::RecordInvalid, /não pode ficar em branco/)
        end
      end

      context 'when password is blank' do
        let(:password) { nil }

        it 'raises an error' do
          expect { user }.to raise_error(::ActiveRecord::RecordInvalid, /não pode ficar em branco/)
        end
      end

      context 'when password_confirmation is blank' do
        let(:password_confirmation) { nil }

        it 'raises an error' do
          expect { user }.to raise_error(::ActiveRecord::RecordInvalid, /não pode ficar em branco/)
        end
      end

      context 'when password_confirmation is different of password' do
        let(:password_confirmation) { 'test142' }

        it 'raises an error' do
          expect { user }.to raise_error(::ActiveRecord::RecordInvalid, /Confirme sua senha não é igual a Senha/)
        end
      end
    end
  end
end
