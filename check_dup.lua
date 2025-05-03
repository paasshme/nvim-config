
local mappings = {}

-- Function to collect mappings
local function collect_mappings(mode)
  local cmd = mode .. 'map'
  local output = vim.api.nvim_command_output(cmd)
  for line in output:gmatch("[^\r\n]+") do
    local key, mapping = line:match("(%S+)%s+(.*)")
    if key and mapping then
      if not mappings[key] then
        mappings[key] = {}
      end
      table.insert(mappings[key], mapping)
    end
  end
end

-- Collect mappings for normal mode
collect_mappings('n')

-- Print duplicates
for key, values in pairs(mappings) do
  if #values > 1 then
    print("Duplicate mapping for key: " .. key)
    for _, value in ipairs(values) do
      print("  " .. value)
    end
  end
end
