local ui = {
  __idCounter = 0,
  __childs = {},
  __namesList = {},
  modules = {
    Application   = dofile('ui/Core/Application.lua'),
  },
  components = {
    Window = dofile('ui/Components/Window.lua'),
    Container = dofile('ui/Components/Container.lua'),
    Widget = dofile('ui/Components/Widget.lua'),
    Button = dofile('ui/Components/Button.lua')
  }
}

function ui:getID(name)
  local element = self.__namesList[name]
  if element then
     return element
  end
  return false
end

function ui:setID(name)
  if not self.__namesList[name] then
    self.__idCounter = self.__idCounter + 1
    self.__namesList[name] = self.__idCounter
    return self.__namesList[name]
  end
  return false
end

function ui:createApplication(title, x, y, width, height, isFullscreen, resizable, bordeless, centered,  vsync, msaa)
  return self.modules.Application:create(title, x, y, width, height, isFullscreen, resizable, bordeless, centered,  vsync, msaa)
end

function ui:createWindow(name, title, hasBar)
  local whitespaceIndex, _ = string.find(name, " ")
  assert(not self:getID(name), string.format('Element with `%s` name already in use.', name))
  assert(whitespaceIndex == nil, string.format('`%s` is a invalid name format, use underscores instead whitespaces.', name))

  local newID = self:setID(name)
  local newWindow = self.components.Window:create{__id = newID, title = title, name = name, hasBar = hasBar}
  table.insert(self.__childs, newWindow)
  return newWindow
end

function ui:createContainer()
  return self.components.Container:create()
end

function ui:createButton()
  return self.components.Button:create()
end

function ui:draw()
  --Iterate over windows
  local childs = self.__childs
  for _, v in pairs(childs) do
    if v.visible then v:draw() end
  end
end

function ui:update(dt)

end

return ui
