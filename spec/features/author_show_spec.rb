require 'rails_helper'

RSpec.feature "Author profile page", :type => :feature do

  describe "#show" do

    # RSpec test objects
    let( :admin1 ) { create( :admin ) }
    let( :admin2 ) { create( :admin ) }
    let( :author1 ) { create( :author ) }
    let( :author2 ) { create( :author ) }

    context "no author signed in" do

      context "non-admin author page" do

        it "does not show edit link" do
          # Capybara navigation
          visit( "authors/#{ author1.id }" )
          # Test
          expect( page.body ).to_not have_link( "Edit" )
        end

      end

      context "admin page" do

        it "does not show edit link" do
          # Capybara navigation
          visit( "authors/#{ admin1.id }" )
          # Test
          expect( page.body ).to_not have_link( "Edit" )
        end

      end

    end

    context "non-admin author signed in" do

      before ( :each ) do
        # Warden session
        login_as( author1 )
      end

      context "own non-admin page" do

        it "shows edit link" do
          # Capybara navigation
          visit( "authors/#{ author1.id }" )
          # Test
          expect( page.body ).to have_link( "Edit" )
        end

      end

      context "other non-admin athor page" do

        it "does not show edit link" do
          # Capybara navigation
          visit( "authors/#{ author2.id }" )
          # Test
          expect( page.body ).to_not have_link( "Edit" )
        end

      end

      context "admin page" do

        it "does not show edit link" do
          # Capybara navigation
          visit( "authors/#{ admin1.id }" )
          # Test
          expect( page.body ).to_not have_link( "Edit" )
        end

      end
    end

    context "admin author signed in" do

      before ( :each ) do
        # Warden session
        login_as( admin1 )
      end      

      context "non-admin author page" do

        it "does not show edit link" do
          # Capybara navigation
          visit( "authors/#{ author1.id }" )
          # Test
          expect( page.body ).to_not have_link( "Edit" )
        end

      end

      context "other admin athor page" do

        it "does not show edit link" do
          # Capybara navigation
          visit( "authors/#{ admin2.id }" )
          # Test
          expect( page.body ).to_not have_link( "Edit" )
        end

      end

      context "own admin page" do

        it "shows edit link" do
          # Capybara navigation
          visit( "authors/#{ admin1.id }" )
          # Test
          expect( page.body ).to have_link( "Edit" )
        end

      end

    end

  end

end