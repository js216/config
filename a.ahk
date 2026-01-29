; Switch Capslock and Escape
$Capslock::Esc
$Esc::Capslock

; Run programs
<#c::Run "C:\Users\Jkastelic\Documents\prog\Free42Decimal.exe"
<#z::Run "C:\Program Files\Google\Chrome\Application\chrome.exe"
<#m::Run "C:\Users\Jkastelic\Documents\prog\foobar2000\foobar2000.exe"

#2::MsgBox("You pressed Win+2")

; Abbr
<#^!0::Send '0xc0008000'

; Special characters
<#^!Right::Send '→'
<#^!Left::Send '←'
<#^!Up::Send '↑'
<#^!Down::Send '↓'
<#^!.::Send '≥'
<#^!,::Send '≤'
<#^!+,::Send '⪅'
<#^!-::Send '−'   ; minus symbol
<#^!m::Send '—'   ; em dash
<#^!n::Send '–'   ; en dash
<#^!d::Send '°'
<#^!+=::Send '±'
<#^!=::Send '≈'
<#^!x::Send '×'
<#^!+x::Send '⋅'
<#^!s::Send '√'

; Greek letters
^!a::Send 'α'
^!b::Send 'β'
^!+d::Send 'Δ'
^!d::Send 'δ'
^!+p::Send 'Π'
^!p::Send 'π'
^!+f::Send 'Φ'
^!f::Send 'φ'
^!+o::Send 'Ω'
^!o::Send 'ω'
^!m::Send 'μ'
^!+s::Send 'Σ'
^!s::Send 'σ'
^!e::Send 'ε'
^!t::Send 'θ'
^!h::Send 'η'
^!r::Send 'ρ'
^!z::Send 'ζ'
^!l::Send 'λ'

; Press Ctrl+Shift+Alt+V to remove the title bar of the Vim window

^+!v::
{
    SetTitleMatchMode(2)  ; Partial title match

    hwnd := WinExist("GVIM") ; Change "GVIM" if needed to match your window title or use ahk_class

    if hwnd
    {
        ; GWL_STYLE = -16
        ; WS_CAPTION = 0x00C00000 (title bar and border)
        Style := DllCall("GetWindowLong", "Ptr", hwnd, "Int", -16, "UInt")
        NewStyle := Style & ~0x00C00000  ; Remove WS_CAPTION (title bar)

        DllCall("SetWindowLong", "Ptr", hwnd, "Int", -16, "UInt", NewStyle)

        ; Refresh window frame to apply changes
        DllCall("SetWindowPos"
            , "Ptr", hwnd
            , "Ptr", 0
            , "Int", 0
            , "Int", 0
            , "Int", 0
            , "Int", 0
            , "UInt", 0x27)  ; SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_FRAMECHANGED

    }
    else
    {
        MsgBox("Could not find Vim window.")
    }
    return
}
