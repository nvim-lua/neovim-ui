local utils = require('ui._utils')

-- TODO(smolck): Just for testing, don't intend to keep this
local function make_win(text, options)
  options = utils.tbl_apply_defaults(options, {
    relative = 'editor',
    row      = 0,
    col      = 0,
    width    = 5,
    height   = 5,
    style    = 'minimal'
  })
  local win_opts = options

  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { text or 'This is just for testing' })

  local win_id = vim.api.nvim_open_win(bufnr, true, win_opts)

  return win_id
end

-- TODO(smolck): Is `partition` an accurate/good name?
local function partition(input, opts)
  local top_padding = input.top or 0
  local bottom_padding = input.bottom or 0
  local right_padding = input.right or 0
  local left_padding = input.left or 0

  for i, win_id in ipairs(input) do
    local row, col
    if opts.is_horizontal then
      row = opts.starting_row + (opts.max_height * (i - 1))
      col = opts.starting_col
    else
      row = opts.starting_row
      col = opts.starting_col + (opts.max_width * (i - 1))
    end
    row = row + top_padding
    col = col + left_padding

    if type(win_id) == 'table' then
      local horizontal = not opts.is_horizontal
      partition(win_id, {
        max_height = horizontal and math.floor(opts.max_height / #win_id) or opts.max_height,
        max_width = horizontal and opts.max_width or math.floor(opts.max_width / #win_id),
        starting_row = row - top_padding,
        starting_col = col - left_padding,
        is_horizontal = horizontal,
      })
    else
      vim.api.nvim_win_set_config(win_id, {
        row = row,
        col = col,
        width = opts.max_width - left_padding - right_padding,
        height = opts.max_height - top_padding - bottom_padding,
        relative = 'win',
      })
    end
  end
end

-- TODO(smolck): Error on invalid layouts, like:
-- ui.layout {
--     { make_win(),
--         { make_win('col left'), make_win('col right'), { make_win('underneath col right?') } },
--       make_win(),
--     },
--     { make_win() },
-- }
local function layout(input)
  local max_width = math.floor(vim.o.columns / #input)

  for i, tbl in ipairs(input) do
    local col = max_width * (i - 1)
    local max_height = math.floor(vim.o.lines / #tbl)
    partition(tbl, {
      max_height = max_height,
      max_width = max_width,
      starting_row = 0,
      starting_col = col, tbl,
      is_horizontal = true,
    })
  end
end

--layout {
--  { make_win(),
--    { make_win('col left'), make_win('col right'), top = 5, left = 5, right = 5 },
--    top = 5,
--    left = 5,
--    right = 5
--  },
--  {
--    make_win(),
--    make_win(),
--    top = 5,
--    left = 5,
--    right = 5
--  },
--}

return layout
