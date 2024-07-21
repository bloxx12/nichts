{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.usrEnv.programs.media.ncmpcpp;
  inherit (config.modules.other.system) username;
  inherit (config.modules.services.mpd) musicDirectory;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.ncmpcpp = {
        enable = true;
        package = pkgs.ncmpcpp.override {visualizerSupport = true;};
        mpdMusicDir = "${musicDirectory}";

        bindings = [
          {
            key = "j";
            command = "scroll_down";
          }
          {
            key = "k";
            command = "scroll_up";
          }
          {
            key = "J";
            command = ["select_item" "scroll_down"];
          }
          {
            key = "K";
            command = ["select_item" "scroll_up"];
          }
        ];
        settings = {
          # Miscelaneous
          ignore_leading_the = true;
          external_editor = "nvim";
          message_delay_time = 1;
          playlist_disable_highlight_delay = 2;
          autocenter_mode = "yes";
          centered_cursor = "yes";
          allow_for_physical_item_deletion = "no";
          lines_scrolled = "0";
          follow_now_playing_lyrics = "yes";
          lyrics_fetchers = "musixmatch";
          connected_message_on_startup = "no";
          mouse_support = "yes";

          # visualizer
          visualizer_data_source = "/tmp/mpd.fifo";
          visualizer_output_name = "mpd_visualizer";
          visualizer_type = "ellipse";
          visualizer_look = "●● ";
          visualizer_color = "blue, green";

          # appearance
          colors_enabled = "yes";
          browser_playlist_prefix = "$2 ♥ $5 ";
          playlist_display_mode = "classic";
          user_interface = "classic";
          volume_color = "white";

          # window
          song_window_title_format = "Music";
          statusbar_visibility = "no";
          header_visibility = "no";
          titles_visibility = "no";

          # progress bar
          progressbar_look = "━━━";
          progressbar_color = "black";
          progressbar_elapsed_color = "blue";

          # song list
          song_status_format = "$7%t";
          song_list_format = "$(008)%t$R  $(247)%a$R$5  %l$8";
          song_columns_list_format = "(53)[blue]{tr} (45)[blue]{a}";

          current_item_prefix = "$b$2| ";
          current_item_suffix = "$/b$5";

          now_playing_prefix = "$b$5| ";
          now_playing_suffix = "$/b$5";

          song_library_format = "{{%a - %t} (%b)}|{%f}";

          # colors
          main_window_color = "blue";

          current_item_inactive_column_prefix = "$b$5";
          current_item_inactive_column_suffix = "$/b$5";

          color1 = "white";
          color2 = "blue";
          /*
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
          connected_message_on_startup = "no";
          playlist_separate_albums = "no";
          allow_for_physical_item_deletion = "no";
          visualizer_in_stereo = "yes";
          visualizer_data_source = "/tmp/mpd.fifo";
          visualizer_type = "wave_filled";
          visualizer_look = "▉▋";
          */
        };
      };
    };
  };
}
