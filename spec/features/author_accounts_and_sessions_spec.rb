require 'rails_helper'

RSpec.feature "Authors creation and sessions", :type => :feature do

  context "no users/authors signed in" do

    let( :author1 ) { create( :author ) }

    # before(:all) do
      # @admin1 = create( :admin )
      # @admin = create( :admin )
      # @author1 = create( :author )
      # @author2 = create( :author )
      # before { built_authors = build_list( :author, 5 ) }
    # end

    scenario "Authors index page" do
      author1
      visit 'authors'
      expect( page ).to have_content "All authors"
      expect( page ).to have_content "profile"
      expect( page ).to have_content author1.username
    end
  end

end