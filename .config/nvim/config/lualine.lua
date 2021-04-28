require'lualine'.setup{
  options = {
    theme = 'seoul256',
    icons_enabled = false,
  },
  sections = {
    lualine_a = {
      {'mode', format=function(mode_name) return mode_name:sub(1,6) end},
    },
  },
}
