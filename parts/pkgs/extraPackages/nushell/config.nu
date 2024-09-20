let starship_installed = not (which starship | is-empty)
let direnv_installed = not (which direnv | is-empty)

$env.config = {
  show_banner: false

  
  hooks: {
    pre_prompt: [{ ||
    if $direnv_installed {
      direnv export json | from json | default {} | load-env
    } else { return }
    }]
  }
}


if $starship_installed {
  $env.STARSHIP_SHELL = "nu"
  $env.STARSHIP_SESSION_KEY = (random chars -l 16)
  $env.STARSHIP_SESSION_KEY = (random chars -l 16)
  $env.PROMPT_MULTILINE_INDICATOR = (starship prompt --continuation)
  # $env.PROMPT_INDICATOR = "$ "
  $env.PROMPT_COMMAND = {|| starship prompt $"--cmd-duration=($env.CMD_DURATION_MS)" $"--status=($env.LAST_EXIT_CODE)" }
  $env.PROMPT_COMMAND_RIGHT = ''
} else {}

