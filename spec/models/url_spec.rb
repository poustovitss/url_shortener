require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    context 'for original url' do
      it { is_expected.to validate_presence_of :original_url }
      it { should allow_value('http://example.com').for(:original_url) }
      it { should_not allow_value('http://example com').for(:original_url) }
    end
  end
end
