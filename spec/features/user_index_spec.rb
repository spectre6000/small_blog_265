require 'rails_helper'

RSpec.feature 'User index page', type: :feature do
  describe '#index' do
    let(:admin1) { create(:admin) }
    let!(:user1) { create(:user) }

    context 'no user signed in' do
      before(:each) do
        visit('users')
      end

      it 'does not give a guest user an invitation link' do
        expect(page.body).to_not have_link('invite new user')
      end

      it 'does not give a guest user a delete link' do
        expect(page.body).to_not have_link('delete')
      end

      it 'does not allows a guest user to make other users admins' do
        expect(page.body).to_not have_link('make admin')
      end
    end

    context 'non-admin user signed in' do
      before(:each) do
        login_as(@user1)
      end

      it 'does not give a non-admin user an invitation link' do
        expect(page.body).to_not have_link('invite new user')
      end

      it 'does not give a non-admin user a delete link' do
        expect(page.body).to_not have_link('delete')
      end

      it 'does not allows a non-admin user to make other users admins' do
        expect(page.body).to_not have_link('make admin')
      end
    end

    context 'admin user signed in' do
      before(:each) do
        login_as(admin1)
        visit('users')
      end

      it 'gives admin users an invitation link' do
        expect(page.body).to have_link('invite new user')
      end

      it 'gives admin users a delete link' do
        expect(page.body).to have_link('delete')
      end

      it 'gives admin users a make admin link' do
        expect(
          page.find('div', text: user1.username.to_s)
        ).to have_link('make admin')
      end

      it 'does not give an Admin a make admin link for themselves' do
        expect(
          page.find('div', text: admin1.username.to_s)
        ).to_not have_link('make admin')
      end

      it 'allows an Admin to make other users admins' do
        page.find('div', text: user1.username.to_s).click_link('make admin')
        user1.reload
        expect(user1.admin).to eq(true)
      end

      it 'allows an Admin to delete other users' do
        expect do
          page.find('div', text: user1.username.to_s).click_link('delete')
        end.to change(User, :count).by(-1)
      end

      it 'does not give an Admin a delete link for themselves' do
        expect(
          page.find('div', text: admin1.username.to_s)
        ).to_not have_link('delete')
      end

      it 'does not allow an Admin to delete self manually' do
        expect do
          page.driver.submit(:delete, "/users/#{admin1.id}", {})
        end.to change(User, :count).by(0)
      end
    end
  end
end
