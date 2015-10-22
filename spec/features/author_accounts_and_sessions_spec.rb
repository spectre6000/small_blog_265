require 'rails_helper'

RSpec.feature "Authors creation and sessions", :type => :feature do

  describe "Author accounts and sessions" do

    let!( :admin1 ) { create( :admin ) }
    let!( :admin2 ) { create( :admin ) }
    let!( :author1 ) { create( :author ) }
    let!( :author2 ) { create( :author ) }
    let!( :extra_authors ) { 15.times { create( :author ) } }

    context "no authors signed in" do

      scenario "Authors index page" do
        logout( :author )
        visit 'authors'
        expect( page ).to have_content "All authors"
        expect( page ).to have_content "sign in"
        expect( page ).to have_content author1.username
        expect( page ).to have_content author2.username
        expect( page ).to have_content admin1.username
        expect( page ).to have_content admin2.username
        expect( page ).to have_content author1.email
        expect( page ).to have_content author2.email
        expect( page ).to have_content admin1.email
        expect( page ).to have_content admin2.email
        expect( page ).to have_content "profile image", count: 10
        expect( page ).to have_content "banner image", count: 10
      end

      scenario "Author show page" do
        visit "authors/#{ admin1.id }"
        expect( page ).to have_content "AUTHORS SHOW"
        expect( page ).to have_content "index"
        expect( page ).to have_content "( profile photo )"
        expect( page ).to have_content "username: #{ admin1.username }"
        expect( page ).to have_content "email: #{ admin1.email }"
        expect( page ).to have_content "bio: #{ admin1.bio }"
        expect( page ).to have_content "location: #{ admin1.location }"
      end
    end

    context "non-admin author signed in" do
      scenario "Authors index page" do
        login_as( author1 )
        visit 'authors'
        expect( page ).to have_content "All authors"
        expect( page ).to have_content "sign out"
        # authors paginated plus the index title
        expect( page ).to have_content "author", count: 11
        expect( page ).to have_content "@example.com", count: 10
        expect( page ).to have_content "profile image", count: 10
        expect( page ).to have_content "banner image", count: 10
      end

      scenario "Author show page" do
        visit "authors/#{ admin1.id }"
        expect( page ).to have_content "AUTHORS SHOW"
        expect( page ).to have_content "index"
        expect( page ).to have_content "( profile photo )"
        expect( page ).to have_content "username: #{ admin1.username }"
        expect( page ).to have_content "email: #{ admin1.email }"
        expect( page ).to have_content "bio: #{ admin1.bio }"
        expect( page ).to have_content "location: #{ admin1.location }"
      end
    end

    context "admin author signed in" do
      scenario "Authors index page" do
        login_as( admin1 )
        visit 'authors'
        expect( page ).to have_content "All authors"
        expect( page ).to have_content "sign out"
        expect( page ).to have_content "invite new author"
        # authors paginated plus the index title plus "invite new author" link
        expect( page ).to have_content "author", count: 12
        expect( page ).to have_content "@example.com", count: 10
        expect( page ).to have_content "profile image", count: 10
        expect( page ).to have_content "banner image", count: 10
        expect( page ).to have_content "delete", count: 10
        expect( page ).to have_content "make admin", count: 10
      end

      scenario "Author show page" do
        visit "authors/#{ admin1.id }"
        expect( page ).to have_content "AUTHORS SHOW"
        expect( page ).to have_content "index"
        expect( page ).to have_content "( profile photo )"
        expect( page ).to have_content "username: #{ admin1.username }"
        expect( page ).to have_content "email: #{ admin1.email }"
        expect( page ).to have_content "bio: #{ admin1.bio }"
        expect( page ).to have_content "location: #{ admin1.location }"
      end
    end


  end

end