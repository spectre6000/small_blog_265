require 'rails_helper'

RSpec.feature "Author creation and sessions", :type => :feature do

  # describe "Author accounts and sessions" do

    test_users = [  [ :admin1, :admin ], 
                    [ :admin2, :admin], 
                    [ :author1, :author ], 
                    [ :author2, :author ] ]
    test_users.each{ | name, type | let!( name ) { create( type ) } }
    let!( :extra_authors ) { 15.times { create( :author ) } }

    context "no authors signed in" do

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
                          [ "About #{ admin1.username }: #{ admin1.bio }" ],
                          [ "Location: #{ admin1.location }" ] ]
        page_element_test( page_elements )
      end
    end

    context "non-admin author signed in" do

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
                          [ "About #{ admin1.username }: #{ admin1.bio }" ],
                          [ "Location: #{ admin1.location }" ] ]
        page_element_test( page_elements )
      end
    end

    context "admin author signed in" do

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
                          [ "About #{ admin1.username }: #{ admin1.bio }" ],
                          [ "Location: #{ admin1.location }" ] ]
        page_element_test( page_elements )
      end

      it "allows an Admin to delete other users" do
        counted_authors = author_count
        page.find( 'div', :text => "#{ author1.username }" ).click_link( 'delete' )
        expect( Author.all.count ).to eq( counted_authors - 1 )
      end

      it "does not giv the Admin the option to delete themselves" do
        paginate( 'div', "#{ admin1.username }" )
        expect( page.find( 'div', :text => "#{ admin1.username }" ) ).to have_link( "delete", count: 0 )
      end

      it "does not allow an Admin to delete self even if the link is somehow present" do
        counted_authors = author_count
        paginate( 'div', "#{ admin1.username }" )
        if page.find( 'div', :text => "#{ admin1.username }" ).has_link?( 'delete' )
          page.find( 'div', :text => "#{ admin1.username }" ).click_link( 'delete' )
          expect( author_count ).to eq( counted_authors )
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

    describe "admin author can invite new users" do

      before ( :each ) do
        login_as( admin1 )
        visit( 'authors' )
      end

      after ( :each ) do
        reset_email
      end

      it "sends invitation email" do
        click_link( 'invite new author' )
        fill_in( "Email", :with => "emailtest@example.com" )
        click_button( "Send an invitation" )
        expect( current_path).to eq( '/' )
        expect( last_email ).to have_content( "emailtest@example.com" )
      end

      it "creates unconfirmed new user" do
        counted_authors = author_count
        click_link( 'invite new author' )
        fill_in( "Email", :with => "emailtest@example.com" )
        click_button( "Send an invitation" )
        expect( author_count ).to eq( counted_authors + 1 )
        # balance of this interaction tested within devise_invitable 
        # @ https://github.com/scambra/devise_invitable/blob/master/test/integration/invitation_test.rb
      end

    end

  # end

end