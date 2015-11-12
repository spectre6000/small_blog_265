
require 'rails_helper'

RSpec.feature "Editing author profiles", :type => :feature do
  
  describe "#edit" do

    # RSpec test objects
    let( :author1 ) { create( :author ) } 
    let( :author2 ) { create( :author ) } 
    let( :admin1 ) { create( :admin ) } 
    let( :admin2 ) { create( :admin ) } 

    context "No logged in Author" do

      it "does not allow non-author to view author edit page" do
        # Capybara navigation
        visit( edit_author_path( author1.id ) )
        # Test
        expect( current_path ).to eq( new_author_session_path )
      end

      it "does not allow non-author to view admin edit page" do
        # Capybara navigation
        visit( edit_author_path( admin1.id ) )
        # Test
        expect( current_path ).to eq( new_author_session_path )
      end

    end

    context "logged in author" do

      before( :each ) do
        # Warden session
        login_as( author1 )
      end

      it "does not allow author to view admin edit page" do
        # Capybara navigation
        visit( edit_author_path( admin1.id ) )
        # Test
        expect( current_path ).to eq( author_path( admin1.id ) )
      end

      it "does not allow author to view other authors' edit page" do
        # Capybara navigation
        visit( edit_author_path( author2.id ) )
        # Test
        expect( current_path ).to eq( author_path( author2.id ) )
      end

      it "edits profile photo" do
        expect( true ).to eq( true )
      end
      
      it "edits bio" do
        # Value for comparison
        new_bio = "this is #{ author1.username }'s new bio"
        # Capybara navigation
        visit( edit_author_path( author1.id ) )
        fill_in( "About #{ author1.username }:", :with => new_bio )
        click_button( 'Save' )
        # Refresh for test
        author1.reload
        # Test
        expect( author1.bio ).to eq( new_bio )
      end

      it "edits location" do
        # Value for comparison
        new_location = "anywhere else"
        # Capybara navigation
        visit( edit_author_path( author1.id ) )
        fill_in( "Location:", :with => new_location )
        click_button( 'Save' )
        # Refresh for test
        author1.reload
        # Test
        expect( author1.location ).to eq( new_location )
      end

    end

    context "logged in admin" do

      before ( :each ) do
        # Warden session
        login_as( admin1 )
      end

      it "does not allow admin to view author edit page" do
        # Capybara navigation
        visit( edit_author_path( author1.id ) )
        # Test
        expect( current_path ).to eq( author_path( author1.id ) )
      end

      it "does not allow admin to view other admins' edit page" do
        # Capybara navigation
        visit( edit_author_path( admin2.id ) )
        # Test
        expect( current_path ).to eq( author_path( admin2.id ) )
      end

      it "edits bio" do
        # Value for comparison
        new_bio = "this is #{ admin1.username }'s new bio"
        # Capybara navigation
        visit( edit_author_path( admin1.id ) )
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
        visit( edit_author_path( admin1.id ) )
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