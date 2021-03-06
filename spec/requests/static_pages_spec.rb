require 'spec_helper'

describe "StaticPages" do

  subject {page}

  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe "home page" do
    before {visit root_path}

    it {should have_content('Sample App')}

    it {should have_selector('title', :text => "#{base_title}")}

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet" )
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
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

    it {should have_selector('title', :text => "#{base_title} | Help")}
	end

  describe "About page" do
    before {visit about_path}

    it {should have_content('About Us')}

    it {should have_selector('title', :text => "#{base_title} | About")}
  end

  describe "Contact page" do
    before {visit contact_path}

    it {should have_selector('h1', :text => 'Contact')}

    it {should have_selector('title', :text => "#{base_title} | Contact") }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector('title', :text => "#{base_title} | About")
    click_link "Help"
    page.should have_selector('title', :text => "#{base_title} | Help")
    click_link "Contact"
    page.should have_selector('title', :text => "#{base_title} | Contact")
    click_link "Home"
    click_link "Sign up now!"
    page.should have_selector('title', :text => "#{base_title} | Sign Up")
  end


end

