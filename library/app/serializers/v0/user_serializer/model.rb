module V0
  module UserSerializer
    class Model < V0::ApplicationSerializer::Model
      attributes :id, :first_name, :last_name, :email

      attribute(:created_at) { object.created_at.as_json }
      attribute(:updated_at) { object.updated_at.as_json }
    end
  end
end
