require_relative '../pages/buttons'

describe 'buttons' do
  t 'button exists and is displayed' do
    buttons.goto

    # verify existence using page_object gem's element? method
    buttons.round_button?.must_equal true
  end
end