require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  include AuthenticationHelper

  subject { response }

  # In my option it would not add anything meaningful to have request specs
  # for all the actions for HTML responses. Therefore only the index action
  # with JSON format is specified here.

  describe "GET /blogs" do
    before(:each) do
      get blogs_path(format: :json), headers: get_authentication_header
    end

    it("responds with HTTP status code 200 OK") do
      is_expected.to have_http_status(200)
    end

    # The following examples were omitted for the scope of the assignment,
    # as JSON responses were not specified in the requirements.
    # In this case we should specify the following behaviour:
    #
    # it "should follow the specified API json schema"
    # it "should return all blogs"
  end

  # If a JSON API were part of the requirements we would proceed to specify
  # the expected behaviour for the other actions...
end
