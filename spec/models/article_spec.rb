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
end
