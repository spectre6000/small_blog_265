require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do

  describe "#index" do
    it "allows GP to see authors#index page" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("index")
    end

    it "allows a non-admin author to see authors#index page" do
      login_as create( :author ), scope: :author
      get :index
      expect( response ).to render_template( :index )
      expect( response.body ).to have_content 'author'
    end

    it "allows an admin author to see authors#index page w/ admin links" do
      login_as create( :admin_author ), scope: :author
      get :index
      expect( response ).to render_template( :index )
      expect( response.body ).to have_content 'admin'
    end
  end

end
