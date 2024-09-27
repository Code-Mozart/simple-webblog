require 'rails_helper'

RSpec.describe "Blogs", type: :system do
  TITLE_ID = "#title"
  BODY_ID = "#body"

  # FIXME: this does not quite work yet and says 401. Its really hard to find recent documentation for this.
  # # taken from https://stackoverflow.com/questions/53082658/how-do-you-fill-in-or-bypass-http-basic-auth-in-rails-5-2-system-tests
  # def visit_authenticated(path)
  #   credentials = Rails.application.credentials
  #   name = credentials.dig(:basic_authentication, :name)
  #   password = credentials.dig(:basic_authentication, :password)
  #   visit "http://#{name}:#{password}@example.com:3000#{path}"
  # end

  before do |example|
    driven_by(:rack_test)
  end

  subject { page }

  # FIXME: if we figure out how to authenticate during tests then we should also
  # specify the behaviour when we are not authenticated
  context "when visiting the index without being authenticated", :unauthenticated do
  end

  context "when creating a blog" do
    let(:blog_attributes) { attributes_for :blog }
    before do
      visit new_blog_path

      fill_in "Title", with: blog_attributes[:title]
      fill_in "Body", with: blog_attributes[:body]

      click_button "Create Blog"
    end

    it { expect(page.find TITLE_ID).to have_text_with_normalized_whitespace(blog_attributes[:title]) }
    it { expect(page.find BODY_ID).to have_text_with_normalized_whitespace(blog_attributes[:body]) }

    context "and returning to the index" do
      before do
        visit blogs_path
      end

      it { is_expected.to have_text_with_normalized_whitespace(blog_attributes[:title], :include_hidden_text) }
      it { is_expected.to have_text_with_normalized_whitespace(blog_attributes[:body], :include_hidden_text) }
    end
  end

  context "when visiting a blog" do
    let(:blog) { create :blog }

    before do
      visit blog_path(blog)
    end

    it { expect(page.find TITLE_ID).to have_text_with_normalized_whitespace(blog.title) }
    it { expect(page.find BODY_ID).to have_text_with_normalized_whitespace(blog.body) }
  end

  context "when editing a blog" do
    let(:blog) { create :blog }
    let(:new_blog_attributes) { attributes_for :blog }

    before do
      visit edit_blog_path(blog)
    end

    describe "the initial form" do
      it { expect(page.find "#blog_title").to have_text_with_normalized_whitespace(blog.title) }
      it { expect(page.find "#blog_body").to have_text_with_normalized_whitespace(blog.body) }
    end

    context "after saving the changes" do
      before do
        fill_in "Title", with: new_blog_attributes[:title]
        fill_in "Body", with: new_blog_attributes[:body]

        click_button "Update Blog"
      end

      it { expect(page.find TITLE_ID).to have_text_with_normalized_whitespace(new_blog_attributes[:title]) }
      it { expect(page.find BODY_ID).to have_text_with_normalized_whitespace(new_blog_attributes[:body]) }

      context "and returning to the index" do
        before do
          visit blogs_path
        end

        it { is_expected.to have_text_with_normalized_whitespace(new_blog_attributes[:title], :include_hidden_text) }
        it { is_expected.to have_text_with_normalized_whitespace(new_blog_attributes[:body], :include_hidden_text) }
      end
    end
  end

  context "when deleting a blog" do
    let(:blog) { create :blog }

    before do
      visit blog_path(blog)
      click_button "Destroy this blog"
    end

    it { is_expected.not_to have_text_with_normalized_whitespace(blog.title, :include_hidden_text) }
    it { is_expected.not_to have_text_with_normalized_whitespace(blog.body, :include_hidden_text) }
  end
end
