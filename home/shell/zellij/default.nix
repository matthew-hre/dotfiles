{pkgs, ...}: {
  xdg.configFile."zellij/config.kdl".source = ./config.kdl;
  xdg.configFile."zellij/layouts/default.kdl".text = ''
    layout {
      default_tab_template {
        pane size=2 borderless=true {
          plugin location="file://${pkgs.zjstatus}/bin/zjstatus.wasm" {

            color_fg "#F8F8F2"
            color_fg_muted "#6272A4"
            color_bg "#282A36"
            color_bg_muted "#44475A"
            color_red "#FF5555"
            color_green "#50FA7B"
            color_yellow "#F1FA8C"
            color_cyan "#8BE9FD"
            color_orange "#FFB86C"
            color_purple "#BD93F9"

            tab_sync_indicator       "  "
            tab_fullscreen_indicator " 󰊓 "
            tab_floating_indicator   " 󰹙 "

            format_left   "{mode} #[fg=$fg_muted,bold]{session}"
            format_center "{tabs}"
            format_right  "{command_git_branch} {datetime}"
            format_space  ""

            border_enabled "false"
            border_char "─"
            border_format   "#[fg=#bg_muted]{char}"
            border_position "top"

            hide_frame_for_single_pane "true"

            mode_normal        "#[fg=$green]█#[fg=$green,bold] NORMAL#[fg=$green]"
            mode_locked        "#[fg=$red]█#[fg=$red,bold] LOCKED  #[fg=$red]"
            mode_resize        "#[fg=$cyan]█#[fg=$cyan,bold] RESIZE#[fg=$blue]"
            mode_pane          "#[fg=$cyan]█#[fg=$cyan,bold] PANE#[fg=$blue]"
            mode_tab           "#[fg=$yellow]█#[fg=$yellow,bold] TAB#[fg=$yellow]"
            mode_scroll        "#[fg=$cyan]█#[fg=$cyan,bold] SCROLL#[fg=$blue]"
            mode_enter_search  "#[fg=$orange]█#[fg=$orange,bold] ENT-SEARCH#[fg=$orange]"
            mode_search        "#[fg=$orange]█#[fg=$orange,bold] SEARCHARCH#[fg=$orange]"
            mode_rename_tab    "#[fg=$yellow]█#[fg=$yellow,bold] RENAME-TAB#[fg=$yellow]"
            mode_rename_pane   "#[fg=$cyan]█#[fg=$cyan,bold] RENAME-PANE#[fg=$blue]"
            mode_session       "#[fg=$cyan]█#[fg=$cyan,bold] SESSION#[fg=$blue]"
            mode_move          "#[fg=$cyan]█#[fg=$cyan,bold] MOVE#[fg=$blue]"
            mode_prompt        "#[fg=$cyan]█#[fg=$cyan,bold] PROMPT#[fg=$blue]"
            mode_tmux          "#[fg=$purple]█#[fg=purple,bold] TMUX#[fg=$purple]"

            tab_normal              "#[bg=$fg_muted] #[bg=$fg_muted,fg=$bg,bold]{index} #[bg=$bg_muted,fg=$fg_muted,bold] {name}{floating_indicator}#[fg=$bg_muted,,bold]█"
            tab_normal_fullscreen   "#[fg=$fg_muted]█#[bg=$fg_muted,fg=$bg,bold]{index} #[bg=$bg_muted,,fg=$fg_muted,bold] {name}{fullscreen_indicator}#[fg=$bg_muted,,bold]█"
            tab_normal_sync         "#[fg=$fg_muted]█#[bg=$fg_muted,fg=$bg,bold]{index} #[bg=$bg_muted,,fg=$fg_muted,bold] {name}{sync_indicator}#[fg=$bg_muted,,bold]█"

            tab_active              "#[fg=$green]█#[bg=$green,fg=$bg,bold]{index} #[bg=$bg_muted,,fg=$green,bold] {name}{floating_indicator}#[bg=$bg_muted,,fg=$bg_muted,,bold]"
            tab_active_fullscreen   "#[fg=$green]█#[bg=$green,fg=$bg,bold]{index} #[bg=$bg_muted,,fg=$green,bold] {name}{fullscreen_indicator}#[bg=$bg_muted,,fg=$bg_muted,,bold]"
            tab_active_sync         "#[fg=$green]█#[bg=$green,fg=$bg,bold]{index} #[bg=$bg_muted,,fg=$green,bold] {name}{sync_indicator}#[bg=$bg_muted,,fg=$bg_muted,,bold]"

            tab_separator " "

            command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
            command_git_branch_format      "#[fg=$fg] {stdout} "
            command_git_branch_interval    "5"
            command_git_branch_rendermode  "dynamic"

            datetime        "#[fg=$fg_muted,bold] {format} "
            datetime_format "%A, %-d %B, %Y ─ %-I:%M%p"
            datetime_timezone "America/Edmonton"
          }
        }
        children
      }
    }
  '';
  programs.zellij = {
    enable = true;
  };
}
