#NoEnv
SendMode, Input
SetWorkingDir %A_ScriptDir%

StringToSend := "A"

file := FileOpen("C:\ProgramData\ZRazer\Macropad\callName.rz", "r")
TargetScriptTitle := file.ReadLine()
file.Close()
Send_WM_COPYDATA(StringToSend, TargetScriptTitle)
ExitApp
Send_WM_COPYDATA(ByRef StringToSend, ByRef TargetScriptTitle)
{
    VarSetCapacity(CopyDataStruct, 3*A_PtrSize, 0)
    SizeInBytes := (StrLen(StringToSend) + 1) * (A_IsUnicode ? 2 : 1)
    NumPut(SizeInBytes, CopyDataStruct, A_PtrSize) 
    NumPut(&StringToSend, CopyDataStruct, 2*A_PtrSize)
    Prev_DetectHiddenWindows := A_DetectHiddenWindows
    Prev_TitleMatchMode := A_TitleMatchMode
    DetectHiddenWindows On
    SetTitleMatchMode 2
    SendMessage, 0x4a, 0, &CopyDataStruct,, %TargetScriptTitle%
}