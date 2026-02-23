local wezterm = require 'wezterm'

local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
  local window = mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

local function tab_title(tab_info)
  local title = tab_info.tab_title
  if title and #title > 0 then
    return title
  end
  return tab_info.active_pane.title
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = tab_title(tab)
  title = wezterm.truncate_right(title, max_width - 2)
  return ' ' .. title .. ' '
end)

wezterm.on('toggle-opacity', function(window)
  local overrides = window:get_config_overrides() or {}
  if overrides.window_background_opacity == 0.5 then
    overrides.window_background_opacity = 1.0
    overrides.text_background_opacity = 1.0
  else
    overrides.window_background_opacity = 0.5
    overrides.text_background_opacity = 0.5
  end
  window:set_config_overrides(overrides)
end)

local keys = {
  {
    key = "w",
    mods = "CMD",
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
  {
    key = "d",
    mods = "CMD",
    action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } },
  },
  {
    key = "d",
    mods = "CMD|SHIFT",
    action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } },
  },
  {
    key = "o",
    mods = "CMD|CTRL",
    action = wezterm.action.RotatePanes 'Clockwise'
  },
  {
    key = '[',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection 'Prev',
  },
  {
    key = ']',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection 'Next',
  },
  {
    key = 'Enter',
    mods = 'CMD|SHIFT',
    action = wezterm.action.TogglePaneZoomState,
  },
  {
    key = 'f',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ToggleFullScreen,
  },
  {
    key = 'u',
    mods = 'CMD',
    action = wezterm.action.EmitEvent 'toggle-opacity',
  },
  {
    key = 't',
    mods = 'CMD|CTRL',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 't',
    mods = 'CMD|SHIFT',
    action = wezterm.action.PromptInputLine {
      description = 'Set tab title',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  {
    key = 'LeftArrow',
    mods = 'CMD|CTRL',
    action = wezterm.action.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = 'RightArrow',
    mods = 'CMD|CTRL',
    action = wezterm.action.AdjustPaneSize { 'Right', 5 },
  },
  {
    key = 'UpArrow',
    mods = 'CMD|CTRL',
    action = wezterm.action.AdjustPaneSize { 'Up', 5 },
  },
  {
    key = 'DownArrow',
    mods = 'CMD|CTRL',
    action = wezterm.action.AdjustPaneSize { 'Down', 5 },
  },
  -- FIXME: for claude code new line
  {
    key = 'Enter',
    mods = 'SHIFT',
    action = wezterm.action.SendString '\x1b[13;2u',
  }
}

return {
  -- tried: Dracula+, Neutron, ayu
  color_scheme = 'Circus (base16)',
  window_background_opacity = 1.0,
  text_background_opacity = 1.0,
  font_size = 12.0,
  font = wezterm.font_with_fallback {
    '0xProto Nerd Font'
  },
  keys = keys,
  window_decorations = 'INTEGRATED_BUTTONS | RESIZE',
  window_padding = {
    top = 0,
    bottom = 0,
    right = 0,
    left = 0
  },
}
