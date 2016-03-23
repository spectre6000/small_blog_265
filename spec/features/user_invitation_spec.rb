require 'rails_helper'

RSpec.feature 'User invitations', type: :feature do
  describe 'invitiations#new' do
    # RSpec test objects
    let(:user1) { create(:user) }
    let(:admin1) { create(:admin) }

    context 'no users signed in' do
      it 'redirects to index' do
        # Capybara navigation
        visit(new_user_invitation_path)
        # Test
        expect(current_path).to eq(new_user_session_path)
      end
    end

    context 'non-admin user signed in' do
      before ( :each) do
        # Warden session
        login_as(user1)
      end

      it 'redirects to index' do
        # Capybara navigation
        visit(new_user_invitation_path)
        # Test
        expect(current_path).to eq(root_path)
      end
    end

    context 'admin user signed in' do
      before ( :each) do
        # Warden session
        login_as(admin1)
      end

      it 'redirects to index' do
        # Capybara navigation
        visit(new_user_invitation_path)
        # Test
        expect(current_path).to eq(new_user_invitation_path)
      end

      describe 'admin user can invite new users' do
        before(:each) do
          # Capybara navigation
          visit(new_user_invitation_path)
          # Test
          fill_in('Email', with: 'emailtest@example.com')
        end

        it 'sends invitation email' do
          # Capybara navigation
          click_button('Send an invitation')
          # Test
          expect(last_email).to have_content('emailtest@example.com')
        end

        it 'redirects to root after sending invitation' do
          # Capybara navigation
          click_button('Send an invitation')
          # Test
          expect(current_path).to eq('/')
        end

        it 'creates unconfirmed new user' do
          # Test
          expect { click_button('Send an invitation') }.to change(User, :count).by(1)
        end
      end
    end
  end
end
