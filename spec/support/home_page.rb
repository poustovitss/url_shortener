class HomePage
  include Capybara::DSL

  def visit_page
    visit('/')
    self
  end
end
