local Game = {}

function Game:load()
  self.UI:createApplication('Application', nil, nil, 800 , 600, false, false, true, true, 0)
  local window = self.UI:createWindow('main_window', 'Hello World')
  --local window2 = self.ui:createWindow('secondary_window', 'Hello World')
  window.orientation = 'VERTICAL'

  local mastercontainer = self.UI:createContainer()
  mastercontainer.visible = true
  mastercontainer.width = 800
  mastercontainer.height = 300
  mastercontainer.borderColor = {1,0.5,0.8,1}
  mastercontainer.name = 'master'

  local mastercontainer2 = self.UI:createContainer()
  mastercontainer2.width = 800
  mastercontainer2.height = 300
  mastercontainer2.borderColor = {1,0.5,0.8,1}
  mastercontainer2.name = 'master2'

  local container = self.UI:createContainer()
  container.x = 300
  container.y = 200
  container.width = 30
  container.height = 30
  container.name = 'minorContainer'
  container.borderColor = {1,1,1,1}
  container.visible = true

  local button = self.UI:createButton()
  button.x = 100
  button.y = 100

  local button2 = self.UI:createButton()
  button2.x = 150
  button2.y = 150
  button2.color.background = {0.09, 0.46, 0.82, 1}
  button2.color.label = {1, 1, 1, 1}


  mastercontainer:insert(container)
  mastercontainer:insert(button)
  mastercontainer:insert(button2)
  window:insertContainer(mastercontainer)
  window:insertContainer(mastercontainer2)

  self.graph = self.System:addGraph('top_left', 'FPS: %.2f', true, function ()
    return love.timer.getFPS()
  end)
end

function Game:draw()

end

function Game:update(dt)
  if love.keyboard.isDown('f9') then
    self.graph.active = not self.graph.active
  end
end

function Game:keypressed(key, scancode, isrepeat)
  -- print('pressed '.. key)
end

function Game:keyreleased(key, scancode)
  -- print('released ' .. key)
end

return Game
