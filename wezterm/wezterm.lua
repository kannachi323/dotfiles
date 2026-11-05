local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.default_prog = { 'C:\\Program Files\\Git\\bin\\bash.exe', '-i', '-l' }
config.font = wezterm.font('JetBrains Mono')
config.font_size = 12
config.color_scheme = 'GruvboxDark'
config.window_background_opacity = 0.95
config.use_fancy_tab_bar = false

config.default_cwd = 'C:\\Users\\mtcco'
config.set_environment_variables = { XDG_CONFIG_HOME = 'C:\\Users\\mtcco\\.config' }

config.window_padding = { left = 8, right = 8, top = 0, bottom = 0 }

config.background = {
  { source = { Color = '#282828' }, width = '100%', height = '100%' },
  {
    source = { File = 'C:\\Users\\mtcco\\Pictures\\bg\\chizu.jpg' },
    opacity = 0.05,
    width = 'Cover',
    height = 'Cover',
    horizontal_align = 'Center',
    vertical_align = 'Middle',
  },
}

config.launch_menu = {
  { label = 'Bash', cwd = 'C:\\Users\\mtcco', args = { 'C:\\Program Files\\Git\\bin\\bash.exe', '-i', '-l' } },
  { label = 'Bash (MSVC x64)', cwd = 'C:\\Users\\mtcco', args = {
      'cmd.exe', '/k',
      'call', 'C:\\Program Files\\Microsoft Visual Studio\\18\\Community\\VC\\Auxiliary\\Build\\vcvars64.bat',
      '&&',
      'C:\\Program Files\\Git\\bin\\bash.exe', '-i', '-l',
  } },
  { label = 'Ubuntu (WSL)', domain = { DomainName = 'WSL:Ubuntu' } },
}



config.keys = {
  {
    key = 'L',
    mods = 'ALT|SHIFT',
    action = wezterm.action.ShowLauncherArgs { flags = 'LAUNCH_MENU_ITEMS' },
  },
  {
    key = 't',
    mods = 'CTRL',
    action = wezterm.action.SpawnCommandInNewTab { cwd = wezterm.home_dir },
  },
  {
    key = 'w',
    mods = 'CTRL',
    action = wezterm.action.CloseCurrentTab { confirm = true },
  },
}

return config
