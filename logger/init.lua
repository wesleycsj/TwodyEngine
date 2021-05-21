Logger = {}

function Logger:print(tag, message)
  assert(type(tag) == 'string', 'Logger::type should be a string')
  assert(type(message) == 'string', 'Logger::type should be a string')
  tag = string.upper(tag)

  if (tag == 'ERROR') or (tag == 'FATAL') or (tag == 'INFO') or (tag == 'WARN') then
    print(tag .. ': ' .. message)
  else
    print('LOG: ' .. message)
  end
end

return Logger
