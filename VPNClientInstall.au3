#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=Install VPN Silently
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_ProductName=Install VPN Silently
#AutoIt3Wrapper_Res_ProductVersion=1.0.0.0
#AutoIt3Wrapper_Run_Tidy=y
#Tidy_Parameters=/reel
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/mo
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.16.0
	Author:         Cramaboule
	Date:			March 2023

	Script Function: Install VPN Client SoftEther 'Silently'


	Bug: 	Not known

	To do: N/A


	V1.0.0.0	28.03.2023:
				Inital relase

#ce ----------------------------------------------------------------------------

Global $head = '1.0.0.0'

SplashTextOn('Installation of SoftEther is in progress ' & $head, "Please do not touch your computer during installation", 600, 430)

Run('softether-vpnclient-v4.41-9787-rtm-2023.03.14-windows-x86_x64-intel.exe')

WinWaitActive('SoftEther VPN Setup')
Send("{ENTER}")

WinWaitActive('SoftEther VPN Setup', '@D_SW_DEFAULT')
Send("{ENTER}")

WinWaitActive('SoftEther VPN Setup', 'D_SW_EULA')
Send("{TAB}{TAB}{SPACE}{ENTER}")

WinWaitActive('SoftEther VPN Setup', 'D_SW_WARNING')
Send("{ENTER}")

WinWaitActive('SoftEther VPN Setup', 'D_SW_DIR')
Send("{ENTER}")

WinWaitActive('SoftEther VPN Setup', 'D_SW_READY')
Send("{ENTER}")

WinWaitActive('SoftEther VPN Setup', 'D_SW_FINISH')
Send("{ENTER}")

WinWaitActive('SoftEther VPN Client Manager', 'SoftEther VPN Client Manager')
Send("{ALT}TM")

WinWaitActive('Switch SoftEther VPN Client Operating Mode', '')
Send("E{ENTER}")

WinWaitActive('SoftEther VPN Client Easy Manager', '')
ShellExecute('your-vpn-settings.vpn')

WinWaitActive('SoftEther', '')
Send("{ENTER}")

SplashOff()
