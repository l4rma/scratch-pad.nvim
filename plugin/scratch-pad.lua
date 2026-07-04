if vim.g.loaded_scratch_pad then
  return
end
vim.g.loaded_scratch_pad = true

vim.api.nvim_create_user_command("ScratchPad", function()
  require("scratch-pad").scratch_pad()
end, { desc = "Toggle scratch pad" })
