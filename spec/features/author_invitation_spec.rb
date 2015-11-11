require 'rails_helper'

RSpec.feature "Author invitations", :type => :feature do

  describe "invitiations#new" do

    # RSpec test objects
    let( :author1 ) { create( :author ) }
    let( :admin1 ) { create( :admin ) }

    context "no authors signed in" do

      it "redirects to index" do
        # Capybara navigation
        visit( new_author_invitation_path )
        # Test
        expect( current_path ).to eq( new_author_session_path )
      end

    end

    context "non-admin author signed in" do

      before ( :each ) do
        # Warden session
        login_as( author1 )
      end

      it "redirects to index" do
        # Capybara navigation
        visit( new_author_invitation_path )
        # Test
        expect( current_path ).to eq( root_path )
      end

    end

    context "admin author signed in" do

      before ( :each ) do
        # Warden session
        login_as( admin1 )
      end

      it "redirects to index" do
        # Capybara navigation
        visit( new_author_invitation_path )
        # Test
        expect( current_path ).to eq( new_author_invitation_path )
      end

      describe "admin author can invite new users" do

        before( :each ) do
          # Capybara navigation
          visit( new_author_invitation_path )
          # Test
          fill_in( "Email", :with => "emailtest@example.com" )
        end

        it "sends invitation email" do
          # Capybara navigation
          click_button( "Send an invitation" )
          # Test
          expect( last_email ).to have_content( "emailtest@example.com" )
        end

        it "redirects to root after sending invitation" do
          # Capybara navigation
          click_button( "Send an invitation" )
          # Test
          expect( current_path ).to eq( '/' )
        end

        it "creates unconfirmed new user" do
          # Test
          expect{ click_button( "Send an invitation" ) }.to change( Author, :count ).by( 1 )
        end

      end

    end

  end

end