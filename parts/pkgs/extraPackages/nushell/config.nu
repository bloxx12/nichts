let starship_installed = not (which starship | is-empty)
let direnv_installed = not (which direnv | is-empty)
let carapace_installed = not (which carapace | is-empty)

alias c = clear
alias cc = cd; clear
alias h = hx
alias e = emacsclient
alias g = git
alias lg = lazygit
# alias cd = z
# alias ci = zi


let zoxide_completer = {|spans|
    $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

# =============================================================================
let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}

# =============================================================================
let fish_completer = {|spans|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | $"value(char tab)description(char newline)" + $in
    | from tsv --flexible --no-infer
}

# =============================================================================
# This completer will use carapace by default
let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -i 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    match $spans.0 {
        # carapace completions are incorrect for nu
        nu => $fish_completer
        # fish completes commits and branch names in a nicer way
        git => $fish_completer
        # carapace doesn't have completions for asdf
        # asdf => $fish_completer
        # use zoxide completions for zoxide commands
        __zoxide_z | __zoxide_zi => $zoxide_completer
        _ => $carapace_completer
    } | do $in $spans
}

# =============================================================================
if $starship_installed {
  $env.STARSHIP_SHELL = "nu"
  $env.STARSHIP_SESSION_KEY = (random chars -l 16)
  $env.STARSHIP_SESSION_KEY = (random chars -l 16)
  $env.PROMPT_MULTILINE_INDICATOR = (starship prompt --continuation)
  $env.PROMPT_INDICATOR = ""
  $env.PROMPT_COMMAND = {|| starship prompt $"--cmd-duration=($env.CMD_DURATION_MS)" $"--status=($env.LAST_EXIT_CODE)" }
  $env.PROMPT_COMMAND_RIGHT = ''
} else {}

# =============================================================================
$env.config = {
  show_banner: false
  
  hooks: {
    pre_prompt: [{ ||
    if $direnv_installed {
      direnv export json | from json | default {} | load-env
    } else { return }
    }]
  }

  rm: {
    always_trash: true
  }

  table: {
    mode: compact
    index_mode: auto
  }

  completions: {
    quick: true
    partial: true
    case_sensitive: false
    algorithm: "fuzzy"
    external:  {
        enable: true
        completer: $external_completer
        max_results: 100
    } 
  }
}

