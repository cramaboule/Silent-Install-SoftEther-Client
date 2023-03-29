#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=Install VPN Silently
#AutoIt3Wrapper_Res_Fileversion=1.0.0.1
#AutoIt3Wrapper_Res_ProductName=Install VPN Silently
#AutoIt3Wrapper_Res_ProductVersion=1.0.0.1
#AutoIt3Wrapper_Run_Tidy=y
#Tidy_Parameters=/reel
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/mo
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.16.0
	Author:         Cramaboule
	Date:			March 2023

	Script Function: Install VPN Client Silently


	Bug: 	Not known

	To do:

	V1.0.0.1	29.03.2023:
				Added: steps in splash

	V1.0.0.0	28.03.2023:
				Inital relase

#ce ----------------------------------------------------------------------------

Global $head = '1.0.0.1', $Title = 'Installation of SoftEther is in progress '
$sFinalMessage = ''

SplashTextOn($Title & $head, '', 600, 430)
_Splash('Please do not touch your computer during installation' & @CRLF)

Run('softether-vpnclient-v4.41-9787-rtm-2023.03.14-windows-x86_x64-intel.exe')
_Splash('startîng the installation')

WinWaitActive('SoftEther VPN Setup')
Send("{ENTER}")
_Splash('Step 1')

WinWaitActive('SoftEther VPN Setup', '@D_SW_DEFAULT')
Send("{ENTER}")
_Splash('Step 2')

WinWaitActive('SoftEther VPN Setup', 'D_SW_EULA')
Send("{TAB}{TAB}{SPACE}{ENTER}")
_Splash('Step 3')

WinWaitActive('SoftEther VPN Setup', 'D_SW_WARNING')
Send("{ENTER}")
_Splash('Step 4')

WinWaitActive('SoftEther VPN Setup', 'D_SW_DIR')
Send("{ENTER}")
_Splash('Step 5')

WinWaitActive('SoftEther VPN Setup', 'D_SW_READY')
Send("{ENTER}")
_Splash('Installation in process')

WinWaitActive('SoftEther VPN Setup', 'D_SW_FINISH')
Send("{ENTER}")
_Splash('Finished. Still 1 or 2 little things to set up')

WinWaitActive('SoftEther VPN Client Manager', 'SoftEther VPN Client Manager')
Send("{ALT}TM")
_Splash('Set up - step 1')

WinWaitActive('Switch SoftEther VPN Client Operating Mode', '')
Send("E{ENTER}")
_Splash('Set up- step 2')

WinWaitActive('SoftEther VPN Client Easy Manager', '')
ShellExecute('your-vpn-settings.vpn')
_Splash('Set up - step 3')

WinWaitActive('SoftEther', '')
Send("{ENTER}")
_Splash('Set up - step 4')
_Splash('DONE !!!')
Sleep(1000)

SplashOff()

Func _Splash($message)
	$sFinalMessage = $sFinalMessage & $message & @CRLF
	ControlSetText($Title, "", "Static1", $sFinalMessage)
EndFunc   ;==>_Splash
