require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do

  # RSpec test objects
  let( :author1 ) { create( :author ) }
  let( :author2 ) { create( :author ) }
  let( :admin1 ) { create( :admin ) } 
  let( :admin2 ) { create( :admin ) }

  describe "#index" do

    context "no author logged in" do

      before ( :each ) do
        # Navigation
        get( :index )
      end
      
      it "returns success" do
        # Test
        expect( response ).to be_success
      end

      it "returns http status 200" do
        # Test
        expect( response ).to have_http_status( 200 )
      end

      it "renders index template" do
        # Test
        expect( response ).to render_template( "index" )
      end

    end

    context "non-admin author logged in" do

      before ( :each ) do
        # Warden session
        sign_in( author1 )
        # Navigation
        get( :index )
      end
      
      it "returns success" do
        # Test
        expect( response ).to be_success
      end

      it "returns http status 200" do
        # Test
        expect( response ).to have_http_status( 200 )
      end

      it "renders index template" do
        # Test
        expect( response ).to render_template( "index" )
      end

    end

    context "admin author logged in" do

      before ( :each ) do
        # Navigation
        get( :index )
        # Warden session
        sign_in( admin1 )
      end
      
      it "returns success" do
        # Test
        expect( response ).to be_success
      end

      it "returns http status 200" do
        # Test
        expect( response ).to have_http_status( 200 )
      end

      it "renders index template" do
        # Test
        expect( response ).to render_template( "index" )
      end

    end

  end

  describe "#show" do

    context "no author logged in" do

      before ( :each ) do
        # Navigation
        get( :show, id: author1.id )
      end
      
      it "returns success" do
        # Test
        expect( response ).to be_success
      end

      it "returns http status 200" do
        # Test
        expect( response ).to have_http_status( 200 )
      end

      it "renders show template" do
        # Test
        expect( response ).to render_template( "show" )
      end

    end

    context "non-admin author logged in" do

      before ( :each ) do
        # Warden session
        sign_in( author1 )
        # Navigation
        get( :show, id: author1.id )
      end
      
      it "returns success" do
        # Test
        expect( response ).to be_success
      end

      it "returns http status 200" do
        # Test
        expect( response ).to have_http_status( 200 )
      end

      it "renders show template" do
        # Test
        expect( response ).to render_template( "show" )
      end

    end

    context "admin author logged in" do

      before ( :each ) do
        # Warden session
        sign_in( admin1 )
        # Navigation
        get( :show, id: author1.id )
      end
      
      it "returns success" do
        # Test
        expect( response ).to be_success
      end

      it "returns http status 200" do
        # Test
        expect( response ).to have_http_status( 200 )
      end

      it "renders show template" do
        # Test
        expect( response ).to render_template( "show" )
      end

    end

  end

  describe "#edit" do

    context "no author logged in" do

      context "non-admin page" do

        before ( :each ) do
          # Navigation
          get( :edit, id: author1.id )
        end
        
        it "redirects" do
          # Test
          expect( response ).to be_redirect
        end

        it "returns http status 302" do
          # Test
          expect( response ).to have_http_status( 302 )
        end

        it "redirects to sign in page" do
          # Test
          expect( response ).to redirect_to( "/authors/sign_in" )
        end

      end

      context "admin page" do

        before ( :each ) do
          # Navigation
          get( :edit, id: admin1.id )
        end
  
        it "redirects" do
          # Test
          expect( response ).to be_redirect
        end        

        it "returns http status 302" do
          # Test
          expect( response ).to have_http_status( 302 )
        end

        it "redirects to sign in page" do
          # Test
          expect( response ).to redirect_to( "/authors/sign_in" )
        end

      end

    end

    context "non-admin author logged in" do

      before ( :each ) do
        # Warden session
        sign_in( author1 )
      end

      context "own page" do

        before ( :each ) do
          # Navigation
          get( :edit, id: author1.id )
        end
        
        it "returns success" do
          # Test
          expect( response ).to be_success
        end

        it "returns http status 200" do
          # Test
          expect( response ).to have_http_status( 200 )
        end

        it "renders index template" do
          # Test
          expect( response ).to render_template( "edit" )
        end

      end

      context "other non-admin author's page" do

        before ( :each ) do
          # Navigation
          get( :edit, id: author2.id )
        end
        
        it "redirects" do
          # Test
          expect( response ).to be_redirect
        end

        it "returns http status 302" do
          # Test
          expect( response ).to have_http_status( 302 )
        end

        it "renders edit template" do
          # Test
          expect( response ).to redirect_to( "/authors/#{ author2.id }" )
        end

      end

      context "admin author's page" do

        before ( :each ) do
          # Navigation
          get( :edit, id: admin1.id )
        end
        
        it "redirects" do
          # Test
          expect( response ).to be_redirect
        end

        it "returns http status 302" do
          # Test
          expect( response ).to have_http_status( 302 )
        end

        it "redirects to other admin author's show page" do
          # Test
          expect( response ).to redirect_to( "/authors/#{ admin1.id }" )
        end

      end

    end

    context "admin author logged in" do

      before ( :each ) do
        # Warden session
        sign_in( admin1 )
      end

      context "own page" do

        before ( :each ) do
          # Navigation
          get( :edit, id: admin1.id )
        end
        
        it "returns success" do
          # Test
          expect( response ).to be_success
        end

        it "returns http status 200" do
          # Test
          expect( response ).to have_http_status( 200 )
        end

        it "renders index template" do
          # Test
          expect( response ).to render_template( "edit" )
        end

      end

      context "other non-admin author's page" do

        before ( :each ) do
          # Navigation
          get( :edit, id: author2.id )
        end
        
        it "redirects" do
          # Test
          expect( response ).to be_redirect
        end

        it "returns http status 302" do
          # Test
          expect( response ).to have_http_status( 302 )
        end

        it "redirects to other admin author's show page" do
          # Test
          expect( response ).to redirect_to( "/authors/#{ author2.id }" )
        end

      end

      context "other admin author's page" do

        before ( :each ) do
          # Navigation
          get( :edit, id: admin2.id )
        end
        
        it "redirects" do
          # Test
          expect( response ).to be_redirect
        end

        it "returns http status 302" do
          # Test
          expect( response ).to have_http_status( 302 )
        end

        it "redirects to other admin author's show page" do
          # Test
          expect( response ).to redirect_to( "/authors/#{ admin2.id }" )
        end

      end

    end

  end

end