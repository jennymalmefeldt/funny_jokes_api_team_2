RSpec.describe "POST /api/v1/votes", type: :request do
  let!(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: "application/json" }.merge!(credentials) }

  describe "successfully" do
    before do
      post "/api/v1/votes",
           params: {
             jokeId: "db09c5d9659d44448c4da0ae5d321e55",
           },
           headers: headers
    end

    it "should respond with 200 status" do
      expect(response.status).to eq 200
    end

    it "should respond with success message" do
      expect(response_json["message"]).to eq "Thank's for your vote!"
    end

    it "should respond with joke_id" do
      expect(response_json["joke"]).to have_key "id"
    end

    it "api responds with the same joke that was sent in the post request" do
      expect(response_json["joke"]["id"]).to eq "db09c5d9659d44448c4da0ae5d321e55"
    end
  end

  describe "unsuccessfully" do
    before do
      post "/api/v1/votes",
           params: {
             jokeId: "invalid_id",
           },
           headers: headers
    end

    it "should respond with 404 status" do
      expect(response.status).to eq 404
    end

    it "should respond with error message" do
      expect(response_json["error_message"]).to eq "Sorry, we are not that funny, we don't have that joke!"
    end
  end
end
