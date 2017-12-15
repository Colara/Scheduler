REM ====================  L291 FT Auto Upload STDF&TXT START  ====================
C:
cd C:\STDF\L291\
if not exist Backup_gzip mkdir Backup_gzip
if not exist Backup_To_Tango mkdir Backup_To_Tango
if not exist Backup_To_Server mkdir Backup_To_Server
if not exist Backup_To_IT mkdir Backup_To_IT
move *.std  .\Backup_gzip\
move *.txt  .\Backup_gzip\
cd Backup_gzip
gzip -f *.std
gzip -f *.txt
REM --------------------  Gzip STDF&TXT file finish  --------------------
move C:\STDF\L291\Backup_gzip\*CORD*.std.gz C:\STDF\L291\Backup_To_Server
move C:\STDF\L291\Backup_gzip\*EQCD*.std.gz C:\STDF\L291\Backup_To_Server
move C:\STDF\L291\Backup_gzip\*HWD*.std.gz C:\STDF\L291\Backup_To_Server
copy C:\STDF\L291\Backup_gzip\*.std.gz C:\STDF\L291\Backup_To_Server
move C:\STDF\L291\Backup_gzip\*.std.gz C:\STDF\L291\Backup_To_Tango
move C:\STDF\L291\Backup_gzip\*.txt.gz C:\STDF\L291\Backup_To_Server
if not exist C:\STDF\ncftpput.exe copy O:\Scheduler\ncftpput.exe C:\STDF\
C:\STDF\ncftpput -u j750 -p j750 -DD 172.17.3.253 /PE2DATALOG/L291_FT C:\STDF\L291\Backup_To_Server\*.std.gz
C:\STDF\ncftpput -u j750 -p j750 -DD 172.17.3.253 /PE2DATALOG/L291_FT_TXT C:\STDF\L291\Backup_To_Server\*.txt.gz
C:\STDF\ncftpput -u sghpe2 -p sgh555pe2 -DD 192.168.1.70 /L291 C:\STDF\L291\Backup_To_IT\*.txt.gz
C:\STDF\ncftpput -u loader -p loader -DD 192.168.1.21 /testerdata/L291/STDF/SGH/FT C:\STDF\L291\Backup_To_Tango\*.std.gz
REM --------------------  Upload STDF&TXT file finish  --------------------
REM ====================  L291 FT Auto Upload STDF&TXT END  ====================