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

--function Application:create(title, x, y, width, height, fullscreen, resizable, bordeless, centered,  vsync, msaa)
function Application:create(conf)
  -- variables assert
  assert((type(conf.title) == 'string'), 'should provide a string for title')
  assert((type(conf.width) == 'number') and (conf.width > 0), '`width` should be greater than 1')
  assert((type(conf.height) == 'number') and (conf.height > 0), '`height` should be greater than 1')

  Application.TITLE = conf.title
  Application.X = conf.x
  Application.Y = conf.y
  Application.WIDTH = conf.width
  Application.HEIGHT = conf.height

  if type(conf.x) == 'number' or conf.x == nil then Application.X = conf.x end
  if type(conf.y) == 'number' or conf.y == nil then Application.Y = conf.y end
  if conf.fullscreen == true or conf.fullscreen == false then Application.FULLSCREEN = conf.fullscreen end
  if conf.resizable == true or conf.resizable == false then Application.RESIZABLE = conf.resizable end
  if conf.borderless == true or conf.borderless == false then Application.BORDERLESS = conf.borderless end
  if conf.centered == true or conf.centered == false then Application.CENTERED = conf.centered end
  if conf.vsync == 0 or conf.vsync == 1 or conf.vsync == -1 then Application.VSYNC = conf.vsync end
  if conf.msaa == 0 or conf.msaa == 2 or conf.msaa == 4 or conf.msaa == 8 then Application.MSAA = conf.msaa end

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

  love.window.setTitle(conf.title)

  assert((status == true), 'It was no possible to create the application window.')
end

return Application
