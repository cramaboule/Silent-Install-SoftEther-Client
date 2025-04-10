#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_ProductName=Install VPN Silently
#AutoIt3Wrapper_Res_Description=Install VPN Silently
#AutoIt3Wrapper_Res_Fileversion=1.0.2.0
#AutoIt3Wrapper_Res_ProductName=Install VPN Silently
#AutoIt3Wrapper_Res_ProductVersion=1.0.2.0
#AutoIt3Wrapper_Run_Tidy=y
#Tidy_Parameters=/reel
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/mo
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.16.1
	Author:         Cramaboule
	Date:			March 2023

	Script Function: Install VPN Client Silently


	Bug: 		Not known

	To do: 		Nothing

	V1.0.2.0	10.04.2025:
				Added Locked settings as request from atppackging (github.com)
	V1.0.1.0	31.12.2024:
				New way of install

	V1.0.0.2	29.08.2024:
				Added: Ini File for exe
				Modified: Initial install or Update prg

	V1.0.0.1	29.03.2023:
				Added: steps in splash

	V1.0.0.0	28.03.2023:
				Inital relase

#ce ----------------------------------------------------------------------------

#include <String.au3>
#include <Array.au3>
#include <WinAPISysWin.au3>
#include <WindowsConstants.au3>
#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>

Global $head = '1.0.2.0', $Title = 'Installation de SoftEther en cours '
Global $sIniFile = @ScriptDir & '\VPNClient.ini', $step = 0
$sFinalMessage = ''

SplashTextOn($Title & $head, '', 600, 430)
_Splash("Merci de ne pas toucher votre ordinateur pendant l'installation" & @CRLF)
;~ Sleep(1000)

$sSoft = IniRead($sIniFile, 'VPN', 'exe', 'vpn-client.exe')
Run($sSoft)
If @error Then
	SplashOff()
	MsgBox(64, 'Error', 'Exe file not found!')
	Exit
EndIf
_Splash("lancement de l'installation")

_WaitAndClick('SoftEther VPN Setup', 'D_SW_WELCOME', 12324)
$step += 1
_Splash('Installation step ' & $step)

_WaitAndClick('SoftEther VPN Setup', '@D_SW_DEFAULT', 12324)
$step += 1
_Splash('Installation step ' & $step)

WinWait('SoftEther VPN Setup', 'D_SW_EULA')
$handle = ControlGetHandle('', '', 12324)
If BitAND(_WinAPI_GetWindowLong($handle, $GWL_STYLE), $WS_DISABLED) Then
	; check the agreements
	_WaitAndClick('SoftEther VPN Setup', 'D_SW_EULA', 1285)
EndIf
_WaitAndClick('SoftEther VPN Setup', 'D_SW_EULA', 12324)
$step += 1
_Splash('Installation step ' & $step)

_WaitAndClick('SoftEther VPN Setup', 'D_SW_WARNING', 12324)
$step += 1
_Splash('Installation step ' & $step)

_WaitAndClick('SoftEther VPN Setup', 'D_SW_DIR', 12324)
$step += 1
_Splash('Installation step ' & $step)

_WaitAndClick('SoftEther VPN Setup', 'D_SW_READY', 12324)
_Splash('Installation en cours')

_WaitAndClick('SoftEther VPN Setup', 'D_SW_FINISH', 12325)

_Splash('Installation Finie. Parametrage en cours...')
$step = 1
_Splash('Parametrage en cours...' & $step)

RunWait(@ComSpec & ' /c ' & '"C:\Program Files\SoftEther VPN Client\vpncmd_x64.exe" localhost /client /cmd:NicDelete VPN', @SystemDir, @SW_HIDE)
RunWait(@ComSpec & ' /c ' & '"C:\Program Files\SoftEther VPN Client\vpncmd_x64.exe" localhost /client /cmd:NicDelete VPN', @SystemDir, @SW_HIDE)         ; 2x
RunWait(@ComSpec & ' /c ' & '"C:\Program Files\SoftEther VPN Client\vpncmd_x64.exe" localhost /client /cmd:NicCreate VPN', @SystemDir, @SW_HIDE)
RunWait(@ComSpec & ' /c ' & 'powershell -Command "Set-NetIpInterface -InterfaceAlias ' & Chr(39) & 'VPN - VPN Client' & Chr(39) & ' -InterfaceMetric 250"', @SystemDir, @SW_HIDE) ; make all the internet traffic to the client and not through the VPN
$step += 1
_Splash('Parametrage en cours...' & $step)

