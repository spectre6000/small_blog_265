class AuthorsController < ApplicationController
  before_action :authenticate_author!, except: [ :index, :show ]

  def index
    @authors = Author.paginate( :page => params[ :page ], :per_page => 10 )
  end

  def show
    @author = Author.find( params[ :id ] )
  end

  def destroy
    Author.find( params[ :id ] ).destroy
    flash[ :success ] = "Author deleted."
    redirect_to authors_url
  end

end