REM ====================  L050 CP Autoupload STDF&TXT START  ====================
C:
cd C:\j750\STDF\CP\L050\
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
copy C:\j750\STDF\CP\L050\Backup_gzip\*.std.gz C:\j750\STDF\CP\L050\Backup_To_IT
move C:\j750\STDF\CP\L050\Backup_gzip\*.std.gz C:\j750\STDF\CP\L050\Backup_To_Server
copy C:\j750\STDF\CP\L050\Backup_gzip\*.txt.gz C:\j750\STDF\CP\L050\Backup_To_IT
move C:\j750\STDF\CP\L050\Backup_gzip\*.txt.gz C:\j750\STDF\CP\L050\Backup_To_Server
if not exist C:\j750\STDF\CP\ncftpput.exe copy O:\Scheduler\ncftpput.exe C:\j750\STDF\CP\
C:\j750\STDF\CP\ncftpput -u j750 -p j750 -DD 172.17.3.253 /PE2DATALOG/L050_CP C:\j750\STDF\CP\L050\Backup_To_Server\*.std.gz
C:\j750\STDF\CP\ncftpput -u j750 -p j750 -DD 172.17.3.253 /PE2DATALOG/L050_CP_TXT C:\j750\STDF\CP\L050\Backup_To_Server\*.txt.gz
O:\SUM\ncftpput -u sghpe2 -p sgh555pe2 -DD 192.168.1.70 /L050/CP_Datalog C:\j750\STDF\CP\L050\Backup_To_IT\*.txt.gz
O:\SUM\ncftpput -u sghpe2 -p sgh555pe2 -DD 192.168.1.70 /L050/CP_Datalog C:\j750\STDF\CP\L050\Backup_To_IT\*.std.gz
REM --------------------  Upload STDF&TXT file finish  --------------------
REM ====================  L050 CP Autoupload STDF&TXT END  ====================