require_relative '../pages/buttons_page'

describe 'button pge' do
  t 'button uses is invoked without crashing' do
    buttons_page.button_uses?.must_equal true
  end
end