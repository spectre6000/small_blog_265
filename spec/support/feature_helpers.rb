module FeatureHelpers

  # Allows creation of multi-dimenional array of page elements to be iterated through and tested for presence
  def page_element_test( element_array )
    element_array.each{ | element, count | expect( page ).to have_content( element, count ) }
  end

  def last_email
    ActionMailer::Base.deliveries.last
  end
  
  def reset_email
    ActionMailer::Base.deliveries = []
  end

end