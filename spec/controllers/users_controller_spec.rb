require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'POST /users' do
    it 'creates a user and returns a token' do
      expect {
        post :create,
          params: { email: 'gsamokovarov@gmail.com', password: 'test1234' },
          as: :json

        json = JSON.parse(response.body).deep_symbolize_keys

        expect(response.body).to eq_as_json(
          data: {
            id: "1",
            type: "users",
            attributes: {
              jwt: json.dig(:data, :attributes, :jwt)
            }
          }
        )
      }.to change { User.count }.by(1)
    end

    it "sends a registration mail" do
      expect {
        post :create,
          params: { email: 'gsamokovarov@gmail.com', password: 'test1234' },
          as: :json
      }.to change { ActionMailer::Base.deliveries.count }
    end
  end
end
