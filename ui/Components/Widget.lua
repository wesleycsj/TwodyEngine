local Widget = {
  __id = 1000,
  __parent = nil,
  __minWidth = 1,
  __minHeight = 1,
  name = '',
  x = 0,
  y = 0,
  width = 0,
  height = 0,
  visible = true,
  type = 'widget'
}

function Widget:create(o)
  local o = o or {}
  setmetatable(o, {__index = self})
  self.__id = self.__id + 1
  o.__id = self.__id
  return o
end

return Widget
