require 'spec_helper'

describe "StaticPages" do

  subject {page}

  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe "home page" do
    before {visit root_path}

    it {should have_content('Sample App')}

    it {should have_selector('title', :text => "#{base_title}")}
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

