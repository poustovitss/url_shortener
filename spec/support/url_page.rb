class UrlPage
  include Capybara::DSL

  def visit_url_page(url)
    visit("/url/#{url.hash}")
    self
  end
end
