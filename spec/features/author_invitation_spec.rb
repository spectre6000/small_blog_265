require 'rails_helper'

RSpec.feature "Author invitations", :type => :feature do

  describe "invitiations#new" do

    test_users = [  [ :admin1, :admin ], 
                    [ :admin2, :admin], 
                    [ :author1, :author ], 
                    [ :author2, :author ] ]
    test_users.each{ | name, type | let!( name ) { create( type ) } }
    let!( :extra_authors ) { 15.times { create( :author ) } }

    context "no authors signed in" do

      
    end

    context "non-admin author signed in" do

      
    end

    context "admin author signed in" do

      before ( :each ) do
        login_as( admin1 )
        visit( 'authors' )
      end

      it "displays the correct content on the invite new users page" do
        page.find( 'span', :text => "invite new author" ).click_link( 'invite new author' )
        page_elements = [ [ "Send invitation" ],
                          [ "Email" ] ]
        page_element_test( page_elements )
        expect( page ).to have_button( "Send an invitation" )
      end

    end

    describe "admin author can invite new users" do

      before ( :each ) do
        login_as( admin1 )
        visit( 'authors/invitation/new' )
        fill_in( "Email", :with => "emailtest@example.com" )
      end

      it "sends invitation email" do
        click_button( "Send an invitation" )
        expect( last_email ).to have_content( "emailtest@example.com" )
      end

      it "redirects to root after sending invitation" do
        click_button( "Send an invitation" )
        expect( current_path ).to eq( '/' )
      end

      it "creates unconfirmed new user" do
        expect{ click_button( "Send an invitation" ) }.to change( Author, :count ).by( 1 )
      end

    end

  end

end