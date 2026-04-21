#Requires AutoHotkey v2.0+			

#UseHook

InstallKeybdHook
	
SetKeyDelay 0

; whether ctrl-c is pressed
is_pre_c := 0

; whether ctrl-x is pressed
is_pre_x := 0

; whether ctrl-space is pressed
is_pre_spc := 0

; whether you are in applications for which keybindings are disabled
excluded()
{
  if (WinActive("ahk_class CASCADIA_HOSTING_WINDOW_CLASS")) ; Windows-Terminal
    return 1

  if (WinActive("ahk_class MSPaintApp"))                    ; Paint
    return 1

  if (WinActive("ahk_exe Code.exe"))                        ; VSCode
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
  is_pre_c := 0
  is_pre_x := 0
  is_pre_spc := 0
}

delete_backward_char()
{
  Send "{BS}"
  global is_pre_spc := 0
  return
}

open_line()
{
  Send "{End}{Enter}{Up}"
  global is_pre_spc := 0
  return
}

quit()
{
  Send "{Esc}"
  global is_pre_spc := 0
  return
}

newline()
{
  Send "{Enter}"
  global is_pre_spc := 0
  return
}

indent_for_tab_command()
{
  Send "{Tab}"
  global is_pre_spc := 0
  return
}

newline_and_indent()
{
  Send "{Enter}{Tab}"
  global is_pre_spc := 0
  return
}

isearch_forward()
{
  Send "^f"
  global is_pre_spc := 0
  return
}

isearch_backward()
{
  Send "^f"
  global is_pre_spc := 0
  return
}

yank()
{
  Send "^v"
  global is_pre_spc := 0
  return
}

kill_app()
{
  Send "!{F4}"
  global is_pre_x := 0
  return
}

forward_char()
{
  global
  if (is_pre_spc)
    Send "+{Right}"
  else
    Send "{Right}"
  return
}

scroll_up()
{
  global
  if (is_pre_spc)
    Send "+{PgUp}"
  else
    Send "{PgUp}"
  return
}

scroll_down()
{
  global
  if (is_pre_spc)
    Send "+{PgDn}"
  else
    Send "{PgDn}"
  return
}

; toggle ctrl+x
^x::
{
  global
  if (excluded())
  {
    Send A_ThisHotkey
  }
  else
  {
    reset()
    is_pre_x := 1
  }
  return
}

; toggle ctrl+c or kill applications
^c::
{
  global
  if (excluded())
  {
    send A_ThisHotkey
  }
  else
  {
    if (is_pre_x)
      kill_app()
    reset()
    is_pre_c := 1
  }
  return
}

; forward char or find file
^f::
{
  global
  if (excluded())
  {
    send A_ThisHotkey
  }
  else
  {
    if (is_pre_x) ; find file
    {
      Send "^o"
    }
    else        ; forward char
    {
      if (is_pre_spc)
        Send "+{Right}"
      else
        Send "{Right}"
    }
    reset()
  }
  return
}

; forward word
!f::
{
  global
  if (excluded())
  {
    Send A_ThisHotKey
  }
  else
  {
    Send "{Ctrl Down}{Right Down}{Right Up}{Ctrl Up}"
    reset()
  }
  return
}

; delete char
^d::
{
  global
  if (excluded())
  {
    Send A_ThisHotkey
  }
  else
  {
    Send "{Del}"
    reset()
  }
  return
}

; delete word
!d::
{
  if (excluded())
  {
    Send A_ThisHotkey
  }
  else
  {
    Send "{Ctrl Down}{Delete Down}{Delete Up}{Ctrl Up}"
    reset()
  }
  return
}

; delete backward char
^h::
{
  global
  if (excluded())
  {
    send A_ThisHotkey
  }
  else
  {
    Send "{Bs}"
    reset()
  }
  return
}

; kill line or next tab in browsing

^k::
{ 
  global
  if (excluded())
  {
    send A_ThisHotkey
  }
  else
  {
    if (is_browser() and is_pre_c)
    {
      Send "{Ctrl Down}{Shift Down}{Tab}{Shift Up}{Ctrl Up}"
    }
    else
    {
      Send "{Shift Down}{End}{Shift Up}"
      Sleep 50 ; [ms] this value depends on your environment
      Send "^x"
    }
    reset()
  }
  return
}

; reset
^g::
{
  global
  if (excluded())
  {
    Send A_ThisHotkey
  }
  else
  {
    reset()
    Send "{Esc}"
    Send A_ThisHotkey
  }
  return
}

; new line
^m::
{
  global
  if (excluded())
  {
    send A_ThisHotkey
  }
  else
  {
    Send "{Enter}"
    reset()
  }
  return
}

; save buffer or forward search
^s::
{
  global
  if (excluded())
  {
    send A_ThisHotkey
  }
  else
  {
    if (is_pre_x)
      Send "^s" ; save buffer
    else
      Send "^f" ; forward search
    reset()
  }
  return
}

