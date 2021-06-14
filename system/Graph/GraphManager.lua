local GraphManager = {
  __GRAPHS = {},
  anchorSize = 3,
  margin = { top = 0, left = 0, right = 0, bottom = 0 },
  paddings = { top = 0, left = 0, right = 0, bottom = 0 },
  borders = { top = 0, left = 0, right = 0, bottom = 0 },
  width = 0,
  height = 0
}

function GraphManager:draw()
  for g in ipairs(self.__GRAPHS) do
    local graph = self.__GRAPHS[g]
    if graph.active then
      -- Outline
      love.graphics.rectangle('line', graph.offset.x, graph.offset.y, graph.width, graph.height)
      -- Background
      love.graphics.setColor(0.3,0.3,0.3,0.8)
      love.graphics.rectangle('fill', graph.offset.x, graph.offset.y, graph.width, graph.height)
      -- Label
      love.graphics.setColor(1,1,1,1)
      love.graphics.print(string.format(graph.label, graph.values[#graph.values]), graph.offset.x, graph.offset.y)
    end
  end
  love.graphics.setColor(1,1,1,1)
end

function GraphManager:addGraph(anchorPosition, label, active, valueFunction)
  assert(type(label) == 'string', 'Label of graph should be a string')
  assert(type(active) == 'boolean', 'Active argument should be a boolean')
  assert(type(valueFunction) == 'function', 'valueFunction should be a function returning the value.')
  assert(type(valueFunction()) == 'number', 'valueFunction should return a number type.')

  local offset = self:calculateAnchor(anchorPosition)
  local graph = {
    active = active,
    label = label,
    offset = offset,
    width = (love.graphics.getWidth() / self.anchorSize),
    height = (love.graphics.getHeight() / self.anchorSize),
    values = {0},
    samplingLength = 30,
    update = function(g)
              if #g.values > g.samplingLength then
                table.remove(g.values, 1)
              end
              table.insert(g.values, valueFunction())
            end
  }

  table.insert(self.__GRAPHS, graph)

  return graph
end

function GraphManager:calculateAnchor(anchorPosition)
  assert(type(archorPosition) ~= 'string', 'AnchorPosition of graph should be a string')

  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()
  local anchorSize = self.anchorSize

  if anchorPosition == 'top_left' then
    return {x = 0, y = 0}
  elseif anchorPosition == 'side_left' then
      return {x = 0, y = (height / anchorSize)}
  elseif anchorPosition == 'bottom_left' then
      return {x = 0, y = (height - height / anchorSize)}
  elseif anchorPosition == 'top_center' then
    return { x = (width / anchorSize), y = 0}
  elseif anchorPosition == 'center' then
    return { x = (width / anchorSize), y = (height / anchorSize)}
  elseif anchorPosition == 'bottom_center' then
    return { x = (width / anchorSize), y = (height - (height / anchorSize))}
  elseif anchorPosition == 'top_right' then
    return { x = (width - (width / anchorSize)), y = 0}
  elseif anchorPosition == 'side_right' then
    return { x = (width - (width / anchorSize)), y = (height / anchorSize)}
  elseif anchorPosition == 'bottom_right' then
    return { x = (width - (width / anchorSize)), y = (height - (height / anchorSize))}
  else
    --error('AnchorPosition value ' .. anchorPosition .. ' is not valid.')
    if anchorPosition == nil then
      print('AnchorPosition value nil is not valid.')
    else
      print('AnchorPosition value ' .. anchorPosition .. ' is not valid.')
    end
    return {x = 0, y = 0}
  end
end

return GraphManager
