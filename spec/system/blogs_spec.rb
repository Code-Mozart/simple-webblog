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

    it { expect(page.find TITLE_ID).to have_text(blog_attributes[:title].gsub(/\n/, "\r ")) }
    it { expect(page.find BODY_ID).to have_text(blog_attributes[:body].gsub(/\n/, "\r ")) }

    context "and returning to the index" do
      before do
        visit blogs_path
      end

      it { is_expected.to have_text(:all, blog_attributes[:title].gsub(/\n/, "\r ")) }
      it { is_expected.to have_text(:all, blog_attributes[:body].gsub(/\n/, "\r ")) }
    end
  end

  context "when visiting a blog" do
    let(:blog) { create :blog }

    before do
      visit blog_path(blog)
    end

    it { expect(page.find TITLE_ID).to have_text(blog.title.gsub(/\n/, "\r ")) }
    it { expect(page.find BODY_ID).to have_text(blog.body.gsub(/\n/, "\r ")) }
  end

  context "when editing a blog" do
    let(:blog) { create :blog }
    let(:new_blog_attributes) { attributes_for :blog }

    before do
      visit edit_blog_path(blog)
    end

    describe "the initial form" do
      it { expect(page.find "#blog_title").to have_text(blog.title.gsub(/\n/, "\r ")) }
      it { expect(page.find "#blog_body").to have_text(blog.body.gsub(/\n/, "\r ")) }
    end

    context "after saving the changes" do
      before do
        fill_in "Title", with: new_blog_attributes[:title]
        fill_in "Body", with: new_blog_attributes[:body]

        click_button "Update Blog"
      end

      it { expect(page.find TITLE_ID).to have_text(:all, new_blog_attributes[:title].gsub(/\n/, "\r ")) }
      it { expect(page.find BODY_ID).to have_text(:all, new_blog_attributes[:body].gsub(/\n/, "\r ")) }

      context "and returning to the index" do
        before do
          visit blogs_path
        end

        it { is_expected.to have_text(:all, new_blog_attributes[:title].gsub(/\n/, "\r ")) }
        it { is_expected.to have_text(:all, new_blog_attributes[:body].gsub(/\n/, "\r ")) }
      end
    end
  end

  context "when deleting a blog" do
    let(:blog) { create :blog }

    before do
      visit blog_path(blog)
      click_button "Destroy this blog"
    end

    it { is_expected.not_to have_text(:all, blog.title.gsub(/\n/, "\r ")) }
    it { is_expected.not_to have_text(:all, blog.body.gsub(/\n/, "\r ")) }
  end

  # FIXME: sometimes some examples fail because of the weird behaviour with the line endings.
  # "expect(...).to have_text(...)" seems to check for an exact match so the line endings
  # must also match. they sometimes do and sometimes do not. this is something to look into.
  # maybe just find a way to dont match the string even if the whitespaces differ.
end
