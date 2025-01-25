require 'spec_helper'

describe '#create user - https://libraryapp-rails.herokuapp.com/v0/users' do

  let(:params) do
    {
      user: {
        first_name: "NewTest",
        last_name: "Test",
        email: "test#{Random.rand(100000)}@email.com",
        password: "mypassword",
        password_confirmation: "mypassword"
      }
    }
  end
  let(:headers) do
    { 'Content-Type' => 'application/json' }
  end

  let(:response) { ::HTTParty.post('https://libraryapp-rails.herokuapp.com/v0/users', body: params.to_json, headers: headers) }

  it 'responses created' do
    expect(response.code).to eq(201)
    expect(JSON.parse(response.body).keys).to eq(['id', 'first_name', 'last_name', 'email', 'created_at', 'updated_at'])
  end

  context 'when goes something wrong' do
    let(:params) do
      super()[:user].delete(:first_name)
      super()
    end

    it 'responses unprocessable entity' do
      expect(response.code).to eq(422)
      expect(JSON.parse(response.body).keys).to eq(["tag", "error"])
    end
  end
end
