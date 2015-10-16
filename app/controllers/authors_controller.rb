class AuthorsController < ApplicationController
  before_action :authenticate_author!

  def index
  end

  def show
  end

end