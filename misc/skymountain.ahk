#InstallKeybdHook
#UseHook

SetKeyDelay 0

; whether ctrl-c is pressed
is_pre_c = 0

; whether ctrl-x is pressed
is_pre_x = 0

; whether ctrl-space is pressed
is_pre_spc = 0

; whether you are in applications for which keybindings are disabled
excluded()
{
  if (WinActive("ahk_class CASCADIA_HOSTING_WINDOW_CLASS")) ; Windows-Terminal
    return 1

  if (WinActive("ahk_class MSPaintApp"))                    ; Paint
    return 1

  return 0
}

; whether you are in applications for which keybindings are disabled
is_browser()
{
  if (WinActive("ahk_class Chrome_WidgetWin_1")) ; whether the app is chromium
    return 1

  return 0
}


reset()
{
  global
  is_pre_c = 0
  is_pre_x = 0
  is_pre_spc = 0
}

delete_backward_char()
{
  send {bs}
  global is_pre_spc = 0
  return
}

open_line()
{
  send {end}{enter}{up}
  global is_pre_spc = 0
  return
}

quit()
{
  send {esc}
  global is_pre_spc = 0
  return
}

newline()
{
  send {enter}
  global is_pre_spc = 0
  return
}

indent_for_tab_command()
{
  send {tab}
  global is_pre_spc = 0
  return
}

newline_and_indent()
{
  send {enter}{tab}
  global is_pre_spc = 0
  return
}

isearch_forward()
{
  send ^f
  global is_pre_spc = 0
  return
}

isearch_backward()
{
  send ^f
  global is_pre_spc = 0
  return
}

yank()
{
  send ^v
  global is_pre_spc = 0
  return
}

kill_app()
{
  send !{F4}
  global is_pre_x = 0
  return
}

forward_char()
{
  global
  if (is_pre_spc)
    send +{right}
  else
    send {right}
  return
}

scroll_up()
{
  global
  if (is_pre_spc)
    send +{pgup}
  else
    send {pgup}
  return
}

scroll_down()
{
  global
  if (is_pre_spc)
    send +{pgdn}
  else
    send {pgdn}
  return
}

; toggle ctrl+x
^x::
  if (excluded())
  {
    send %A_ThisHotkey%
   }
  else
  {
    reset()
    is_pre_x = 1
  }
return

; toggle ctrl+c or kill applications
^c::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    if (is_pre_x)
      kill_app()
    reset()
    is_pre_c = 1
  }
return

; forward char or find file
^f::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    if (is_pre_x) ; find file
    {
      send ^o
    }
    else        ; forward char
    {
      if (is_pre_spc)
        send +{right}
      else
        send {right}
    }
    reset()
  }
return

; forward word
!f::
  if (excluded())
  {
    send %A_ThisHotKey%
  }
  else
  {
    send {ctrl down}{right down}{right up}{ctrl up}
    reset()
  }
return

; delete char
^d::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    send {del}
    reset()
  }
return

; delete word
!d::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    send {ctrl down}{delete down}{delete up}{ctrl up}
    reset()
  }
return

; delete backward char
^h::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    send {bs}
    reset()
  }
return

; kill line or next tab in browsing

^k::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    if (is_browser() and is_pre_c)
    {
      send {ctrl down}{shift down}{tab}{shift up}{ctrl up}
    }
    else
    {
      send {shift down}{end}{shift up}
      sleep 50 ; [ms] this value depends on your environment
      send ^x
    }
    reset()
  }
return

; reset
^g::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    reset()
    send {esc}
    send %A_ThisHotkey%
  }
return

; new line
^m::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    send {enter}
    reset()
  }
return

; save buffer or forward search
^s::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    if (is_pre_x)
      send ^s ; save buffer
    else
      send ^f ; forward search
    reset()
  }
return

; backward search?
^r::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    send ^f ; ?
    reset()
  }
return

; kill region
^w::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    send ^x
    reset()
  }
return

; kill ring save (copy)
!w::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    send ^c
    reset()
  }
return

; yank
^y::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    send ^v
    reset()
  }
return

; undo
^/::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    send ^z
    reset()
  }
return

; ctrl+space
^vk20::
  if (excluded())
  {
    send {ctrl down}{space}{ctrl up}
  }
  else
  {
    pre_spc = is_pre_spc
    reset()
    if (pre_spc)
      is_pre_spc = 0
    else
      is_pre_spc = 1
  }
return

; ctrl+space
^@::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    pre_spc = is_pre_spc
    reset()
    if (pre_spc)
      is_pre_spc = 0
    else
      is_pre_spc = 1
  }
return

; move beginning of line
^a::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    if (is_pre_spc)
      send +{home}
    else
      send {home}
    reset()
  }
return

; move end of line
^e::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    if (is_pre_spc)
      send +{end}
    else
      send {end}
    reset()
  }
return

; go to previous line
^p::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    if (is_pre_spc)
      send +{up}
    else
      send {up}
    reset()
  }
return

; go to next line
^n::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    if (is_pre_spc)
      send +{down}
    else
      send {down}
    reset()
  }
return

; backward char or previous tab in browsing
^j::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    if (is_browser() and is_pre_c)
      send {ctrl down}{tab}{ctrl up}
    else if (is_pre_spc)
      send +{left}
    else
      send {left}
    reset()
  }
return

; backward word
!j::
  if (excluded())
  {
    send %A_ThisHotKey%
  }
  else
  {
    send {ctrl down}{left down}{left up}{ctrl up}
    reset()
  }
return

; close tab in browsing
k::
  if (is_browser() and is_pre_c)
    Send ^{f4}
  else
    send %A_ThisHotkey%
  reset()
return

; undo recently closed tab in browsing
u::
  if (is_browser() and is_pre_c)
    send {ctrl down}{shift down}t{shift up}{ctrl up}
  else
    send %A_ThisHotkey%
  reset()
return

; scroll down
^v::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    if (is_pre_spc)
      send +{pgdn}
    else
      send {pgdn}
    reset()
  }
return

; scroll up
!v::
  if (excluded())
  {
    send %A_ThisHotkey%
  }
  else
  {
    if (is_pre_spc)
      send +{pgup}
    else
      send {pgup}
    reset()
  }
return

; browser back
j::
  if (is_browser() and is_pre_c)
    send !{left}
  else
    send %A_ThisHotkey%
  reset()
return

; browser forward
f::
  if (is_browser() and is_pre_c)
    send !{right}
  else
    send %A_ThisHotkey%
  reset()
return

; browser reload
r::
  if (is_browser() and is_pre_c)
    send {ctrl down}r{ctrl up}
  else
    send %A_ThisHotkey%
  reset()
return

; ; disable in browser
; !o::
;   reset ()
; return

;; shortcuts

^!t::
  Run, "wt.exe" ; Windows Terminal

; \  -> _
SC073::_
