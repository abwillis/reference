/****************************************************************************/
/* Name:                                                                    */
/* Type: Object REXX Script                                                 */
/* Author:   Andy Willis                                                    */
/* Resource:                                                                */
/*                                                                          */
/* Description:  Windows 7 initial setup                                    */
/*                                                                          */
/* Copyright (C) _Andy Willis________, 2013-2015. All Rights Reserved.      */
/*                                                                          */
/****************************************************************************/

/* main program */
call RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
call SysLoadFuncs

curdir = directory()
rc = directory("C:\temp")
'wmic /output:sn.txt bios get serialnumber'
'type sn.txt >sn1.txt'
'del sn.txt'
'ren sn1.txt sn.txt'
'wmic computersystem get caption >caption.txt'
'type caption.txt >caption1.txt'
'del caption.txt'
'ren caption1.txt caption.txt'
call stream "sn.txt",c,'open read'
call stream "caption.txt",c,'open read'
Parse value LineIn("sn.txt",2) with SN
Caption=LineIn("caption.txt",2)
rc = directory(curdir)
SN=strip(SN,b)
computername = 'IBM-'Space(SN,0)
say computername
parse value Space(computername,0) with cn
say 'wmic computersystem where caption="'Space(caption,0)'" rename "'computername'"'
'wmic computersystem where caption="'Space(caption,0)'" rename "'computername'"'
'"\Program Files (x86)\Lenovo\Access Connections\QcTray.exe" /imp c:\accounts\base\template.loc'