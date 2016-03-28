require 'rails_helper'

RSpec.feature 'User invitations', type: :feature do
  describe 'registrations#new' do
    let(:user1) { create(:user) }
    let(:admin1) { create(:admin) }

    context 'no users signed in' do
      it 'redirects to index' do
        visit(new_user_registration_path)
        expect(current_path).to eq(root_path)
      end
    end

    context 'non-admin user signed in' do
      it 'redirects to index' do
        visit(new_user_registration_path)
        expect(current_path).to eq(root_path)
      end
    end

    context 'admin user signed in' do
      it 'redirects to index' do
        visit(new_user_registration_path)
        expect(current_path).to eq(root_path)
      end
    end
  end
end
