class AuthorsController < ApplicationController
  before_action :authenticate_author!, except: [ :index, :show ]

  def index
    @authors = Author.paginate( :page => params[ :page ] )
  end

  def show
    @author = Author.find( params[ :id ] )
  end

end