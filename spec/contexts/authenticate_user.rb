RSpec.shared_context "sign in user" do
  before :all do
    @user = create :user
    @auth_headers = @user.create_new_auth_token.merge({accept: "application/json"})
  end
end
