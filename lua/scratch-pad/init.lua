local M = {}

M.config = {
    scratch_title = { "# Scratch pad", "---", "" },
    keymap = "<leader>sp",
}

local state = {
    floating = {
        buf = -1,
        win = -1,
    }
}

local function open_centered_popup(opts)
    opts = opts or {}
    local width_ratio = opts.width or 0.8
    local height_ratio = opts.height or 0.8

    local ui = vim.api.nvim_list_uis()[1]
    local screen_w = ui.width
    local screen_h = ui.height

    local win_width = math.floor(screen_w * width_ratio)
    local win_height = math.floor(screen_h * height_ratio)

    local col = math.floor((screen_w - win_width) / 2)
    local row = math.floor((screen_h - win_height) / 2)

    local buf = nil
    local is_new_buf = false
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        is_new_buf = true
        buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_set_option_value("filetype", "markdown", { buf = buf})
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, M.config.scratch_title)
    end

    local win_opts = {
        relative = "editor",
        width = win_width,
        height = win_height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
    }

    local win = vim.api.nvim_open_win(buf, true, win_opts)

    if is_new_buf then
        local last_line = vim.api.nvim_buf_line_count(buf)
        vim.api.nvim_win_set_cursor(win, { last_line, 0 })
    end
    vim.cmd("startinsert!")

    return { buf = buf , win = win }
end

M.scratch_pad = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = open_centered_popup { buf = state.floating.buf }
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
end

M.setup = function(opts)
    M.config = vim.tbl_deep_extend("force", M.config, opts or {})

    if M.config.keymap then
        vim.keymap.set("n", M.config.keymap, M.scratch_pad, { desc = "Toggle scratch pad" })
    end
end

return M
