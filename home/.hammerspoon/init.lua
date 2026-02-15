local toggle_wezterm = function()
  local frontApp = hs.application.frontmostApplication()
  if frontApp and frontApp:name() == "WezTerm" then
    frontApp:hide()
  else
    hs.application.launchOrFocus("WezTerm")
  end
end

hs.hotkey.bind({ "ctrl" }, "return", toggle_wezterm)
