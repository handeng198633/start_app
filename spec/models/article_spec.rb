require 'spec_helper'

describe Article do
  let(:user) { FactoryGirl.create(:user) }
 # before do
 #	@article = Article.new(title: "Han Deng for article test", content:"Deng Han", user_id: user.id)
 # end
  before { @article = user.articles.build(title: "Han Deng for article test", content:"Deng Han") }

  subject { @article }

  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }

  its(:user) { should eq user }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @article.user_id = nil }
		it { should_not be_valid }
	end

	describe "with blank content" do
		before { @article.content = " "}
		it { should_not be_valid }
	end

	describe "with content that is too long" do
		before { @article.content = "a" * 14001 }
		it { should_not be_valid }
	end
end
