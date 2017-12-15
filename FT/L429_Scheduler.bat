REM ====================  L429 FT Auto Upload STDF&TXT START  ====================
C:
cd C:\STDF\L429\
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
move C:\STDF\L429\Backup_gzip\*.std.gz C:\STDF\L429\Backup_To_Server
move C:\STDF\L429\Backup_gzip\*.txt.gz C:\STDF\L429\Backup_To_Server
if not exist C:\STDF\ncftpput.exe copy O:\Scheduler\ncftpput.exe C:\STDF\
C:\STDF\ncftpput -u j750 -p j750 -DD 172.17.3.253 /PE2DATALOG/L429_FT C:\STDF\L429\Backup_To_Server\*.std.gz
C:\STDF\ncftpput -u j750 -p j750 -DD 172.17.3.253 /PE2DATALOG/L429_FT_TXT C:\STDF\L429\Backup_To_Server\*.txt.gz
REM --------------------  Upload STDF&TXT file finish  --------------------
REM ====================  L429 FT Auto Upload STDF&TXT END  ====================