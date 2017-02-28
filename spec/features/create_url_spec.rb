require 'rails_helper'
require_relative '../support/url_form'
require_relative '../support/url_page'
require_relative '../support/home_page'

feature 'create url' do
  let(:url) { FactoryGirl.create(:url) }

  let(:url_form)  { UrlForm.new }
  let(:home_page) { HomePage.new }
  let(:url_page)  { UrlPage.new }

  scenario 'random user creates url' do
    home_page.visit_page

    url_form.leave_url(original_url: 'http://blablabla.com/hello').submit

    expect(page).to have_content('Your link has been shortened')
  end
end
