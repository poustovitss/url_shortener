class UrlForm
  include Capybara::DSL

  def leave_url(attrs = {})
    fill_in('url_original_url', with: attrs.fetch(:original_url, 'https://github.com/poustovitss/url_shortener'))
    self
  end

  def submit
    click_on('Shorten')
    self
  end
end
