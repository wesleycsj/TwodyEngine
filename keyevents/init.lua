local KeyEvents = {
  _keys = {}
}



function KeyEvents:keypressed(key, scancode, isrepeat)
  --print('pressed: ' .. key)
end

function KeyEvents:keyreleased(key, scancode)
  --print('released: ' .. key)
end

return KeyEvents
