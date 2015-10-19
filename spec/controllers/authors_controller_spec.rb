require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    xit "loads all of the posts into @posts" do
      author1, author2 = Author.create!, Author.create!
      get :index

      expect(assigns(:authors)).to match_array([author1, author2])
    end
  end

end
