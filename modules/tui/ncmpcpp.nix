{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.programs.ncmpcpp;
  username = config.modules.other.system.username;
in {
  options.modules.programs.ncmpcpp.enable = mkEnableOption "ncmpcpp";

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      xdg.configFile."ncmpcpp/config".source = ./config;
      programs.ncmpcpp = {
        enable = true;
        package = pkgs.ncmpcpp.override {visualizerSupport = true;};
        mpdMusicDir = "/home/vali/Nextcloud/Media/Music";
        settings = {
          mpd_host = "127.0.0.1";
          mpd_port = "6600";
          alternative_header_first_line_format = "$5{$b%t$/b}$9";
          alternative_header_second_line_format = "$3by $7{$b%a$/b}$9 $3from $7{$b%b$/b}$9 $5{(%y)}";
          song_list_format = "♫   $2%n$(end) $9 $3%a$(end) $(245)-$9 $(246)%t$9 $R{ $5%y$9}$(end)     $(246)%lq$(end)";
          song_columns_list_format = "(3f)[red]{n} (3f)[246]{} (35)[white]{t} (18)[blue]{a} (30)[green]{b} (5f)[yellow]{d} (5f)[red]{y} (7f)[magenta]{l}";
          song_status_format = "$b $8%A $8•$3• $3%t $3•$5• $5%b $5•$2• $2%y $2•$8• %g";
          playlist_display_mode = "columns";
          browser_display_mode = "columns";
          search_engine_display_mode = "columns";
          now_playing_prefix = "$b";
          now_playing_suffix = "$/b";
          browser_playlist_prefix = "$2 ♥ $5 ";
          playlist_disable_highlight_delay = "1";
          message_delay_time = "1";
          progressbar_look = "━━━";
          colors_enabled = "yes";
          empty_tag_color = "red";
          statusbar_color = "blue";
          state_line_color = "black";
          state_flags_color = "default";
          main_window_color = "blue";
          header_window_color = "white";
          alternative_ui_separator_color = "black";
          window_border_color = "green";
          active_window_border = "red";
          volume_color = "default";
          progressbar_color = "black";
          progressbar_elapsed_color = "blue";
          statusbar_time_color = "blue";
          player_state_color = "default";
          display_bitrate = "yes";
          autocenter_mode = "yes";
          centered_cursor = "yes";
          titles_visibility = "no";
          enable_window_title = "yes";
          statusbar_visibility = "yes";
          empty_tag_marker = "";
          mouse_support = "yes";
          header_visibility = "no";
          display_remaining_time = "no";
          ask_before_clearing_playlists = "yes";
          discard_colors_if_item_is_selected = "yes";
          user_interface = "alternative";
          default_find_mode = "wrapped";
          lyrics_directory = "~/.lyrics";
          follow_now_playing_lyrics = "yes";
          store_lyrics_in_song_dir = "no";
          ignore_leading_the = "yes";
          lines_scrolled = "1";
          mouse_list_scroll_whole_page = "no";
          show_hidden_files_in_local_browser = "no";
          startup_screen = "playlist";
          execute_on_song_change = "/home/dobbie/.bin/np";
          connected_message_on_startup = "no";
          playlist_separate_albums = "no";
          allow_for_physical_item_deletion = "no";
          visualizer_in_stereo = "yes";
          visualizer_data_source = "/tmp/mpd.fifo";
          visualizer_type = "wave_filled";
          visualizer_look = "▉▋";
        };
      };
    };
  };
}
