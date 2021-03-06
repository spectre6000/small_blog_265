require 'rails_helper'

RSpec.feature 'User profile page', type: :feature do
  describe '#show' do
    let(:admin1) { create(:admin) }
    let(:admin2) { create(:admin) }
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }

    context 'no user signed in' do
      context 'non-admin user page' do
        it 'does not show edit link' do
          visit("users/#{user1.id}")
          expect(page.body).to_not have_link('Edit')
        end
      end

      context 'admin page' do
        it 'does not show edit link' do
          visit("users/#{admin1.id}")
          expect(page.body).to_not have_link('Edit')
        end
      end
    end

    context 'non-admin user signed in' do
      before(:each) do
        login_as(user1)
      end

      context 'own non-admin page' do
        it 'shows edit link' do
          visit("users/#{user1.id}")
          expect(page.body).to have_link('Edit')
        end
      end

      context 'other non-admin user page' do
        it 'does not show edit link' do
          visit("users/#{user2.id}")
          expect(page.body).to_not have_link('Edit')
        end
      end

      context 'admin page' do
        it 'does not show edit link' do
          visit("users/#{admin1.id}")
          expect(page.body).to_not have_link('Edit')
        end
      end
    end

    context 'admin user signed in' do
      before(:each) do
        login_as(admin1)
      end

      context 'non-admin user page' do
        it 'does not show edit link' do
          visit("users/#{user1.id}")
          expect(page.body).to_not have_link('Edit')
        end
      end

      context 'other admin user page' do
        it 'does not show edit link' do
          visit("users/#{admin2.id}")
          expect(page.body).to_not have_link('Edit')
        end
      end

      context 'own admin page' do
        it 'shows edit link' do
          visit("users/#{admin1.id}")
          expect(page.body).to have_link('Edit')
        end
      end
    end
  end
end
