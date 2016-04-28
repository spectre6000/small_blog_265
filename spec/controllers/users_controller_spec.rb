require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:admin1) { create(:admin) }
  let(:admin2) { create(:admin) }

  describe '#index' do
    context 'no user logged in' do
      before(:each) do
        get(:index)
      end

      it 'returns success' do
        expect(response).to be_success
      end

      it 'returns http status 200' do
        expect(response).to have_http_status(200)
      end

      it 'renders index template' do
        expect(response).to render_template('index')
      end
    end

    context 'non-admin user logged in' do
      before(:each) do
        sign_in(user1)
        get(:index)
      end

      it 'returns success' do
        expect(response).to be_success
      end

      it 'returns http status 200' do
        expect(response).to have_http_status(200)
      end

      it 'renders index template' do
        expect(response).to render_template('index')
      end
    end

    context 'admin user logged in' do
      before(:each) do
        get(:index)
        sign_in(admin1)
      end

      it 'returns success' do
        expect(response).to be_success
      end

      it 'returns http status 200' do
        expect(response).to have_http_status(200)
      end

      it 'renders index template' do
        expect(response).to render_template('index')
      end
    end
  end

  describe '#show' do
    context 'no user logged in' do
      before(:each) do
        get(:show, id: user1.id)
      end

      it 'returns success' do
        expect(response).to be_success
      end

      it 'returns http status 200' do
        expect(response).to have_http_status(200)
      end

      it 'renders show template' do
        expect(response).to render_template('show')
      end
    end

    context 'non-admin user logged in' do
      before(:each) do
        sign_in(user1)
        get(:show, id: user1.id)
      end

      it 'returns success' do
        expect(response).to be_success
      end

      it 'returns http status 200' do
        expect(response).to have_http_status(200)
      end

      it 'renders show template' do
        expect(response).to render_template('show')
      end
    end

    context 'admin user logged in' do
      before(:each) do
        sign_in(admin1)
        get(:show, id: user1.id)
      end

      it 'returns success' do
        expect(response).to be_success
      end

      it 'returns http status 200' do
        expect(response).to have_http_status(200)
      end

      it 'renders show template' do
        expect(response).to render_template('show')
      end
    end
  end

  describe '#edit' do
    context 'no user logged in' do
      context 'non-admin page' do
        before(:each) do
          get(:edit, id: user1.id)
        end

        it 'redirects' do
          expect(response).to be_redirect
        end

        it 'returns http status 302' do
          expect(response).to have_http_status(302)
        end

        it 'redirects to sign in page' do
          expect(response).to redirect_to('/users/sign_in')
        end
      end

      context 'admin page' do
        before(:each) do
          get(:edit, id: admin1.id)
        end

        it 'redirects' do
          expect(response).to be_redirect
        end

        it 'returns http status 302' do
          expect(response).to have_http_status(302)
        end

        it 'redirects to sign in page' do
          expect(response).to redirect_to('/users/sign_in')
        end
      end
    end

    context 'non-admin user logged in' do
      before(:each) do
        sign_in(user1)
      end

      context 'own page' do
        before(:each) do
          get(:edit, id: user1.id)
        end

        it 'returns success' do
          expect(response).to be_success
        end

        it 'returns http status 200' do
          expect(response).to have_http_status(200)
        end

        it 'renders index template' do
          expect(response).to render_template('edit')
        end
      end

      context "other non-admin user's page" do
        before(:each) do
          get(:edit, id: user2.id)
        end

        it 'redirects' do
          expect(response).to be_redirect
        end

        it 'returns http status 302' do
          expect(response).to have_http_status(302)
        end

        it 'renders edit template' do
          expect(response).to redirect_to("/users/#{user2.id}")
        end
      end

      context "admin user's page" do
        before(:each) do
          get(:edit, id: admin1.id)
        end

        it 'redirects' do
          expect(response).to be_redirect
        end

        it 'returns http status 302' do
          expect(response).to have_http_status(302)
        end

        it "redirects to other admin user's show page" do
          expect(response).to redirect_to("/users/#{admin1.id}")
        end
      end
    end

    context 'admin user logged in' do
      before(:each) do
        sign_in(admin1)
      end

      context 'own page' do
        before(:each) do
          get(:edit, id: admin1.id)
        end

        it 'returns success' do
          expect(response).to be_success
        end

        it 'returns http status 200' do
          expect(response).to have_http_status(200)
        end

        it 'renders index template' do
          expect(response).to render_template('edit')
        end
      end

      context "other non-admin user's page" do
        before(:each) do
          get(:edit, id: user2.id)
        end

        it 'redirects' do
          expect(response).to be_redirect
        end

        it 'returns http status 302' do
          expect(response).to have_http_status(302)
        end

        it "redirects to other admin user's show page" do
          expect(response).to redirect_to("/users/#{user2.id}")
        end
      end

      context "other admin user's page" do
        before(:each) do
          get(:edit, id: admin2.id)
        end

        it 'redirects' do
          expect(response).to be_redirect
        end

        it 'returns http status 302' do
          expect(response).to have_http_status(302)
        end

        it "redirects to other admin user's show page" do
          expect(response).to redirect_to("/users/#{admin2.id}")
        end
      end
    end
  end
end
