require 'rails_helper'

RSpec.feature "Author profile and editing", :type => :feature do

  test_users = [  [ :admin1, :admin ],
                  [ :admin2, :admin],
                  [ :author1, :author ],
                  [ :author2, :author ] ]
  test_users.each{ | name, type | let!( name ) { create( type ) } }
  let!( :extra_authors ) { 15.times { create( :author ) } }

  context "Logged-in Author" do

    describe "can edit own profile" do

      before ( :each ) do
        login_as( author1 )
      end

      it "allows Author to edit own information (bio/location)" do
        # Values for updating
        new_bio = "this is #{ author1.username }'s new bio"
        new_location = "anywhere else"

        visit( "authors/#{ author1.id }" )
        click_link( "About #{ author1.username }:" )
        click_link( "Back to profile" )
        click_link( "Location:" )
        fill_in( "About #{ author1.username }:", :with => new_bio )
        fill_in( "Location:", :with => new_location )
        click_button( 'Save' )
        author1.reload

        page_elements = [ [ "AUTHORS SHOW" ], 
                          [ "index" ],
                          [ "( profile photo )" ],
                          [ "username: #{ author1.username }" ],
                          [ "email: #{ author1.email }" ],
                          [ "About #{ author1.username }: #{ new_bio }" ],
                          [ "Location: #{ new_location }" ] ]
        page_element_test( page_elements )
        expect( author1.bio ).to eq( new_bio )
        expect( author1.location ).to eq( new_location )
      end

    end

  end

  context "Non logged-in Author" do

    describe "can not edit an author's profile" do

      before ( :all ) do
        logout( :author )
      end

      it "does not have links to edit an author's information" do
        visit( "authors/#{ author1.id }" )
        expect( page.body ).not_to have_link( "About #{ author1.username }:" )
        expect( page.body ).not_to have_link( "Location:" )
      end

    end

  end

end