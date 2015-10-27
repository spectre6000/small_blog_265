class AuthorsController < ApplicationController
  before_action :authenticate_author!, except: [ :index, :show ]

  def index
    @authors = Author.paginate( :page => params[ :page ], :per_page => 10 )
  end

  def show
    @author = Author.find( params[ :id ] )
  end

  def edit
    @author = Author.find( params[ :id ] )
  end

  def update
    @author = Author.find( params[ :id ] )
    if @author.update_attributes( author_params )
      # flash[ :success ] = "Profile updated"
      redirect_to @author
    else
      # flash[ :danger ] = "Profile was not updated"
      render 'edit'
    end
  end

  def destroy
    if Author.find( params[ :id ] ).id != current_author.id 
      Author.find( params[ :id ] ).destroy
      # flash[ :success ] = "Author deleted."
    else
      # flash[ :danger ] = "You can't delete yourself."
    end
    redirect_to authors_url
  end

  private

    def author_params
      params.require( :author ).permit( :bio, :location )
    end

    # Confirms the correct author.
    def correct_author?
      current_author == @author ? true : false ;
      # redirect_to( root_url ) unless current_author?( @author )
    end

    # Confirms an admin author.
    def admin_author
      redirect_to( root_url ) unless current_author.admin?
    end

end