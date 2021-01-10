#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#include Gdip_All.ahk

Gui, InputWindow:New,, Tool Assisted Inputs
Gui, Add, Button, gPlay, Play
Gui, Show

global mdelay1 := 10
global mdelay2 := 30
global isdelay1 := 0
global isdelay2 := 0
global delay1 := 0
global delay2 := 0
global loopindex := 0
global enddelay := 10
global MacroInput := Array()
Loop, Read, %A_ScriptDir%\input.txt
{
    line := A_LoopReadLine
    split := StrSplit(line, " ")
    index := split[1]
    inputs := {"length": split[2], "keys": StrSplit(split[3])}
    while(MacroInput.HasKey(index)) {
        index := index "a"
    }
    dindex := RegExReplace(index, "\D")
    if InStr(index, "+") {  
        MacroInput[dindex + mdelay1] := []
        isdelay1 := 1
    }
    if InStr(index, "~") {
        MacroInput[dindex + mdelay2] := []
        isdelay2 := 1
    }
    MacroInput[index] := inputs
}
global Macro

Play() {
    pToken := Gdip_Startup()
    Start()
    Loop % mdelay1 + 1 {
        delay1 := A_index - 1
        FileCreateDir % "./"  delay1
        Reset()
        for index, element in Macro {
            loopindex := index
            DoInput(element) 
        }
    }
    End()
    Gdip_Shutdown(pToken)
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
    WinGet, hwnd, ID, Skullgirls
    pBitmap := Gdip_BitmapFromHWND(hwnd)
    filename := "./" delay1 "/" . loopindex . ".png"
    Gdip_SaveBitmapToFile(pBitmap, filename)
    Gdip_DisposeImage(pBitmap)
    Sleep 32
    ControlSend,,{- up}, Skullgirls
    return
}

Start() {
    ControlSend,,{0 down}, Skullgirls
    Sleep 17
    ControlSend,,{0 up}, Skullgirls
    return
}

End() {
    Start()
}

Reset() {
    ControlSend,,{LCtrl down}, Skullgirls
    loopindex := 0
    FrameAdvance()
    ControlSend,,{LCtrl up}, Skullgirls
    Macro := SparseToRich(MacroInput)
    return
}

SparseToRich(sparse) {
    rich := []
    Loop % sparse.MaxIndex() + enddelay {
        rich[A_index] := []
    }
    for index, element in sparse
    {
        if element.Length
        {
            dindex := RegExReplace(index, "\D")
            if (InStr(index, "+")) {
                dindex += delay1
            } else if (InStr(index, "~")) {
                dindex += delay2
            }
            length := element["length"]
            keys := element["keys"]
            i := 0
            while i < length
            {
                rindex := dindex + i
                if (!rich.HasKey(rindex)) {
                    rich[rindex] := []
                }
                rich[rindex].Push(keys*)
                i++
            }
        }
    }
    return rich
}