$cmd = '"C:\Program Files\SoftEther VPN Client\vpncmd_x64.exe"'
$para = 'localhost /client /cmd:AccountDelete vpn'
ShellExecuteWait($cmd, $para, '', '', @SW_HIDE)
ShellExecuteWait($cmd, $para, '', '', @SW_HIDE) ; 2x
$sVPN = IniRead($sIniFile, 'VPN', 'vpn', 'vpn.vpn')
$sVPN = @ScriptDir & '\' & $sVPN
If Not (FileExists($sVPN)) Then
	SplashOff()
	MsgBox(64, 'Error', 'VPN file not found!')
	Exit
EndIf
$para = 'localhost /client /cmd:AccountImport "' & $sVPN & '"'
ShellExecuteWait($cmd, $para, '', '', @SW_HIDE)

RunWait(@ComSpec & ' /c ' & 'sc stop SEVPNCLIENT', @SystemDir, @SW_HIDE)
$step += 1
_Splash('Parametrage en cours...' & $step)

; search to change change in config easymode to true
; but we need to make sure the service is stopped and the file is readable
_WaitService('SEVPNCLIENT', 'STOPPED')

$sFile = 'C:\Program Files\SoftEther VPN Client\vpn_client.config'

RunWait(@ComSpec & ' /c ICACLS "' & $sFile & '" /reset /T', @SystemDir, @SW_HIDE)
$hFile = FileOpen($sFile)
$sFileContent = FileRead($hFile)
FileClose($hFile)
$sFileContent = StringReplace($sFileContent, 'bool EasyMode false', 'bool EasyMode true')
$sFileContent = _LockMode($sIniFile, $sFileContent)
$step += 1
_Splash('Parametrage en cours...' & $step)

$hdleFile = FileOpen($sFile, 2)
If Not $hdleFile Then
	SplashOff
	FileClose($hdleFile)
	MsgBox($MB_OK + $MB_ICONERROR + $MB_TOPMOST, 'ERROR', 'ERROR cannot oppening in writing mode config file: ' & $hdleFile)
	Exit
EndIf
$bwrite = FileWrite($hdleFile, $sFileContent)
If Not ($bwrite) Then
	FileClose($hdleFile)
	MsgBox($MB_OK + $MB_ICONERROR + $MB_TOPMOST, 'ERROR', 'ERROR writing config:' & $bwrite)
	Exit
EndIf
FileClose($hdleFile)

$step += 1
_Splash('Parametrage en cours...' & $step)
RunWait(@ComSpec & ' /c ' & 'sc start SEVPNCLIENT', @SystemDir, @SW_HIDE)
_WaitService('SEVPNCLIENT', 'RUNNING')

ShellExecute('"C:\Program Files\SoftEther VPN Client\vpncmgr_x64.exe"', '', '"C:\Program Files\SoftEther VPN Client')

_Splash('FIN !!!')
Sleep(1000)
SplashOff()
Exit

Func _Splash($message)
	$sFinalMessage = $sFinalMessage & $message & @CRLF
	ControlSetText($Title, "", "Static1", $sFinalMessage)
EndFunc   ;==>_Splash

Func _WaitAndClick($sTitle, $sText, $nControlID)
	$hwd = WinWait($sTitle, $sText)
	ControlClick($hwd, '', $nControlID)
EndFunc   ;==>_WaitAndClick

Func _WaitService($s_ServiceName, $s_State)
	Local $data
	If ($s_State <> 'RUNNING' And $s_State <> 'STOPPED') Then Return -1
	Do
		Sleep(100)
		$data = ''
		$pid = Run(@ComSpec & ' /c sc query ' & $s_ServiceName, @SystemDir, @SW_HIDE, $STDERR_MERGED)
		Do
			$data &= StdoutRead($pid)
		Until @error
	Until StringInStr($data, $s_State)
	Return $data
EndFunc   ;==>_WaitService

Func _LockMode($__IniFile, $__sFileContent)
	Local $__sPassword = IniRead($__IniFile, 'lock', 'HashedPassword', '')
	If $__sPassword <> '' Then
		$__sFileContent = StringReplace($__sFileContent, 'bool LockMode false', 'bool LockMode true')
		Local $sRegex = "(?m)^(.*)HashedPassword(.*)$"
		Local $aArray = StringRegExp($__sFileContent, $sRegex, $STR_REGEXPARRAYFULLMATCH)
		If @error = 0 Then
			ConsoleWrite($aArray[0] & @CRLF) ; full line
			ConsoleWrite($aArray[2] & @CRLF) ; pwd (with space at the begining)
			$__sFileContent = StringReplace($__sFileContent, $aArray[2], ' ' & $__sPassword)
		Else
			$__sFileContent = StringReplace($__sFileContent, 'bool LockMode true', 'bool LockMode true' & @CRLF & @TAB & @TAB & 'byte HashedPassword ' & $__sPassword)
		EndIf
	Else
		$__sFileContent = StringReplace($__sFileContent, 'bool LockMode true', 'bool LockMode false')
	EndIf
	Return $__sFileContent
EndFunc   ;==>_LockMode
