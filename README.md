# Silent Install SoftEther Client
'Silent' install of SoftEther Client

This script install automatically the SoftEther VPN Client. Modify it as you wish, and compile it or use directly the exe !

It will automaticaly intall / import the files you put in the ```VPNClient.ini``` (.vpn and .exe).

How to make .vpn file and the how to lock the settings:
- Install the client manually on a test machine.
- Make all the settings you wish.
- Export your settings: Connect - Export VPN Connection Setting…
- In the 'Switch operation Mode' set the lock settings with your password (like 123456)
- Go to ```C:\Program Files\SoftEther VPN Client\vpn_client.config``` and look for ```HashedPassword```.
- Copy the Hashed Password into the ini file
- Done

Enjoy.

C.
