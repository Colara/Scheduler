@echo off

REM ====================  F186 FT Auto Upload STDF&TXT START  ====================
C: >> F186_debug.log
cd C:\STDF\F186\ >> F186_debug.log
if not exist Backup_gzip mkdir Backup_gzip >> F186_debug.log
if not exist Backup_To_Tango mkdir Backup_To_Tango >> F186_debug.log
if not exist Backup_To_Server mkdir Backup_To_Server >> F186_debug.log
if not exist Backup_To_IT mkdir Backup_To_IT >> F186_debug.log
move *.std  .\Backup_gzip\ >> F186_debug.log
move *.txt  .\Backup_gzip\ >> F186_debug.log
move I_*  .\Backup_gzip\ >> F186_debug.log
cd Backup_gzip >> F186_debug.log
gzip -f *.std >> F186_debug.log
gzip -f *.txt >> F186_debug.log
REM --------------------  Gzip STDF&TXT file finish  --------------------
move C:\STDF\F186\Backup_gzip\*CORD*.std.gz C:\STDF\F186\Backup_To_Server >> F186_debug.log
move C:\STDF\F186\Backup_gzip\*HWD*.std.gz C:\STDF\F186\Backup_To_Server >> F186_debug.log
copy C:\STDF\F186\Backup_gzip\*.std.gz C:\STDF\F186\Backup_To_Server >> F186_debug.log
move C:\STDF\F186\Backup_gzip\*.std.gz C:\STDF\F186\Backup_To_Tango >> F186_debug.log
copy C:\STDF\F186\Backup_gzip\I_* C:\STDF\F186\Backup_To_IT >> F186_debug.log
move C:\STDF\F186\Backup_gzip\*.txt.gz C:\STDF\F186\Backup_To_Server >> F186_debug.log
if not exist C:\STDF\ncftpput.exe copy O:\Scheduler\ncftpput.exe C:\STDF\ >> F186_debug.log
C:\STDF\ncftpput -u j750 -p j750 -DD -d O:\Scheduler\ncftpLog\debug.log 172.17.3.253 /PE2DATALOG/F186_FT C:\STDF\F186\Backup_To_Server\*.std.gz >> F186_debug.log
C:\STDF\ncftpput -u j750 -p j750 -DD -d O:\Scheduler\ncftpLog\debug.log 172.17.3.253 /PE2DATALOG/F186_FT_TXT C:\STDF\F186\Backup_To_Server\*.txt.gz >> F186_debug.log
C:\STDF\ncftpput -u loader -p loader -DD -d O:\Scheduler\ncftpLog\debug.log 192.168.1.21 /testerdata/F186/STDF/SGH/FT C:\STDF\F186\Backup_To_Tango\*.std.gz >> F186_debug.log
C:\STDF\ncftpput -u j750 -p j750 -DD 172.17.3.253 /PE2DATALOG/F186_FT C:\STDF\F186\Backup_gzip\I_* >> F186_debug.log
C:\STDF\ncftpput -u lantiq_sg -p vkrXq9_D -DD 192.168.1.76 /EQC/J750 C:\STDF\F186\Backup_To_IT\I_*BE1P* >> F186_debug.log
C:\STDF\ncftpput -u asipe2 -p asi555pe2 -DD 192.168.1.5 /customer/F186/FT/INFO C:\STDF\F186\Backup_To_IT\I_* >> F186_debug.log
REM --------------------  Upload STDF&TXT file finish  --------------------
REM ====================  F186 FT Auto Upload STDF&TXT END  ====================