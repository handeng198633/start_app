require 'spec_helper'

describe "ArticlePages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "index" do
    let(:user) { FactoryGirl.create(:user)}
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_content('All') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:article) } }
      after(:all) { Article.delete_all }

      it {should have_selector('div.pagination')}

#      it "should list each article" do
#        Article.paginate(page: 1).each do |article|
#         expect(page).to have_selector('span', text: article.title)
#       end
 #     end
    end

  end

  describe "article creation" do
  	before { visit root_path }

  	describe "with invalid information" do

  		it "should not create a article" do
  			expect { click_button "Post"}.not_to change(Article, :count)
  		end

  		describe "error message" do
  			before { click_button "Post" }
  			it { should have_content('error') }
  		end
  	end

  	describe "with valid information" do
  		before { fill_in 'article_title', with: "Lorem ipsum"}
      before { fill_in 'article_content', with: "Spec test for article static page"}
  		it "should create a article" do
  			expect { click_button "Post"}.to change(Article, :count).by(1)
  		end
  	end
  end

  describe "article destruction" do
  	before { FactoryGirl.create(:article, user: user) }

  	describe "as correct user" do
  		before { visit root_path }

  		it "should delete a article" do
  			expect { click_link "delete" }.to change(Article, :count).by(-1)
  		end
  	end
  end
end
