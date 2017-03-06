require 'rails_helper'

describe 'UniqueHashGeneratorService' do
  describe 'tries to create model' do
    context 'with valid unique hash' do
      let(:url) { FactoryGirl.create(:url) }
      let(:service) { UniqueHashGeneratorService.new(url) }
      let(:generated_hash) { service.generate_unique_hash }

      it 'generates unique hash' do
        expect(generated_hash).to match(/#{UniqueHashGeneratorService::CHARSET}/)
      end

      it 'sets generated hash to url model field' do
        expect(url.unique_hash).to be_truthy
      end

      it 'checks for model save' do
        expect { service.save_success? }.to change(Url, :count).by(1)
      end

      it 'checks for true value returned from service' do
        expect(service.save_success?).to be true
      end

      it 'creates model' do
        expect(service.try_to_create_model).to be true
      end
    end

    context 'with invalid unique hash' do
      let(:url) { FactoryGirl.create(:url) }
      let(:service) { UniqueHashGeneratorService.new(url) }

      it 'model raise error on save with existed hash value' do
        FactoryGirl.create(:url, unique_hash: 'fX')
        allow(service).to receive(:generate_unique_hash).and_return('fX')
        service.set_generated_hash

        expect { service.save_success? }.to raise_error(ActiveRecord::RecordNotUnique)
      end
    end
  end
end
