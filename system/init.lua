local System = {
  _os = '',
  _tickrate = 1000,
  _timer = 0,
  debugMode = false,
  modules = {
    Application = dofile('system/Core/Application.lua'),
    GraphManager = nil
  }
}

function System:load()
  self._os = love.system.getOS()
  local chunk, err = loadfile('system/Graph/GraphManager.lua')
  if chunk then
    self.modules.GraphManager = chunk()
  else
    Logger:print('error', 'Graphs module not loaded.')
  end
  -- self:addGraph('top_left', 'FPS: %.2f', true, function ()
  --   return love.timer.getFPS()
  -- end)
  -- self:addGraph('side_left', 'FPS: %.2f', false, function ()
  --   return love.timer.getFPS()
  -- end)
  -- self:addGraph('bottom_left', 'FPS: %.2f', false, function ()
  --   return love.timer.getFPS()
  -- end)
  -- self:addGraph('top_center', 'FPS: %.2f', false, function ()
  --   return love.timer.getFPS()
  -- end)
  self.modules.GraphManager:addGraph('side_left', 'Memory (KB): %.6f', true, function ()
    return collectgarbage('count')
  end)
  self.modules.GraphManager:addGraph('top_left', 'FPS: %.2f', true, function ()
    return love.timer.getFPS()
  end)
  -- self:addGraph('bottom_center', 'FPS: %.2f', false, function ()
  --   return love.timer.getFPS()
  -- end)
  -- self:addGraph('top_right', 'FPS: %.2f', false, function ()
  --   return love.timer.getFPS()
  -- end)
  -- self:addGraph('side_right', 'FPS: %.2f', false, function ()
  --   return love.timer.getFPS()
  -- end)
  -- self:addGraph('bottom_right', 'FPS: %.2f', false, function ()
  --   return love.timer.getFPS()
  -- end)
end

function System:draw()
  if self.modules.GraphManager then
    self.modules.GraphManager:draw()
  end
end

function System:addGraph(anchorPosition, label, active, valueFunction)
  if self.modules.GraphManager then
    return self.modules.GraphManager:addGraph(anchorPosition, label, active, valueFunction)
  else
    Logger:print('error', 'Cannot add graph `' .. label .. '`')
  end

  return nil
end

function System:update(dt)
  if self._timer > (self._tickrate / 1000) then
    local graphs = self.modules.GraphManager.__GRAPHS
    for g in ipairs(graphs) do
      graphs[g]:update(dt)
    end
    self._timer = 0
  else
    self._timer = self._timer + dt
  end
end

function System:createApplication(title, x, y, width, height, isFullscreen, resizable, bordeless, centered,  vsync, msaa)
  return self.modules.Application:create(title, x, y, width, height, isFullscreen, resizable, bordeless, centered,  vsync, msaa)
end

function System:showInfoDialog(title, message)
  return love.window.showMessageBox(title, message, 'info', {"OK", escapebutton = 2}, false)
end

function System:showErrorDialog(message)
  if self.debugMode then
    love.graphics.clear()
    love.graphics.setBackgroundColor(1,1,1,1)
    --love.graphics.setColor(0,0,0,1)
    local twodyLogo = [[ooooooooooooo oooooo   oooooo     oooo   .oooooo.   oooooooooo.   oooooo   oooo
8'   888   `8  `888.    `888.     .8'   d8P'  `Y8b  `888'   `Y8b   `888.   .8'
     888        `888.   .8888.   .8'   888      888  888      888   `888. .8'
     888         `888  .8'`888. .8'    888      888  888      888    `888.8'
     888          `888.8'  `888.8'     888      888  888      888     `888'
     888           `888'    `888'      `88b    d88'  888     d88'      888
    o888o           `8'      `8'        `Y8bood8P'  o888bood8P'       o888o
]]
    love.graphics.print(twodyLogo, 40, 40)

		love.graphics.printf(message, 45, 200, love.graphics.getWidth() - 70)
		love.graphics.present()
  else
    love.window.showMessageBox('Fatal Error', 'Application should close', 'error', {"Close"}, true)
    love.quit()
  end
end

return System
