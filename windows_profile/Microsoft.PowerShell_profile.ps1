#Set-PSReadlineOption -BellStyle None
#set-PSReadlineOption -EditMode vi
#Set-PSReadlineOption -Colors @{ "Parameter" = "White" }

function GitPrompt() {
  if (!(Test-Path .git)) {
    return ""
  }

  $result = " "
  $result += Foreground Blue "("

  try {
    $branch = git rev-parse --abbrev-ref HEAD
    $dirty = git status --porcelain

    if ($branch -eq "HEAD") {
      # we're probably in detached HEAD state, so print the SHA
      $branch = git rev-parse --short HEAD
      $result += Foreground Red $branch
    } else {
      # we're on an actual branch, so print it
      $result += Foreground Green $branch
    }
  } catch {
    # we'll end up here if we're in a newly initiated git repo
    $result += Foreground Yellow "n/a"
  }

  $result += Foreground Blue ")"

  if ($dirty -ne $null) {
    $result += Foreground Yellow " ‼"
  }

  return $result
}

# TODO: Define 24-bit colors instead since the ANSI codes are not set by Windows Terminal colorscheme.
enum Colors
{
  Black         = 30
  Red           = 31
  Green         = 32
  Yellow        = 33
  Blue          = 34
  Magenta       = 35
  Cyan          = 36
  White         = 37
  BrightBlack   = 90
  BrightRed     = 91
  BrightGreen   = 92
  BrightYellow  = 93
  BrightBlue    = 94
  BrightMagenta = 95
  BrightCyan    = 96
  BrightWhite   = 97
}

function Foreground([Colors]$color, [string]$value) {
  $code = [int]$color
  return "`e[38;5;${code}m${value}`e[0m"
}

function global:prompt {
  $promptChar = " "

  $prompt = "("
  $prompt += Foreground Blue $env:COMPUTERNAME
  $prompt += ":"
  $prompt += Foreground Cyan (Split-Path -Path $pwd -Leaf)
  $prompt += ")"
  $prompt += GitPrompt

  return $prompt + $promptChar
}
