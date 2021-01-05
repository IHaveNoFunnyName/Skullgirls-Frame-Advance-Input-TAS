#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Gui, InputWindow:New,, Wau
Gui, Add, Button, gAirdash, Airdash
Gui, Show

Airdash()
{
    Start()
    ControlSend,,{w down}{d down}, Skullgirls
    FrameAdvance()
    ControlSend,,{w up}{d up}, Skullgirls
    FrameAdvance()
    ControlSend,,{d down}, Skullgirls
    FrameAdvance()
    ControlSend,,{d up}, Skullgirls 
    Start()
    return
}
FrameAdvance()
{
    ControlSend,,{- down}, Skullgirls
    Sleep 17    
    ControlSend,,{- up}, Skullgirls
    return
}

Start()
{
    ControlSend,,{0 down}, Skullgirls
    Sleep 17
    ControlSend,,{0 up}, Skullgirls
    return
}