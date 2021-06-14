local Application = {
  X = nil,
  Y = nil,
  WIDTH = 1,
  HEIGHT = 1,
  FULLSCREEN = false,
  VSYNC = 1,
  MSAA = 0,
  RESIZABLE = false,
  BORDERLESS = false,
  CENTERED = true,
  TITLE = ''
}

function Application:create(title, x, y, width, height, fullscreen, resizable, bordeless, centered,  vsync, msaa)
  -- variables assert
  assert((type(title) == 'string'), 'should provide a string for title')
  assert((width  > 0), '`width` should be greater than 1')
  assert((height > 0), '`height` should be greater than 1')

  Application.TITLE = title
  Application.X = x
  Application.Y = y
  Application.WIDTH = width
  Application.HEIGHT = height

  if type(x) == 'number' or x == nil then Application.X = x end
  if type(y) == 'number' or y == nil then Application.Y = y end
  if fullscreen == true or fullscreen == false then Application.FULLSCREEN = fullscreen end
  if resizable == true or resizable == false then Application.RESIZABLE = resizable end
  if borderless == true or borderless == false then Application.BORDERLESS = borderless end
  if centered == true or centered == false then Application.CENTERED = centered end
  if vsync == 0 or vsync == 1 or vsync == -1 then Application.VSYNC = vsync end
  if msaa == 0 or msaa == 2 or msaa == 4 or msaa == 8 then Application.MSAA = msaa end

  local status = love.window.setMode(Application.WIDTH, Application.HEIGHT, {
    fullscreen = Application.FULLSCREEN,
    fullscreentype = 'desktop',
    vsync = Application.VSYNC,
    msaa = Application.MSAA,
    stencil = true,
    depth = 0,
    resizable = Application.RESIZABLE,
    borderless = Application.BORDERLESS,
    centered  = Application.CENTERED,
    display = 1,
    minwidth = 1,
    minheight = 1,
    x = Application.X,
    y = Application.Y
  })

  love.window.setTitle(title)
  
  assert((status == true), 'It was no possible to create the application window.')
end

return Application
