-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'nordfox'
  else
    return 'dayfox'
  end
end

local function font_for_appearance(appearance)
  if appearance:find 'Dark' then
    return wezterm.font('JetBrainsMono Nerd Font', { weight = 'ExtraLight' })
  else
    return wezterm.font('JetBrainsMono Nerd Font', { weight = 'Regular' })
  end
end

local function tab_bar_colors(color_scheme)
  local scheme = wezterm.color.get_builtin_schemes()[color_scheme]

  local bg = wezterm.color.parse(scheme.background)
  local fg = wezterm.color.parse(scheme.foreground)

  return {
    active_titlebar_bg = bg:darken(0.1),
    inactive_titlebar_bg = bg:darken(0.2),
    tab_bar = {
      inactive_tab_edge = fg:darken(0.4),
      active_tab = {
        bg_color = bg:lighten(0.1),
        fg_color = fg,
      },
      inactive_tab = {
        bg_color = bg:darken(0.2),
        fg_color = fg:darken(0.4)
      },
      inactive_tab_hover = {
        bg_color = bg:lighten(0.2),
        fg_color = fg:darken(0.3)
      },
      new_tab = {
        bg_color = bg:darken(0.2),
        fg_color = fg:darken(0.4)
      },
      new_tab_hover = {
        bg_color = bg:lighten(0.2),
        fg_color = fg:darken(0.3)
      },
    }
  }
end

local appearance = get_appearance()

-- For example, changing the color scheme:
config.color_scheme = scheme_for_appearance(appearance)

-- This is where you actually apply your config choices
config.font = font_for_appearance(appearance)
config.font_size = 15.0

-- TabBar options
config.tab_bar_at_bottom = true

local tc = tab_bar_colors(config.color_scheme)

config.window_frame = {
  -- The font used in the tab bar.
  -- Roboto Bold is the default; this font is bundled
  -- with wezterm.
  -- Whatever font is selected here, it will have the
  -- main font setting appended to it to pick up any
  -- fallback fonts you may have used there.
  font = wezterm.font { family = 'Roboto' },

  -- The size of the font in the tab bar.
  -- Default to 10.0 on Windows but 12.0 on other systems
  font_size = 16.0,

  -- The overall background color of the tab bar when
  -- the window is focused
  active_titlebar_bg = tc.active_titlebar_bg,

  -- The overall background color of the tab bar when
  -- the window is not focused
  inactive_titlebar_bg = tc.inactive_titlebar_bg,
}

config.colors = {
  tab_bar = tc.tab_bar
}

-- and finally, return the configuration to wezterm
return config