; backward search?
^r::
{
  global
  if (excluded())
  {
    send A_ThisHotkey
  }
  else
  {
    Send "^f" ; ?
    reset()
  }
  return
}

; kill region
^w::
{ 
  global
  if (excluded())
  {
    Send A_ThisHotkey
  }
  else
  {
    Send "^x"
    reset()
  }
  return
}

; kill ring save (copy)
!w::
{
  global
  if (excluded())
  {
    send A_ThisHotkey
  }
  else
  {
    Send "^c"
    reset()
  }
  return
}

; yank
^y::
{
  global
  if (excluded())
  {
    Send A_ThisHotkey
  }
  else
  {
    Send "^v"
    reset()
  }
  return
}

; undo
^/::
{
  global
  if (excluded())
  {
    send A_ThisHotkey
  }
  else
  {
    Send "^z"
    reset()
  }
  return
}

; ctrl+space
^vk20::
{
  global is_pre_spc
  if (excluded())
  {
    Send "{Ctrl Down}{Space}{Ctrl Up}"
  }
  else
  {
    pre_spc := is_pre_spc
    reset()
    if (pre_spc)
      is_pre_spc := 0
    else
      is_pre_spc := 1
  }
  return
}

; ctrl+space
^@::
{
  global is_pre_spc
  if (excluded())
  {
    send A_ThisHotkey
  }
  else
  {
    pre_spc := is_pre_spc
    reset()
    if (pre_spc)
      is_pre_spc := 0
    else
      is_pre_spc := 1
  }
  return
}

; move beginning of line
^a::
{
  global
  if (excluded())
  {
    send A_ThisHotkey
  }
  else
  {
    if (is_pre_spc)
      Send "+{Home}"
    else
      Send "{Home}"
    reset()
  }
  return
}

; move end of line
^e::
{
  global
  if (excluded())
  {
    send A_ThisHotkey
  }
  else
  {
    if (is_pre_spc)
      Send "+{End}"
    else
      Send "{End}"
    reset()
  }
  return
}

; go to previous line
^p::
{
  global
  if (excluded())
  {
    Send A_ThisHotkey
  }
  else
  {
    if (is_pre_spc)
      Send "+{Up}"
    else
      Send "{Up}"
    reset()
  }
  return
}

; go to next line
^n::
{
  global
  if (excluded())
  {
    Send A_ThisHotkey
  }
  else
  {
    if (is_pre_spc)
      Send "+{Down}"
    else
      Send "{Down}"
    reset()
  }
  return
}

; backward char or previous tab in browsing
^j::
{
  global
  if (excluded())
  {
    Send A_ThisHotkey
  }
  else
  {
    if (is_browser() and is_pre_c)
      Send "{Ctrl Down}{Tab}{Ctrl Up}"
    else if (is_pre_spc)
      Send "+{Left}"
    else
      Send "{Left}"
    reset()
  }
  return
}

; backward word
!j::
{
  global
  if (excluded())
  {
    send A_ThisHotKey
  }
  else
  {
    Send "{Ctrl Down}{Left Down}{Left Up}{Ctrl Up}"
    reset()
  }
  return
}

; close tab in browsing
k::
{
  global
  if (is_browser() and is_pre_c)
    Send "^{F4}"
  else
    Send A_ThisHotkey
  reset()
  return
}

; undo recently closed tab in browsing
u::
{
  global
  if (is_browser() and is_pre_c)
    Send "{Ctrl Down}{Shift Down}t{Shift Up}{Ctrl Up}"
  else
    Send A_ThisHotkey
  reset()
  return
}

; scroll down
^v::
{
  global
  if (excluded())
  {
    Send A_ThisHotkey
  }
  else
  {
    if (is_pre_spc)
      Send "+{PgDn}"
    else
      Send "{PgDn}"
    reset()
  }
  return
}

; scroll up
!v::
{
  global
  if (excluded())
  {
    Send A_ThisHotkey
  }
  else
  {
    if (is_pre_spc)
      Send "+{PgUp}"
    else
      Send "{PgUp}"
    reset()
  }
  return
}

; browser back
j::
{
  global
  if (is_browser() and is_pre_c)
    Send "!{Left}"
  else
    Send A_ThisHotkey
  reset()
  return
}

; browser forward
f::
{
  global
  if (is_browser() and is_pre_c)
    Send "!{Right}"
  else
    Send A_ThisHotkey
  reset()
  return
}

; browser reload
r::
{
  global
  if (is_browser() and is_pre_c)
    Send "{Ctrl Down}R{Ctrl Up}"
  else
    Send A_ThisHotkey
  reset()
  return
}

; ; disable in browser
; !o::
;   reset ()
; return

;; shortcuts

^!t::
{
  Run "wt.exe" ; Windows Terminal
}

; \  -> _
SC073::_
{
}
