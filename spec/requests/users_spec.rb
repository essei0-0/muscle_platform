require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/:id" do
    let(:user){ FactoryBot.create(:user) }
    let(:signup_params){ {'user': {id: 1, name: 'test', email: 'test@test.com', password: 'password'}} }
    let(:login_params){ {'session': {id: 1, name: 'test', email: 'test@test.com', password: 'password'}} }
    let(:resistered_user){ FactoryBot.create(:user) }
    context "as a not authenticated user" do
      # user#show
      it "show resistered user page" do
        get user_path(resistered_user.id)
        expect(response).to have_http_status(200)
      end

      # user#new
      it "show signup page" do
        get signup_path
        expect(response).to have_http_status(200)
      end

      # user#create
      it "create user" do
        expect {
          post signup_path, params: signup_params
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(303)
      end

      # user#edit
      it "edit user" do
        get edit_user_path(user.id)
        expect(response).to have_http_status(403)
      end
    end

    context "as a authenticated user" do
      # user#show
      it "show resistered user page" do
        get user_path(resistered_user.id)
        expect(response).to have_http_status(200)
      end

      # user#new
      it "redirect from signup page" do
        post signup_path, params: signup_params
        get signup_path
        expect(response).to have_http_status(403)
      end

      # user#edit
      it "edit user" do
        # post login_path, params: login_params
        # get edit_user_path(user.id)
        # expect(response).to have_http_status(200)
      end
    end
  end
end
