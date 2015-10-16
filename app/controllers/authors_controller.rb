class AuthorsController < ApplicationController
  before_action :authenticate_author!

  def index
  end

  def show
    @author = Author.find( params[ :id ] )
  end

end