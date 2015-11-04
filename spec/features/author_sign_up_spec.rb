require 'rails_helper'

RSpec.feature "Author invitations", :type => :feature do

  describe "registrations#new" do

    let( :author1 ) { create( :author ) }
    let( :admin1 ) { create( :admin ) }

    context "no authors signed in" do

      it "redirects to index" do
        visit( new_author_registration_path )
        expect( current_path ).to eq( root_path )
      end

    end

    context "non-admin author signed in" do

      it "redirects to index" do
        visit( new_author_registration_path )
        expect( current_path ).to eq( root_path )
      end

    end

    context "admin author signed in" do

      it "redirects to index" do
        visit( new_author_registration_path )
        expect( current_path ).to eq( root_path )
      end

    end

  end

end