REM ====================  F186 FT Auto Upload STDF&TXT START  ====================
C:
cd C:\STDF\F186\
if not exist Backup_gzip mkdir Backup_gzip
if not exist Backup_To_Tango mkdir Backup_To_Tango
if not exist Backup_To_Server mkdir Backup_To_Server
if not exist Backup_To_IT mkdir Backup_To_IT
move *.std  .\Backup_gzip\
move *.txt  .\Backup_gzip\
move I_*  .\Backup_gzip\
cd Backup_gzip
gzip -f *.std
gzip -f *.txt
REM --------------------  Gzip STDF&TXT file finish  --------------------
move C:\STDF\F186\Backup_gzip\*CORD*.std.gz C:\STDF\F186\Backup_To_Server
move C:\STDF\F186\Backup_gzip\*HWD*.std.gz C:\STDF\F186\Backup_To_Server
copy C:\STDF\F186\Backup_gzip\*.std.gz C:\STDF\F186\Backup_To_Server
move C:\STDF\F186\Backup_gzip\*.std.gz C:\STDF\F186\Backup_To_Tango
copy C:\STDF\F186\Backup_gzip\I_* C:\STDF\F186\Backup_To_IT
move C:\STDF\F186\Backup_gzip\*.txt.gz C:\STDF\F186\Backup_To_Server
if not exist C:\STDF\ncftpput.exe copy O:\Scheduler\ncftpput.exe C:\STDF\
C:\STDF\ncftpput -u j750 -p j750 172.17.3.253 /PE2DATALOG/F186_FT C:\STDF\F186\Backup_To_Server\*.std.gz
C:\STDF\ncftpput -u j750 -p j750 -DD 172.17.3.253 /PE2DATALOG/F186_FT_TXT C:\STDF\F186\Backup_To_Server\*.txt.gz
C:\STDF\ncftpput -u loader -p loader -DD 192.168.1.21 /testerdata/F186/STDF/SGH/FT C:\STDF\F186\Backup_To_Tango\*.std.gz
C:\STDF\ncftpput -u j750 -p j750 -DD 172.17.3.253 /PE2DATALOG/F186_FT C:\STDF\F186\Backup_gzip\I_*
C:\STDF\ncftpput -u lantiq_sg -p vkrXq9_D -DD 192.168.1.76 /EQC/J750 C:\STDF\F186\Backup_To_IT\I_*BE1P*
C:\STDF\ncftpput -u asipe2 -p asi555pe2 -DD 192.168.1.5 /customer/F186/FT/INFO C:\STDF\F186\Backup_To_IT\I_*
REM --------------------  Upload STDF&TXT file finish  --------------------
REM ====================  F186 FT Auto Upload STDF&TXT END  ====================