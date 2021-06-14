-- Defines the GraphKit
local GraphKit = {
  graphs = {},
  components = {
    Drawable = {
      border = nil,
      childs = nil,
      height = -1,
      margin = nil,
      paddings = nil,
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

function GraphKit:draw()
  
end

return GraphKit
