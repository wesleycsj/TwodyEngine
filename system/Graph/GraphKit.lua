-- Defines the GraphKit
local GraphKit = {
  __childs = {},
  components = {
    Drawable = {
      border =   { top = 0, left = 0, right = 0, bottom = 0 },
      childs = nil,
      height = -1,
      margin =   { top = 0, left = 0, right = 0, bottom = 0 },
      paddings = { top = 0, left = 0, right = 0, bottom = 0 },
      type = 'graph_drawable',
      width = -1,
    }
  }
}

function GraphKit.components.Drawable:new(o)
  local newObject = {} or o

  if type(o.border == nil) then
    newObject.borders = { size = 0, color = {0,0,0,0}}
  end

  if type(o.margins == nil) then
    newObject.margins = { top = 0, left = 0, right = 0, bottom = 0 }
  end

  if type(o.paddings == nil) then
    newObject.paddings = { top = 0, left = 0, right = 0, bottom = 0 }
  end

  setmetatable(newObject, {__index = self})
  return newObject
end

function GraphKit:createGraph(label, active, valueFunction, offset, anchorSize)
  assert(type(label) == 'string', 'Label of graph should be a string')
  assert(type(active) == 'boolean', 'Active argument should be a boolean')
  assert(type(valueFunction) == 'function', 'valueFunction should be a function returning the value.')
  assert(type(valueFunction()) == 'number', 'valueFunction should return a number type.')

  return {
    active = active,
    label = label,
    offset = offset,
    width = (love.graphics.getWidth() / anchorSize),
    height = (love.graphics.getHeight() / anchorSize),
    values = {0},
    samplingLength = 30,
    update = function(g)
              if #g.values > g.samplingLength then
                table.remove(g.values, 1)
              end
              table.insert(g.values, valueFunction())
            end
  }
end


function GraphKit:newPanel(o)
  local newPanel = self.components.Drawable:new(o)
  newPanel.type = 'graph_panel'
  return newPanel
end

function GraphKit:newLabel(o)
  local newLabel = self.components.Drawable:new(o)
  newPanel.type = 'graph_label'
  return newLabel
end

function GraphKit:newValues(o)
  local newValues = self.components.Drawable:new(o)
  newPanel.type = 'graph_values'
  return newValues
end

function GraphKit:addChild(parent, child)
  if type(parent.childs) == nil then
    parent.childs = { child }
  else
    table.insert(parent.childs, child)
  end
end

return GraphKit
