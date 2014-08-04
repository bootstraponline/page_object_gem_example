require_relative '../pages/buttons'

describe 'buttons' do
  t 'button exists and is displayed' do
    buttons.button_uses?.must_equal true
  end
end