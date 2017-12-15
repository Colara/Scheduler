REM ====================  F097 CP Auto Upload STDF&TXT START  ====================
C:
cd C:\j750\STDF\CP\F097\
if not exist Backup_gzip mkdir Backup_gzip
if not exist Backup_To_Tango mkdir Backup_To_Tango
if not exist Backup_To_Server mkdir Backup_To_Server
if not exist Backup_To_IT mkdir Backup_To_IT
move *.std  .\Backup_gzip\
move *.txt  .\Backup_gzip\
move I_*  .\Backup_To_IT\
cd Backup_gzip
gzip -f *.std
gzip -f *.txt
REM --------------------  Gzip STDF&TXT file finish  --------------------
copy C:\j750\STDF\CP\F097\Backup_gzip\*.std.gz C:\j750\STDF\CP\F097\Backup_To_Tango
move C:\j750\STDF\CP\F097\Backup_gzip\*.std.gz C:\j750\STDF\CP\F097\Backup_To_Server
move C:\j750\STDF\CP\F097\Backup_gzip\*.txt.gz C:\j750\STDF\CP\F097\Backup_To_Server
if not exist C:\j750\STDF\CP\ncftpput.exe copy O:\Scheduler\ncftpput.exe C:\j750\STDF\CP\
C:\j750\STDF\CP\ncftpput -u j750 -p j750 -DD 172.17.3.253 /PE2DATALOG/F097_CP C:\j750\STDF\CP\F097\Backup_To_Server\*.std.gz
C:\j750\STDF\CP\ncftpput -u j750 -p j750 -DD 172.17.3.253 /PE2DATALOG/F097_CP_TXT C:\j750\STDF\CP\F097\Backup_To_Server\*.txt.gz
C:\j750\STDF\CP\ncftpput -u loader -p loader -DD 192.168.1.21 /testerdata/F097/STDF/SGH/CP/ C:\STDF\CP\F097\Backup_To_Tango\*.std.gz
C:\j750\STDF\CP\ncftpput -u lantiq_sg -p vkrXq9_D -DD 192.168.1.76 /F097/STDF/CP C:\j750\STDF\CP\F097\Backup_To_IT\I_*
REM --------------------  Upload STDF&TXT file finish  --------------------
REM ====================  F097 CP Auto Upload STDF&TXT END  ====================