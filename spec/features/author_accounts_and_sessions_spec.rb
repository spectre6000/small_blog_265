require 'rails_helper'

RSpec.feature "Authors creation and sessions", :type => :feature do

  context "no users/authors signed in" do

    let!( :admin1 ) { create( :admin ) }
    let!( :admin2 ) { create( :admin ) }
    let!( :author1 ) { create( :author ) }
    let!( :author2 ) { create( :author ) }
    let!( :extra_authors ) { 15.times do  create( :author ) end }

    scenario "Authors index page" do
      visit 'authors'
      expect( page ).to have_content "All authors"
      expect( page ).to have_content "profile"
      expect( page ).to have_content author1.username
      expect( page ).to have_content author2.username
      expect( page ).to have_content admin1.username
      expect( page ).to have_content admin2.username
      expect( page ).to have_content author1.email
      expect( page ).to have_content author2.email
      expect( page ).to have_content admin1.email
      expect( page ).to have_content admin2.email
      expect( page ).to have_content( "author profile image", count: 10 )
      expect( page ).to have_content( "author banner image", count: 10 )
    end
  end

end