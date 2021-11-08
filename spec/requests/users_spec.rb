require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/:id" do
    it "show user page to guest user" do
      user = FactoryBot.create(:user)
      get user_path(user.id)
      expect(response).to have_http_status(200)
    end
  end
end
