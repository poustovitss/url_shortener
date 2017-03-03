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
    context 'with valid data' do
      let(:url_params) { FactoryGirl.attributes_for(:url) }

      it 'redirects to created url path' do
        post :create, params: { url: url_params }
        expect(response).to redirect_to(url_path(Url.last.unique_hash))
      end

      it 'creates a new url' do
        expect{
          post :create, params: { url: url_params }
        }.to change(Url, :count).by(1)
      end

      it 'assigns flash message' do
        post :create, params: { url: url_params }
        expect(flash[:notice]).to eq('Url was successfully shortened!')
      end
    end

    context 'with invalid data' do
      let(:invalid_params) { FactoryGirl.attributes_for(:url, original_url: nil) }

      it 're-renders new template' do
        post :create, params: { url: invalid_params }
        expect(response).to render_template(:new)
      end

      it 'does not save the new url' do
        expect{
          post :create, params: { url: invalid_params }
        }.to change(Url, :count).by(0)
      end

    end
  end

  describe 'GET shortened url' do
    let(:url) { FactoryGirl.create(:url) }

    it 'renders template' do
      get :shortened, params: { unique_hash: url.unique_hash }

      expect(response).to redirect_to(url.original_url)
    end

    it 'assigns the requested url to @url' do
      get :shortened, params: { unique_hash: url.unique_hash }
      expect(assigns(:url)).to eq(url)
    end
  end
end
