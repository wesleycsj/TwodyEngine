local core = {
  System = require("system"),
  Logger = require("logger"),
  KeyEvents = require("keyevents"),
  UI = require("ui"),
  Graphics = require("graphics"),
  Game = nil
}

function core:init()
  self.System.debugMode = true
  local chunk, err = loadfile('Game.lua')
  if chunk then
    self.Game = chunk()
  else
    error(err)
  end

  assert(self.Game ~= nil, 'Cannot load Game.lua')
  --Dependency Injection
  self.Game.System = self.System
  self.Game.Logger = self.Logger
  self.Game.UI = self.UI
  self.Game.KeyEvents = self.KeyEvents
end


return core
