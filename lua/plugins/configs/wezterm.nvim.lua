local wezterm = require 'wezterm';

return {
  -- Add a new custom launcher
  launch_menu = {
    {
      label = "PowerShell (Admin)",
      args = {"powershell", "-NoExit", "-Command", "Start-Process", "powershell", "-Verb", "RunAs"}
    },
  },

  window_decorations = "NONE",
  -- Set default_prog to PowerShell if you want it to launch automatically
  default_prog = {"powershell.exe", "-NoExit"},

  -- Set window background transparency (0.6 = 60% transparency)
  window_background_opacity = 0.6,

  -- Enable window blur (only works on macOS)
  macos_window_background_blur = 15,  -- Adjust this value if needed
  
  -- Set the TokyoNight color scheme
  colors = {
    foreground = "#c0caf5",  -- Text color
    background = "#1a1b26",  -- Background color with transparency
    cursor_bg = "#c0caf5",   -- Cursor color
    cursor_fg = "#1a1b26",   -- Text color under the cursor
    cursor_border = "#c0caf5", -- Cursor border color
    selection_bg = "#33467C",  -- Selection background
    selection_fg = "#c0caf5",  -- Selection foreground

    -- ANSI colors (standard terminal colors)
    ansi = {"#15161e", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6"},
    brights = {"#414868", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5"},

    -- Tab bar colors (optional)
    tab_bar = {
      background = "#1a1b26", -- Tab bar background
      active_tab = {
        bg_color = "#32344a",  -- Active tab background
        fg_color = "#c0caf5",  -- Active tab text color
        intensity = "Bold",
      },
      inactive_tab = {
        bg_color = "#1a1b26",  -- Inactive tab background
        fg_color = "#a9b1d6",  -- Inactive tab text color
      },
    },
  },

  -- Additional settings to tweak appearance
  window_padding = {
    left = 2,
    right = 2,
    top = 2,
    bottom = 2,
  },

  -- Font configuration (optional)
  font = wezterm.font_with_fallback({
    "JetBrains Mono",        -- Primary font
    "Fira Code",             -- Fallback font
  }),
  font_size = 12.0,
}
