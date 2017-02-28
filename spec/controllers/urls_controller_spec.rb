require 'rails_helper'

describe UrlsController do
  let(:url) { FactoryGirl.create(:url) }

  describe 'GET new' do
    it 'routes "/" to the new action' do
      expect(get: '/').to route_to(controller: 'urls', action: 'new')
    end

    it 'renders :new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns new url to template' do
      get :new, params: { url_id: url.id }
      expect(assigns(:url)).to be_a_new(Url)
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new url' do
        expect{
          post :create, params: { url: FactoryGirl.attributes_for(:url) }
        }.to change(Url, :count).by(1)
      end

      it 'redirects to the new url' do

      end
    end

    context 'with invalid attributes' do
      it 'does not save the new url' do

      end

      it 're-renders the new method' do

      end
    end
  end
end