require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  subject { response }

  describe "GET /blogs" do
    before(:each) {
      get blogs_path
    }
    it("responds with HTTP status code 200 OK") do
      is_expected.to have_http_status(200)
    end
  end
end
