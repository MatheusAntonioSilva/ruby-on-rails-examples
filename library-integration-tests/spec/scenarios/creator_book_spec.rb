require 'spec_helper'

describe '#create book - https://libraryapp-rails.herokuapp.com/v0/users' do
  let(:book_params) do
    {
      file: ::File.open('spec/support/Curriculum.pdf'),
      title: "Test Book #{Random.rand(100000)}",
      description: 'Test Description',
      'author[name]': 'Test Author'
    }
  end
  let(:headers) do
    { 'Content-Type' => 'application/json' }
  end
  let(:header_created_book) do
    { 'Content-Type' => 'multipart/form-data; boundary=<calculated when request is sent>',
      'Authorization' => authorization }
  end

  let(:authorization) { nil }
  let(:response_created_book) do
    ::HTTParty.post('https://libraryapp-rails.herokuapp.com/v0/books', body: book_params,
                                                                       headers: header_created_book)
  end

  context 'when user has not authorized' do
    it 'responses unprocessable entity' do
      expect(response_created_book.code).to eq(401)
      expect(response_created_book.body).to eq('Para continuar, faça login ou registre-se.')
    end
  end

  context 'when user has authorized' do
    let(:user_params) do
      {
        user: {
          first_name: "NewTest",
          last_name: "Test",
          email: "test-new#{Random.rand(100000)}@email.com",
          password: "mypassword",
          password_confirmation: "mypassword",
          kind: 'librarian'
        }
      }
    end

    let!(:response_created_user) do
      ::HTTParty.post('https://libraryapp-rails.herokuapp.com/v0/users', body: user_params.to_json, headers: headers)
    end
    let(:authorization) { response_created_user.headers['authorization'] }

    it 'responses created' do
      expect(response_created_book.code).to eq(201)
      expect(JSON.parse(response_created_book.body).keys).to eq(["id", "title", "description", "public_url", "user", "author", "created_at", "updated_at"])
    end

    context 'when goes something wrong' do
      let(:book_params) do
        super().except(:title)
      end

      it 'responses unprocessable entity' do
        expect(response_created_book.code).to eq(422)
        expect(JSON.parse(response_created_book.body).keys).to eq(["tag", "error"])
      end
    end
  end
end
