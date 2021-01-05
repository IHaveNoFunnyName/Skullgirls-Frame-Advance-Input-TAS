#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Gui, InputWindow:New,, Wau
Gui, Add, Button, gAirdash, Airdash
Gui, Show

MacroInput := [["w"],["j","k"]]
MacroInput[15] := ["l"]
global Macro := SparseToRich(MacroInput)

Airdash() {
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