module Pages
  class Buttons
    include PageObject
    button :button_uses, xpath: "//*[@visible=\"true\" and contains(translate(@name,\"BUTTONS\",\"buttons\"), \"buttons\")]"
  end
end