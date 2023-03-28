#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\sbg.ico
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=Install VPN Silently
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_ProductName=Install VPN Silently
#AutoIt3Wrapper_Res_ProductVersion=1.0.0.0
#AutoIt3Wrapper_Res_CompanyName=Société Biblique de Genève
#AutoIt3Wrapper_Res_LegalCopyright=2022 Société Biblique de Genève
#AutoIt3Wrapper_Run_Before=WriteTimestamp.exe "%in%"
#AutoIt3Wrapper_Run_Tidy=y
#Tidy_Parameters=/reel
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/mo
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region ;Timestamp =====================
#                     2023/03/28 11:16:27
#EndRegion ;Timestamp =====================
#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.16.0
	Author:         Marc Arm
	Date:			March 2023

	Script Function: Install VPN Client Silently


	Bug: 	Not known

	To do:


	V1.0.0.0	28.03.2023:
				Inital relase

#ce ----------------------------------------------------------------------------

Global $head = '1.0.0.0'

SplashTextOn('Installation de SoftEther en cours ' & $head, "Merci de ne pas toucher votre ordinateur pendant l'installation", 600, 430)

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
ShellExecute('romanel.vpn')

WinWaitActive('SoftEther', '')
Send("{ENTER}")

SplashOff()
