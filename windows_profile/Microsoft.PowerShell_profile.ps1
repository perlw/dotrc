Set-PSReadlineOption -BellStyle None
set-PSReadlineOption -EditMode vi
Set-PSReadlineOption -Colors @{ "Parameter" = "White" }

function tt([string]$title) {
  Write-Output "`e]2;$title`a"
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
  return "`e[1;${code}m${value}`e[0m"
}

function global:prompt {
  $promptChar = " "

  $osChar = ""
  # NOTE: I guess you never know..
  if ($IsLinux) {
    $osChar = ""
  } elseif ($IsMacOS) {
    $osChar = ""
  }

  $dirCount = (Get-Location -Stack).Count
  $dirInfo = ""
  if ($dirCount -gt 0) {
    $dirInfo = " $dirCount"
  }
  $lastStatus = Foreground Green "✓"
  if ($Error.Count -gt 0) {
    $lastStatus = Foreground Red "✖"
  }
  $jobCount = (Get-Job).Count
  $jobs = ""
  if ($jobCount -gt 0) {
    $jobs = Foreground Yellow " $jobCount"
  }

  $prompt = "($osChar$(Foreground Green $env:COMPUTERNAME.ToLower()):$(Foreground Cyan (Split-Path -Path $pwd -Leaf)))"
  $prompt += "[$lastStatus$jobs$dirInfo]"

  # NOTE: Hack to be able to check if last execution produced errors. It's bad practice, I know.
  # NOTE: Is it tho? I mean, as long as it's only the prompt clearing the errors it should be perfectly fine, right?
  $Error.Clear()

  return $prompt + $promptChar
}
