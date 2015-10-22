require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do

  describe "#index" do
    it "allows GP to see authors#index page", type: :feature do
      get :index
      expect( response ).to be_success
      expect( response ).to have_http_status( 200 )
      expect( response ).to render_template( "index" )
    end

    it "allows a non-admin author to see authors#index page", type: :feature do
      login_as create( :author )
      get :index
      expect( response ).to render_template( :index )
    end

    it "allows an admin author to see authors#index page w/ admin links" do
      login_as create( :admin )
      get :index
      expect( response ).to render_template( :index )
    end
  end

end