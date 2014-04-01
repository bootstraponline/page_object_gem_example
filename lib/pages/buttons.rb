module Pages
  class Buttons
    include PageObject
      button :round_button, id: 'RoundedTextField'

      def goto
        $driver.name('Buttons, Various uses of UIButton').click
      end
  end
end