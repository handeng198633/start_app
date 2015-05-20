require 'spec_helper'

describe "StaticPages" do
	subject {page}

	describe "Home page" do
		before {visit root_path}

		it {should have_content('Apache Design')}
		it {should have_title("Ruby on Rails Start App")}
		it {should_not have_title('| Home')}
#		it "should have the content 'Start App'" do
#			expect(page).to have_content('Start App')
#		end
#		it "should have the right title" do
#			expect(page).to have_title("Ruby on Rails Start App")
#		end
#		it "should not have a custom page title " do
#			expect(page).not_to have_title('| Home')
#		end

		describe "for signed-in users" do
			let(:user) { FactoryGirl.create(:user)}
			before do
				FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
				FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
				sign_in user
				visit root_path
			end

			it "should render the user's feed" do
				user.feed.each do |item|
					expect(page).to have_selector("li##{item.id}", text: item.content)
				end
			end
		end
	end

	describe "Help page" do
		before {visit help_path}
		it {should have_content('Help')}
		it {should have_title("Ruby on Rails Start App")}
#		it "should have the content 'Help'" do
#			visit help_path
#			expect(page).to have_content('Help')
#		end

#		it "should have the title 'Help'" do
#			visit help_path
#			expect(page).to have_title("Ruby on Rails Start App")
#		end

	end

	describe "About page" do
		before {visit about_path}
		it {should have_content('About')}
		it {should have_title("Ruby on Rails Start App")}
	end

	describe "Contact page" do
		before {visit contact_path}
		it {should have_content('Contact')}
		it {should have_title("Ruby on Rails Start App")}
	end

end
