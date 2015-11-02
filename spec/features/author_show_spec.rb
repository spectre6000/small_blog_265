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

        it "displays the page title" do
          expect( page.body ).to have_content( "AUTHORS SHOW" )
        end

        it "displays the authors index link" do
          expect( page.body ).to have_link( "index" )
        end

        it "displays the Author profile photo" do
          expect( page.body ).to have_content( "( profile photo )" )
        end

        it "displays the Author banner photo" do
          expect( page.body ).to have_content( "( banner photo )" )
        end

        it "displays the Author username" do
          expect( page.body ).to have_content( "username: #{ author1.username }" )
        end

        it "displays the Author email" do
          expect( page.body ).to have_content( "email: #{ author1.email }" )
        end

        it "displays the Author bio" do
          expect( page.body ).to have_content( "About #{ author1.username }: #{ author1.bio }" )
        end

        it "displays the Author location" do
          expect( page.body ).to have_content( "Location: #{ author1.location }" )
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

        it "displays the page title" do
          expect( page.body ).to have_content( "AUTHORS SHOW" )
        end

        it "displays the authors index link" do
          expect( page.body ).to have_link( "index" )
        end

        it "displays the Author profile photo" do
          expect( page.body ).to have_content( "( profile photo )" )
        end

        it "displays the Author banner photo" do
          expect( page.body ).to have_content( "( banner photo )" )
        end

        it "displays the Author username" do
          expect( page.body ).to have_content( "username: #{ admin1.username }" )
        end

        it "displays the Author email" do
          expect( page.body ).to have_content( "email: #{ admin1.email }" )
        end

        it "displays the Author bio" do
          expect( page.body ).to have_content( "About #{ admin1.username }: #{ admin1.bio }" )
        end

        it "displays the Author location" do
          expect( page.body ).to have_content( "Location: #{ admin1.location }" )
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

        it "displays the page title" do
          expect( page.body ).to have_content( "AUTHORS SHOW" )
        end

        it "displays the authors index link" do
          expect( page.body ).to have_link( "index" )
        end

        it "displays the Author profile photo" do
          expect( page.body ).to have_content( "( profile photo )" )
        end

        it "displays the Author banner photo" do
          expect( page.body ).to have_content( "( banner photo )" )
        end

        it "displays the Author username" do
          expect( page.body ).to have_content( "username: #{ author1.username }" )
        end

        it "displays the Author email" do
          expect( page.body ).to have_content( "email: #{ author1.email }" )
        end

        it "displays the Author bio" do
          expect( page.body ).to have_content( "About #{ author1.username }: #{ author1.bio }" )
        end

        it "displays the Author location" do
          expect( page.body ).to have_content( "Location: #{ author1.location }" )
        end

        it "does not show bio edit link" do
          expect( page.body ).to have_link( "About #{ author1.username }:" )
        end

        it "does not show location edit link" do
          expect( page.body ).to have_link( "Location:" )
        end

      end

      context "other non-admin athor page" do

        before( :each ) do
          visit( "authors/#{ author2.id }" )
        end

        it "displays the page title" do
          expect( page.body ).to have_content( "AUTHORS SHOW" )
        end

        it "displays the authors index link" do
          expect( page.body ).to have_link( "index" )
        end

        it "displays the Author profile photo" do
          expect( page.body ).to have_content( "( profile photo )" )
        end

        it "displays the Author banner photo" do
          expect( page.body ).to have_content( "( banner photo )" )
        end

        it "displays the Author username" do
          expect( page.body ).to have_content( "username: #{ author2.username }" )
        end

        it "displays the Author email" do
          expect( page.body ).to have_content( "email: #{ author2.email }" )
        end

        it "displays the Author bio" do
          expect( page.body ).to have_content( "About #{ author2.username }: #{ author2.bio }" )
        end

        it "displays the Author location" do
          expect( page.body ).to have_content( "Location: #{ author2.location }" )
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

        it "displays the page title" do
          expect( page.body ).to have_content( "AUTHORS SHOW" )
        end

        it "displays the authors index link" do
          expect( page.body ).to have_link( "index" )
        end

        it "displays the Author profile photo" do
          expect( page.body ).to have_content( "( profile photo )" )
        end

        it "displays the Author banner photo" do
          expect( page.body ).to have_content( "( banner photo )" )
        end

        it "displays the Author username" do
          expect( page.body ).to have_content( "username: #{ admin1.username }" )
        end

        it "displays the Author email" do
          expect( page.body ).to have_content( "email: #{ admin1.email }" )
        end

        it "displays the Author bio" do
          expect( page.body ).to have_content( "About #{ admin1.username }: #{ admin1.bio }" )
        end

        it "displays the Author location" do
          expect( page.body ).to have_content( "Location: #{ admin1.location }" )
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

        it "displays the page title" do
          expect( page.body ).to have_content( "AUTHORS SHOW" )
        end

        it "displays the authors index link" do
          expect( page.body ).to have_link( "index" )
        end

        it "displays the Author profile photo" do
          expect( page.body ).to have_content( "( profile photo )" )
        end

        it "displays the Author banner photo" do
          expect( page.body ).to have_content( "( banner photo )" )
        end

        it "displays the Author username" do
          expect( page.body ).to have_content( "username: #{ author1.username }" )
        end

        it "displays the Author email" do
          expect( page.body ).to have_content( "email: #{ author1.email }" )
        end

        it "displays the Author bio" do
          expect( page.body ).to have_content( "About #{ author1.username }: #{ author1.bio }" )
        end

        it "displays the Author location" do
          expect( page.body ).to have_content( "Location: #{ author1.location }" )
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

        it "displays the page title" do
          expect( page.body ).to have_content( "AUTHORS SHOW" )
        end

        it "displays the authors index link" do
          expect( page.body ).to have_link( "index" )
        end

        it "displays the Author profile photo" do
          expect( page.body ).to have_content( "( profile photo )" )
        end

        it "displays the Author banner photo" do
          expect( page.body ).to have_content( "( banner photo )" )
        end

        it "displays the Author username" do
          expect( page.body ).to have_content( "username: #{ admin2.username }" )
        end

        it "displays the Author email" do
          expect( page.body ).to have_content( "email: #{ admin2.email }" )
        end

        it "displays the Author bio" do
          expect( page.body ).to have_content( "About #{ admin2.username }: #{ admin2.bio }" )
        end

        it "displays the Author location" do
          expect( page.body ).to have_content( "Location: #{ admin2.location }" )
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

        it "displays the page title" do
          expect( page.body ).to have_content( "AUTHORS SHOW" )
        end

        it "displays the authors index link" do
          expect( page.body ).to have_link( "index" )
        end

        it "displays the Author profile photo" do
          expect( page.body ).to have_content( "( profile photo )" )
        end

        it "displays the Author banner photo" do
          expect( page.body ).to have_content( "( banner photo )" )
        end

        it "displays the Author username" do
          expect( page.body ).to have_content( "username: #{ admin1.username }" )
        end

        it "displays the Author email" do
          expect( page.body ).to have_content( "email: #{ admin1.email }" )
        end

        it "displays the Author bio" do
          expect( page.body ).to have_content( "About #{ admin1.username }: #{ admin1.bio }" )
        end

        it "displays the Author location" do
          expect( page.body ).to have_content( "Location: #{ admin1.location }" )
        end

        it "does not show bio edit link" do
          expect( page.body ).to have_link( "About #{ admin1.username }:" )
        end

        it "does not show location edit link" do
          expect( page.body ).to have_link( "Location:" )
        end

      end

    end

  end

end