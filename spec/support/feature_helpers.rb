module FeatureHelpers

  def page_element_test( element_array )
    element_array.each{ | element, count | expect( page ).to have_content( element, count ) }
  end

  def author_count
    ( Author.all.count )
  end

  def last_email
    ActionMailer::Base.deliveries.last
  end
  
  def reset_email
    ActionMailer::Base.deliveries = []
  end

  def paginate( selector, text )
    if !page.has_css?( selector, :text => text )
      if page.has_css?( '.previous_page.disabled' )
        page.find( '.next_page' ).click
      else
        page.find( '.previous_page' ).click
      end
    end
  end

end