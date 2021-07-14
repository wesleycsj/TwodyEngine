local Window = {
  __id = 0,
  __childs = {},
  __hasBar = false,
  __parent = nil,
  title = '',
  name  = '',
  type = 'window',
  input = false,
  resizable = false,
  visible = true,
  direction = 'HORIZONTAL',
}

function Window:create(o)
  local _hasBar = false
  assert((type(o.__id)  == 'number'), '`id` should be a number')
  assert((type(o.title) == 'string'), '`title` should be a string')
  assert((type(o.name)  == 'string'), '`name` should be a string')
  if o.hasBar == true or o.hasBar == false then _hasBar = o.hasBar end

  local o = o or {}
  o.__childs = {}
  setmetatable(o, {__index = self})
  return o
end

function Window:insertContainer(c)
  --temporary
  c.__parent = self
  table.insert(self.__childs, c)
end

function Window:draw(v)

  local childs = self.__childs
  -- Draw Containers
  Window.align(self, childs)
  
  for _,v in pairs(childs) do
    if v.visible then v:draw() end
  end

end

function Window.align(self, childs)
  local x = 0
  local y = 0
  local WINDOW_WIDTH  = love.graphics.getWidth()
  local WINDOW_HEIGHT = love.graphics.getHeight()
  local BIGGEST_XCHILD = 0
  local BIGGEST_YCHILD = 0
  local direction = self.direction

  assert((direction == 'HORIZONTAL' or direction == 'VERTICAL'), string.format('Window flow `%s` not valid.', direction))

  for k,container in pairs(childs) do
    --The childs size are greater or equals than minimal?
    if container.width < container.__minWidth then
      container.width = container.__minWidth
    end

    if container.height < container.__minHeight then
      container.height = container.__minHeight
    end

    --Calculates by position direction
    if direction == 'HORIZONTAL' then
      if container.height > BIGGEST_YCHILD then BIGGEST_YCHILD = container.height end
      if (k > 1) and (x + container.width > WINDOW_WIDTH) then
         x = 0
         y = y + BIGGEST_YCHILD
         BIGGEST_YCHILD = 0
      end
      container.x = x
      container.y = y
      x = x + container.width
    elseif direction == 'VERTICAL' then
      if container.width > BIGGEST_XCHILD then BIGGEST_XCHILD = container.width end
      if (k > 1) and (y + container.height > WINDOW_HEIGHT) then
         x = x + BIGGEST_XCHILD
         y = 0
         BIGGEST_XCHILD = 0
      end
      container.x = x
      container.y = y
      y = y + container.height
    end
  end
end

function Window:update()

end

return Window
