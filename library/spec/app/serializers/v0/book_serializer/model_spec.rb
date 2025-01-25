require 'rails_helper'

describe V0::BookSerializer::Model do

  let(:user) { create(:user) }
  let(:object) { create(:book, user_id: user.id, author_id: create(:author, user_id: user.id).id) }
  let(:instance) { described_class.new(object) }
  let(:result) { JSON.parse(instance.to_json) }

  it { expect(result.keys.sort).to eq(["author", "created_at", "description", "id", "public_url", "title", "updated_at", "user"]) }
end
