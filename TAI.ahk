#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Gui, InputWindow:New,, Tool Assisted Inputs
Gui, Add, Button, gPlay, Play
Gui, Show

MacroInput := Array()
Loop, Read, %A_ScriptDir%\input.txt
{
    line := A_LoopReadLine
    split := StrSplit(line, " ")
    index := split[1]
    inputs := StrSplit(split[2])
    MacroInput[index] := inputs
}
global Macro := SparseToRich(MacroInput)

Play() {
    Start()
    for index, element in Macro {
        DoInput(element) 
    }
    Start()
    return
}

DoInput(array) {
    for index, key in array {
        ControlSend,,{%key% down}, Skullgirls
    }
    FrameAdvance()
    for index, key in array {
        ControlSend,,{%key% up}, Skullgirls
    } 
}

FrameAdvance() {
    ControlSend,,{- down}, Skullgirls
    Sleep 17    
    ControlSend,,{- up}, Skullgirls
    return
}

Start() {
    ControlSend,,{0 down}, Skullgirls
    Sleep 17
    ControlSend,,{0 up}, Skullgirls
    return
}

SparseToRich(sparse) {
    rich := []
    Loop % sparse.MaxIndex() {
        if sparse.HasKey(A_index) {
            rich[A_index] := sparse[A_index]
        } else {
            rich[A_index] := []
        }
    }
    return rich
}