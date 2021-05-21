local Widget = dofile('ui/Components/Widget.lua')

local Button = {
  __id = 1000,
  __parent = nil,
  __minWidth = 1,
  __minHeight = 1,
  name = '',
  x = 0,
  y = 0,
  width = 90,
  height = 40,
  visible = true,
  label = 'Button',
  textAlign = 'center',
  fontSize = 9,
  borderRadius = 0.09,
  color = {
    border = {1, 1, 1, 1},
    background = {1, 1, 1, 0.25},
    label = {1, 1, 1, 1}
  },
  type = 'button',
  name = 'buttonName'
}

function Button:create(o)
  local newButton = Widget:create(o)

  newButton.color = {
    border = {1, 1, 1, 1},
    background = {1, 1, 1, 0.25},
    label = {1, 1, 1, 1}
  }
  setmetatable(newButton, {__index = self})
  return newButton
end

function Button:draw()
  self:drawBorder()
end

function Button:drawBorder(v)
  if type(self.color.background) == 'table' then
    love.graphics.setColor (self.color.background)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, (self.borderRadius * self.width), (self.borderRadius * self.height))
  end
  if type(self.color.border) == ' table' then
    love.graphics.setColor (self.color.border)
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height, (self.borderRadius * self.width), (self.borderRadius * self.height))
  end
  -- Draw Label
  if type(self.color.label) == 'table' then
    love.graphics.setColor (self.color.label)
    love.graphics.printf(self.label, self.x, self.y + math.ceil(self.height/3.8), self.width, self.textAlign)
  end

  love.graphics.setColor (1,1,1,1)
end

function Button:update(dt)

end

return Button
