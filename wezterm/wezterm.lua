local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local is_windows = wezterm.target_triple:find('windows') ~= nil

config.font = wezterm.font('JetBrains Mono')
config.font_size = 12
config.color_scheme = 'GruvboxDark'
config.window_background_opacity = 0.95
config.use_fancy_tab_bar = false

config.window_padding = { left = 8, right = 8, top = 0, bottom = 0 }

-- Always ask before closing, even when only a shell is running.
config.skip_close_confirmation_for_processes_named = {}

config.background = {
  { source = { Color = '#282828' }, width = '100%', height = '100%' },
}

config.keys = {
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

if is_windows then
  config.default_prog = { 'C:\\Program Files\\Git\\bin\\bash.exe', '-i', '-l' }
  config.default_cwd = 'C:\\Users\\mtcco'
  config.set_environment_variables = { XDG_CONFIG_HOME = 'C:\\Users\\mtcco\\.config' }

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

  table.insert(config.keys, {
    key = 'L',
    mods = 'ALT|SHIFT',
    action = wezterm.action.ShowLauncherArgs { flags = 'LAUNCH_MENU_ITEMS' },
  })
end

return config
