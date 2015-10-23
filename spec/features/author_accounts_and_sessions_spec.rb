require 'rails_helper'

RSpec.feature "Author creation and sessions", :type => :feature do

    def paginate( selector, text )
      if !page.has_css?( selector, :text => text )
        if page.has_css?( '.previous_page.disabled' )
          page.find( '.next_page' ).click
        else
          page.find( '.previous_page' ).click
        end
      end
    end

    def page_element_test( element_array )
      element_array.each{ | element, count | expect( page ).to have_content( element, count ) }
    end

  describe "Author accounts and sessions" do

    test_users = [  [ :admin1, :admin ], 
                    [ :admin2, :admin], 
                    [ :author1, :author ], 
                    [ :author2, :author ] ]
    test_users.each{ | name, type | let!( name ) { create( type ) } }
    let!( :extra_authors ) { 15.times { create( :author ) } }

    describe "no authors signed in" do

      before ( :all ) do
        logout( :author )
      end

      it "properly displays the Authors index page" do
        visit( 'authors' )
        page_elements = [ [ "All authors" ],
                          [ "sign in" ],
                          [ author1.username ],
                          [ author2.username ],
                          [ admin1.username ],
                          [ admin2.username ],
                          [ author1.email ],
                          [ author2.email ],
                          [ admin1.email ],
                          [ admin2.email ],
                          [ "profile image", count: 10 ],
                          [ "banner image", count: 10 ],
                          [ "delete", count: 0 ],
                          [ "make admin", count: 0 ] ]
        page_element_test( page_elements )
      end

      it "properly displays the Author show page" do
        visit( "authors/#{ admin1.id }" )
        page_elements = [ [ "AUTHORS SHOW" ],
                          [ "index" ],
                          [ "( profile photo )" ],
                          [ "username: #{ admin1.username }" ],
                          [ "email: #{ admin1.email }" ],
                          [ "bio: #{ admin1.bio }" ],
                          [ "location: #{ admin1.location }" ] ]
        page_element_test( page_elements )
      end
    end

    describe "non-admin author signed in" do

      before ( :each ) do
        login_as( author1 )
      end

      it "properly displays the Authors index page" do
        visit( 'authors' )
        page_elements = [ [ "All authors" ],
                          [ "sign out" ],
                          # authors paginated plus the index title
                          [ "author", count: 11 ],
                          [ "@example.com", count: 10 ],
                          [ "profile image", count: 10 ],
                          [ "banner image", count: 10 ],
                          [ "delete", count: 0 ],
                          [ "make admin", count: 0 ] ]
        page_element_test( page_elements )
      end

      it "properly displays the Author show page" do
        visit( "authors/#{ admin1.id }" )
        page_elements = [ [ "AUTHORS SHOW" ],
                          [ "index" ],
                          [ "( profile photo )" ],
                          [ "username: #{ admin1.username }" ],
                          [ "email: #{ admin1.email }" ],
                          [ "bio: #{ admin1.bio }" ],
                          [ "location: #{ admin1.location }" ] ]
        page_element_test( page_elements )
      end
    end

    describe "admin author signed in" do

      before ( :each ) do
        login_as( admin1 )
        visit( 'authors' )
      end

      it "properly displays the Admin index page" do
        page_elements = [ [ "All authors" ],
                          [ "sign out" ],
                          [ "invite new author" ],
                          # authors paginated plus the index title plus "invite new author" link
                          [ "author", count: 12 ],
                          [ "@example.com", count: 10 ],
                          [ "profile image", count: 10 ],
                          [ "banner image", count: 10 ],
                          [ "delete", count: 10 ],
                          [ "make admin", count: 10 ] ]
        page_element_test( page_elements )
      end

      it "properly displays the Admin show page" do
        visit( "authors/#{ admin1.id }" )
        page_elements = [ [ "AUTHORS SHOW" ], 
                          [ "index" ],
                          [ "( profile photo )" ],
                          [ "username: #{ admin1.username }" ],
                          [ "email: #{ admin1.email }" ],
                          [ "bio: #{ admin1.bio }" ],
                          [ "location: #{ admin1.location }" ] ]
        page_element_test( page_elements )
      end

      it "allows an Admin to delete other users" do
        author_count = ( Author.all.count )
        page.find( 'div', :text => "#{ author1.username }" ).click_link( 'delete' )
        expect( Author.all.count ).to eq( author_count - 1 )
      end

      it "does not giv the Admin the option to delete themselves" do
        paginate( 'div', "#{ admin1.username }" )
        expect( page.find( 'div', :text => "#{ admin1.username }" ) ).to have_link( "delete", count: 0 )
      end

      it "does not allow an Admin to delete self even if the link is somehow present" do
        author_count = ( Author.all.count )
        paginate( 'div', "#{ admin1.username }" )
        if page.find( 'div', :text => "#{ admin1.username }" ).has_link?( 'delete' )
          page.find( 'div', :text => "#{ admin1.username }" ).click_link( 'delete' )
          expect( Author.all.count ).to eq( author_count )
        end
      end

      it "displays the correct content on the invite new users page" do
        page.find( 'span', :text => "invite new author" ).click_link( 'invite new author' )
        page_elements = [ [ "Send invitation" ],
                          [ "Email" ] ]
        page_element_test( page_elements )
        expect( page ).to have_button( "Send an invitation" )
      end

    end

  end

end