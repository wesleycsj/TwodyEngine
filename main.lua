local twody = require('core')
local utf8 = require("utf8")

function love.load()
  twody:init()

  twody.System:load()

  if type(twody.Game['load']) == 'function' then
    twody.Game:load()
  end
end

function love.draw()
  twody.Game:draw()

  if type(twody.Game.UI['draw']) == 'function' then
    twody.Game.UI:draw()
  end

  if type(twody.System['draw']) == 'function' then
    twody.System:draw()
  end
end

function love.update(dt)
  twody.Game:update(dt)

  if twody.Game.UI then
    twody.Game.UI:update(dt)
  end

  if type(twody.System['update']) == 'function' then
    twody.System:update(dt)
  end
end

function love.keypressed(key, scancode, isrepeat)
  love.graphics.setColor(1,1,1,1)
  if type(twody.KeyEvents['keypressed']) == 'function' then
    twody.KeyEvents:keypressed(key, scancode, isrepeat)
  end

  if type(twody.Game['keypressed']) == 'function' then
    twody.Game:keypressed(key, scancode, isrepeat)
  end
end

function love.keyreleased(key)
  if type(twody.KeyEvents['keypressed']) == 'function' then
    twody.KeyEvents:keyreleased(key, scancode)
  end

  if type(twody.Game['keyreleased']) == 'function' then
    twody.Game:keyreleased(key, scancode)
  end
end

function love.errorhandler(msg)
  msg = tostring(msg)

	if not love.window or not love.graphics or not love.event then
		return
	end

	if not love.graphics.isCreated() or not love.window.isOpen() then
		local success, status = pcall(love.window.setMode, 800, 600)
		if not success or not status then
			return
		end
	end

	-- Reset state.
	if love.mouse then
		love.mouse.setVisible(true)
		love.mouse.setGrabbed(false)
		love.mouse.setRelativeMode(false)
		if love.mouse.isCursorSupported() then
			love.mouse.setCursor()
		end
	end
	if love.joystick then
		-- Stop all joystick vibrations.
		for i,v in ipairs(love.joystick.getJoysticks()) do
			v:setVibration()
		end
	end
	if love.audio then love.audio.stop() end

	love.graphics.reset()
	local font = love.graphics.setNewFont('fonts/monospace.ttf', 16)

	love.graphics.setColor(1, 1, 1, 1)

	local trace = debug.traceback()

	love.graphics.origin()

	local sanitizedmsg = {}
	for char in msg:gmatch(utf8.charpattern) do
		table.insert(sanitizedmsg, char)
	end
	sanitizedmsg = table.concat(sanitizedmsg)

	local err = {}

	table.insert(err, "Error\n")
	table.insert(err, sanitizedmsg)

	if #sanitizedmsg ~= #msg then
		table.insert(err, "Invalid UTF-8 string in error message.")
	end

	table.insert(err, "\n")

	for l in trace:gmatch("(.-)\n") do
		if not l:match("boot.lua") then
			l = l:gsub("stack traceback:", "Traceback\n")
			table.insert(err, l)
		end
	end

	local p = table.concat(err, "\n")

	p = p:gsub("\t", "")
	p = p:gsub("%[string \"(.-)\"%]", "%1")

	local fullErrorText = p
	local function copyToClipboard()
		if not love.system then return end
		love.system.setClipboardText(fullErrorText)
		p = p .. "\nCopied to clipboard!"
	end

	if love.system then
		p = p .. "\n\nPress Ctrl+C or tap to copy this error"
	end

	return function()
		love.event.pump()

		for e, a, b, c in love.event.poll() do
			if e == "quit" then
				return 1
			elseif e == "keypressed" and a == "escape" then
				return 1
			elseif e == "keypressed" and a == "c" and love.keyboard.isDown("lctrl", "rctrl") then
				copyToClipboard()
			elseif e == "touchpressed" then
				local name = love.window.getTitle()
				if #name == 0 or name == "Untitled" then name = "Game" end
				local buttons = {"OK", "Cancel"}
				if love.system then
					buttons[3] = "Copy to clipboard"
				end
				local pressed = love.window.showMessageBox("Quit "..name.."?", "", buttons)
				if pressed == 1 then
					return 1
				elseif pressed == 3 then
					copyToClipboard()
				end
			end
		end

    twody.System:showErrorDialog(p)

		if love.timer then
			love.timer.sleep(0.1)
		end
	end
end
