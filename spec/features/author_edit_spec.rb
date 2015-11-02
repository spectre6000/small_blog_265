require 'rails_helper'

RSpec.feature "Editing author profiles", :type => :feature do
  
  describe "#edit" do

    let( :author1 ) { create( :author ) } 

    context "logged in author" do

      before ( :each ) do
        login_as( author1 )
      end

      it "has bio edit link" do
        # Capybara navigation
        visit( "authors/#{ author1.id }" )
        # Test
        expect( page.body ).to have_link( "About #{ author1.username }:" )
      end

      it "has location edit link" do
        # Capybara navigation
        visit( "authors/#{ author1.id }" )
        # Test
        expect( page.body ).to have_link( "Location:" )
      end

      it "edits bio" do
        # Value for comparison
        new_bio = "this is #{ author1.username }'s new bio"
        # Capybara navigation
        visit( edit_author_path( author1.id ) )
        fill_in( "About #{ author1.username }:", :with => new_bio )
        click_button( 'Save' )
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
        author1.reload
        # Test
        expect( author1.location ).to eq( new_location )
      end

    end

    context "Non logged in Author" do

      before( :each ) do
        # Capybara navigation
        visit( "authors/#{ author1.id }" )
      end

      it "does not have bio edit link" do
        # Test
        expect( page.body ).to_not have_link( "About #{ author1.username }:" )
      end

      it "does not have location edit link" do
        # Test
        expect( page.body ).to_not have_link( "Location:" )
      end

    end

  end

end