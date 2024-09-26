require 'rails_helper'

RSpec.describe Blog, type: :model do
  subject(:blog) { create :blog }

  describe "Validations" do
    it("validates the presence of the title") do
      blog.title = ""
      is_expected.not_to be_valid
    end

    it("validates the presence of the body") do
      blog.body = ""
      is_expected.not_to be_valid
    end
  end
end
