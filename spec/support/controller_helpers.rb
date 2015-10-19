module ControllerHelpers

  def login_with( author = double( 'author' ), scope = :author )
    current_author = "current_#{ scope }".to_sym
    if author.nil?
      allow( request.env[ 'warden' ] ).to receive( :authenticate! ).and_throw( :warden, { :scope => scope } )
      allow( controller ).to receive( current_author ).and_return( nil )
    else
      allow( request.env[ 'warden' ] ).to receive( :authenticate! ).and_return( author )
      allow( controller ).to receive( current_author ).and_return( author )
    end
  end

end