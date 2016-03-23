require 'rails_helper'

RSpec.feature 'User invitations', type: :feature do
  describe 'registrations#new' do
    # RSpec test objects
    let(:user1) { create(:user) }
    let(:admin1) { create(:admin) }

    context 'no users signed in' do
      it 'redirects to index' do
        # Capybara navigation
        visit(new_user_registration_path)
        # Test
        expect(current_path).to eq(root_path)
      end
    end

    context 'non-admin user signed in' do
      it 'redirects to index' do
        # Capybara navigation
        visit(new_user_registration_path)
        # Test
        expect(current_path).to eq(root_path)
      end
    end

    context 'admin user signed in' do
      it 'redirects to index' do
        # Capybara navigation
        visit(new_user_registration_path)
        # Test
        expect(current_path).to eq(root_path)
      end
    end
  end
end
