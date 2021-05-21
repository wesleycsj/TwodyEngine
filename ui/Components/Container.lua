local Container = {
  __id = 100,
  __childs = {},
  __parent = nil,
  __minWidth = 1,
  __minHeight = 1,
  name = '',
  x = 0,
  y = 0,
  width = 0,
  height = 0,
  visible = true,
  type = 'container',
  --temporary
  borderColor = {0,0,0,0},
  direction = 'HORIZONTAL'
}

function Container:create(o)
  local o = o or {}
  o.__childs = {}
  setmetatable(o, {__index = self})
  self.__id = self.__id + 1
  o.__id = self.__id
  return o
end

function Container:draw()
  local WINDOW_WIDTH = love.graphics.getWidth()
  local WINDOW_HEIGHT = love.graphics.getHeight()
  if self.visible and (self.x < WINDOW_WIDTH) and (self.y < WINDOW_HEIGHT) then
    self:drawSelf()
    if #self.__childs > 0 then
      self:drawChilds()
    end
  end
end

function Container:drawSelf()
  if type(self.borderColor) == 'table' then
    love.graphics.setColor(self.borderColor)
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    love.graphics.setColor(1,1,1,1)
  end
end

function Container:drawChilds()
  --REFACT!
  for k,v in ipairs(self.__childs) do
    v:draw()
  end
end

function Container:insert(c)
  assert((c.type == 'container' or c.type == 'widget' or c.type == 'button'), 'Can not insert a ' .. c.type .. ' as child of container')
  c.__parent = self
  table.insert(self.__childs, c)
end

function Container:update(dt)

end

return Container
