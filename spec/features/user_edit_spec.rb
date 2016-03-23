 
require 'rails_helper'

RSpec.feature "Editing user profiles", :type => :feature do
  
  describe "#edit" do

    # RSpec test objects
    let( :user1 ) { create( :user ) } 
    let( :user2 ) { create( :user ) } 
    let( :admin1 ) { create( :admin ) } 
    let( :admin2 ) { create( :admin ) } 

    context "No logged in User" do

      it "does not allow non-user to view user edit page" do
        # Capybara navigation
        visit( edit_user_path( user1.id ) )
        # Test
        expect( current_path ).to eq( new_user_session_path )
      end

      it "does not allow non-user to view admin edit page" do
        # Capybara navigation
        visit( edit_user_path( admin1.id ) )
        # Test
        expect( current_path ).to eq( new_user_session_path )
      end

    end

    context "logged in user" do

      before( :each ) do
        # Warden session
        login_as( user1 )
      end

      it "does not allow user to view admin edit page" do
        # Capybara navigation
        visit( edit_user_path( admin1.id ) )
        # Test
        expect( current_path ).to eq( user_path( admin1.id ) )
      end

      it "does not allow user to view other users' edit page" do
        # Capybara navigation
        visit( edit_user_path( user2.id ) )
        # Test
        expect( current_path ).to eq( user_path( user2.id ) )
      end

      it "edits profile image" do
        # Capybara navigation
        visit( edit_user_path( user1.id ) )
        attach_file( 'Profile Image', Rails.root + 'spec/factories/images/test_image2.png' )
        click_button( 'Save' )
        user1.reload
        # Test
        expect( user1.profile_image_file_name ).to eq( 'test_image2.png' )
      end

      it "edits banner image" do
        # Capybara navigation
        visit( edit_user_path( user1.id ) )
        attach_file( 'Banner Image', Rails.root + 'spec/factories/images/test_image2.png' )
        click_button( 'Save' )
        user1.reload
        # Test
        expect( user1.banner_image_file_name ).to eq( 'test_image2.png' )
      end
      
      it "edits bio" do
        # Value for comparison
        new_bio = "this is #{ user1.username }'s new bio"
        # Capybara navigation
        visit( edit_user_path( user1.id ) )
        fill_in( "About #{ user1.username }:", :with => new_bio )
        click_button( 'Save' )
        # Refresh for test
        user1.reload 
        # Test
        expect( user1.bio ).to eq( new_bio )
      end

      it "edits location" do
        # Value for comparison
        new_location = "anywhere else"
        # Capybara navigation
        visit( edit_user_path( user1.id ) )
        fill_in( "Location:", :with => new_location )
        click_button( 'Save' )
        # Refresh for test
        user1.reload
        # Test
        expect( user1.location ).to eq( new_location )
      end

    end

    context "logged in admin" do

      before ( :each ) do
        # Warden session
        login_as( admin1 )
      end

      it "does not allow admin to view user edit page" do
        # Capybara navigation
        visit( edit_user_path( user1.id ) )
        # Test
        expect( current_path ).to eq( user_path( user1.id ) )
      end

      it "does not allow admin to view other admins' edit page" do
        # Capybara navigation
        visit( edit_user_path( admin2.id ) )
        # Test
        expect( current_path ).to eq( user_path( admin2.id ) )
      end

      it "edits profile image" do
        # Capybara navigation
        visit( edit_user_path( admin1.id ) )
        attach_file( 'Profile Image', Rails.root + 'spec/factories/images/test_image2.png' )
        click_button( 'Save' )
        admin1.reload
        # Test
        expect( admin1.profile_image_file_name ).to eq( 'test_image2.png' )
      end

      it "edits banner image" do
        # Capybara navigation
        visit( edit_user_path( admin1.id ) )
        attach_file( 'Banner Image', Rails.root + 'spec/factories/images/test_image2.png' )
        click_button( 'Save' )
        admin1.reload
        # Test
        expect( admin1.banner_image_file_name ).to eq( 'test_image2.png' )
      end

      it "edits bio" do
        # Value for comparison
        new_bio = "this is #{ admin1.username }'s new bio"
        # Capybara navigation
        visit( edit_user_path( admin1.id ) )
        fill_in( "About #{ admin1.username }:", :with => new_bio )
        click_button( 'Save' )
        # Refresh for test
        admin1.reload
        # Test
        expect( admin1.bio ).to eq( new_bio )
      end

      it "edits location" do
        # Value for comparison
        new_location = "anywhere else"
        # Capybara navigation
        visit( edit_user_path( admin1.id ) )
        fill_in( "Location:", :with => new_location )
        click_button( 'Save' )
        # Refresh for test
        admin1.reload
        # Test
        expect( admin1.location ).to eq( new_location )
      end

    end

  end

end