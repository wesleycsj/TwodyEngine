Graphics = {
  _elements = {}
}

function Graphics:draw(drawable, x, y, r, sx, sy, ox, oy, kx, ky)
  table.insert(self._elements, {
    drawable = drawable,
    x = x,
    y = y,
    r = r,
    sx = sx,
    sy = sy,
    ox = ox,
    oy = oy,
    kx = kx,
    ky = ky
  })
end

function Graphics:tick()
  for k,v in pairs(self._elements) do
    local element = k[v]
    love.graphics.draw(element.drawable, element.x, element.y, element.r, element.sx, element.sy, element.ox, element.oy, element.kx, element.ky)
  end
end

return Graphics
