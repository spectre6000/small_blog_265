require 'rails_helper'

RSpec.feature "Author index page", :type => :feature do

  describe "#index" do

    # RSpec test objects
    let( :admin1 ) { create( :admin ) }
    let!( :author1 ) { create( :author ) }

    context "no author signed in" do

      before( :each ) do
        # Capybara navigation
        visit( 'authors' )
      end

      it "does not give a guest user an invitation link" do
        # Test
        expect( page.body ).to_not have_link( "invite new author" )
      end

      it "does not give a guest user a delete link" do
        # Test
        expect( page.body ).to_not have_link( "delete" )
      end

      it "does not allows a guest user to make other users admins" do
        # Test
        expect( page.body ).to_not have_link( "make admin" )
      end

    end

    context "non-admin author signed in" do

      before ( :each ) do
        # Warden session
        login_as( @author1 )
      end

      it "does not give a non-admin author an invitation link" do
        # Test
        expect( page.body ).to_not have_link( "invite new author" )
      end

      it "does not give a non-admin author a delete link" do
        # Test
        expect( page.body ).to_not have_link( "delete" )
      end

      it "does not allows a non-admin author to make other users admins" do
        # Test
        expect( page.body ).to_not have_link( "make admin" )
      end

    end

    context "admin author signed in" do

      before ( :each ) do
        # Warden session
        login_as( admin1 )
        # Capybara navigation
        visit( 'authors' )
      end

      it "gives admin authors an invitation link" do
        # Test
        expect( page.body ).to have_link( "invite new author" )
      end

      it "gives admin authors a delete link" do
        # Test
        expect( page.body ).to have_link( "delete" )
      end

      it "gives admin authors a make admin link" do
        # Test
        expect( page.find( 'div', :text => "#{ author1.username }" ) ).to have_link( "make admin" )
      end

      it "does not give an Admin a make admin link for themselves" do
        # Test
        expect( page.find( 'div', :text => "#{ admin1.username }" ) ).to_not have_link( "make admin" )
      end

      it "allows an Admin to make other users admins" do
        # Capybara navigation
        page.find( 'div', :text => "#{ author1.username }" ).click_link( 'make admin' )
        # Refresh for test
        author1.reload
        # Test
        expect( author1.admin ).to eq( true )
      end
      
      it "allows an Admin to delete other users" do
        # Test
        expect{ page.find( 'div', :text => "#{ author1.username }" ).click_link( 'delete' ) }.to change( Author, :count ).by( -1 )
      end

      it "does not give an Admin a delete link for themselves" do
        # Test
        expect( page.find( 'div', :text => "#{ admin1.username }" ) ).to_not have_link( "delete" )
      end

      it "does not allow an Admin to delete self manually" do
        # Test
        expect{ page.driver.submit( :delete, "/authors/#{ admin1.id }", {} ) }.to change( Author, :count ).by( 0 )
      end

    end

  end

end