;AT STANFORD TO MAKE F40.DMP, DO:
;	COM XEXEC.MAC,
;	COM FX4=FX1+FX2+FX3+FX4
;	LOAD XEXEC,FX4
;
;**TO MAKE F40.SHR FROM FILES EXEC.MAC,FX1.MAC,FX2.MAC,FX3.MAC,FX4.MAC
;
;**SUBMIT WITH COMMAND .QUEUE I:=F40/RESTART:1/TIME: 0:10:00
;
;**REQUIRED FILES:  (LATEST RELEASED VERSION)
;
;[10,7]PIP.SHR
;	TECO.SHR
;	DIRECT.SHR
;	COMPIL.SHR
;	MACRO.SHR
;	LOADER.SHR
;	JOBDAT.REL
;	CREF.SHR
;
;[SELF]	EXEC.MAC
;	FX1.MAC
;	FX2.MAC
;	FX3.MAC
;	FX4.MAC
;
;**OUTPUT FILES
;
;	F40.SHR
;	F40.MAP
;	EXEC.LST
;	F40.LST
;	F40.LOG
;
;**COPY FILES FROM [10,7] AND USE PRIVATE "SYS:"
;
.RUN DSK:PIP[10,7]
*/X/B_[10,7]PIP.SHR,COMPIL.SHR,MACRO.SHR,LOADER.SHR
*/X/B_[10,7]JOBDAT.REL,CREF.SHR,TECO.SHR
;
;
;**MAKE A RECORD
;
.SET WATCH VERSION
.IF (NOERROR) .GOTO A
;
;
A:.RUN DSK:DIRECT[10,7]
*TTY:/CHECKSUM=*.SHR
*TTY:/CHECKSUM=*.MAC,*.REL,*.CTL,*.DOC
;
;**READY TO GO
;
.ASSIGN DSK:SYS
;
;**COMPILE ,LOAD AND SAVE MAKING MAP,CREF AND SHR FILES
;
.MAKE REENTR.MAC
*IREENTR=0
	 EX�!	 
.COMPILE /C REENTR+<EXEC.MAC>
.COMPILE /C REENTR+<FX4.MAC,FX1.MAC+FX2.MAC+FX3.MAC>
;
.LOAD /MAP:F40 EXEC.REL,FX4.REL,FX3.REL
.SSAVE DSK:F40
.VERSION
.IF (ERROR) .E 137
;
;TRY IT
;
.RUN DSK:F40
;
;**CHECKSUM DIRECTORY OF SAVE FILES
;
.RUN DSK:DIRECT[10,7]
*TTY:/CHECKSUM=F40.SHR
;
;**MAKE THE LISTINGS
;
.RUN DSK:CREF
*DSK:EXEC.LST_DSK:EXEC.CRF
*DSK:F40.LST_DSK:FX3.CRF,DSK:FX4.CRF
;
;.QUEUE F40.MAP,EXEC.LST,F40.LST
.PLEASE F40 SUCCESSFUL
;
;**DELETE ALL TEMPORARY FILES
;
%FIN: .DELETE EXEC.REL,FX3.REL,FX4.REL,MACRO.SHR,LOADER.SHR,CREF.SHR
.DELETE PIP.SHR,TECO.SHR,JOBDAT.REL,COMPIL.SHR