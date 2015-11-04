require 'rails_helper'

RSpec.feature "Author profile page", :type => :feature do

  describe "#show" do

    let( :admin1 ) { create( :admin ) }
    let( :admin2 ) { create( :admin ) }
    let( :author1 ) { create( :author ) }
    let( :author2 ) { create( :author ) }

    context "no author signed in" do

      context "non-admin author page" do

        before( :each ) do
          visit( "authors/#{ author1.id }" )
        end

        it "does not show bio edit link" do
          expect( page.body ).to_not have_link( "About #{ author1.username }:" )
        end

        it "does not show location edit link" do
          expect( page.body ).to_not have_link( "Location:" )
        end

      end

      context "admin page" do

        before( :each ) do
          visit( "authors/#{ admin1.id }" )
        end

        it "does not show bio edit link" do
          expect( page.body ).to_not have_link( "About #{ admin1.username }: #{ admin1.bio }" )
        end

        it "does not show location edit link" do
          expect( page.body ).to_not have_link( "Location: #{ admin1.location }" )
        end

      end

    end

    context "non-admin author signed in" do

      before ( :each ) do
        login_as( author1 )
      end

      context "own non-admin page" do

        before( :each ) do
          visit( "authors/#{ author1.id }" )
        end

        it "shows bio edit link" do
          expect( page.body ).to have_link( "About #{ author1.username }:" )
        end

        it "shows location edit link" do
          expect( page.body ).to have_link( "Location:" )
        end

      end

      context "other non-admin athor page" do

        before( :each ) do
          visit( "authors/#{ author2.id }" )
        end

        it "does not show bio edit link" do
          expect( page.body ).to_not have_link( "About #{ author2.username }:" )
        end

        it "does not show location edit link" do
          expect( page.body ).to_not have_link( "Location:" )
        end

      end

      context "admin page" do

        before( :each ) do
          visit( "authors/#{ admin1.id }" )
        end

        it "does not show bio edit link" do
          expect( page.body ).to_not have_link( "About #{ admin1.username }:" )
        end

        it "does not show location edit link" do
          expect( page.body ).to_not have_link( "Location:" )
        end

      end
    end

    context "admin author signed in" do

      before ( :each ) do
        login_as( admin1 )
      end      

      context "non-admin author page" do

        before( :each ) do
          visit( "authors/#{ author1.id }" )
        end

        it "does not show bio edit link" do
          expect( page.body ).to_not have_link( "About #{ author1.username }:" )
        end

        it "does not show location edit link" do
          expect( page.body ).to_not have_link( "Location:" )
        end

      end

      context "other admin athor page" do

        before( :each ) do
          visit( "authors/#{ admin2.id }" )
        end

        it "does not show bio edit link" do
          expect( page.body ).to_not have_link( "About #{ admin2.username }:" )
        end

        it "does not show location edit link" do
          expect( page.body ).to_not have_link( "Location:" )
        end

      end

      context "own admin page" do

        before( :each ) do
          visit( "authors/#{ admin1.id }" )
        end

        it "shows bio edit link" do
          expect( page.body ).to have_link( "About #{ admin1.username }:" )
        end

        it "shows location edit link" do
          expect( page.body ).to have_link( "Location:" )
        end

      end

    end

  end

end