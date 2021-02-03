local utils = {}

function utils.tbl_apply_defaults(original, defaults)
  if original == nil then
    original = {}
  end

  original = vim.deepcopy(original)

  for k, v in pairs(defaults) do
    if original[k] == nil then
      original[k] = v
    end
  end

  return original
end

function utils.bounded(value, min, max)
  min = min or 0
  max = max or math.huge

  if min then value = math.max(value, min) end
  if max then value = math.min(value, max) end

  return value
end

function utils.tbl_longest_str(tbl)
  local len = 0

  for _,str in pairs(tbl) do
    len = math.max(len, #str)
  end

  return len
end

return utils
