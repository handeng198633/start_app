require 'spec_helper'

describe "StaticPages" do
	subject {page}

	describe "Home page" do
		before {visit root_path}

		it {should have_content('Apache Design')}
		it {should have_title("Apache design, Inc.")}
		it {should have_title('Home')}
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
				FactoryGirl.create(:article, user: user, title: "Lorem ipsum", content: "Content test 1")
				FactoryGirl.create(:article, user: user, title: "Dolor sit amet", content: "Content test 2")
				sign_in user
				visit root_path
			end

			it "should render the user's feed" do
				user.feed.each do |item|
					expect(page).to have_selector("li##{item.id}", text: item.title)
				end
			end

			describe "follower/following counts" do
				let(:other_user) { FactoryGirl.create(:user) }
				before do
					other_user.follow!(user)
					visit root_path
				end

				it { should have_link("0 following", href: following_user_path(user)) }
				it { should have_link("1 followers", href: followers_user_path(user)) }
			end
		end
	end

	describe "Help page" do
		before {visit help_path}
		it {should have_content('Help')}
		it {should have_title("Apache design, Inc.")}
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
		it {should have_title("Apache design, Inc.")}
	end

	describe "Contact page" do
		before {visit contact_path}
		it {should have_content('Contact')}
		it {should have_title("Apache design, Inc.")}
	end

end
