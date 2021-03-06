REM ====================  F098 CP Auto Upload STDF&TXT START  ====================
C:
cd C:\j750\STDF\CP\F098\
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
copy C:\j750\STDF\CP\F098\Backup_gzip\*.std.gz C:\j750\STDF\CP\F098\Backup_To_Tango
move C:\j750\STDF\CP\F098\Backup_gzip\*.std.gz C:\j750\STDF\CP\F098\Backup_To_Server
copy C:\j750\STDF\CP\F098\Backup_gzip\*.txt.gz C:\j750\STDF\CP\F098\Backup_To_IT
move C:\j750\STDF\CP\F098\Backup_gzip\*.txt.gz C:\j750\STDF\CP\F098\Backup_To_Server
if not exist C:\j750\STDF\CP\ncftpput.exe copy O:\Scheduler\ncftpput.exe C:\j750\STDF\CP\
C:\j750\STDF\CP\ncftpput -u j750 -p j750 -DD 172.17.3.253 /PE2DATALOG/F098_CP C:\j750\STDF\CP\F098\Backup_To_Server\*.std.gz
C:\j750\STDF\CP\ncftpput -u j750 -p j750 -DD 172.17.3.253 /PE2DATALOG/F098_CP_TXT C:\j750\STDF\CP\F098\Backup_To_Server\*.txt.gz
C:\j750\STDF\CP\ncftpput -u loader -p loader -DD 192.168.1.21 /testerdata/F098/STDF/SGH/CP/ C:\j750\STDF\CP\F098\Backup_To_Tango\*.std.gz
C:\j750\STDF\CP\ncftpput -u sghpe2 -p sgh555pe2 -DD 192.168.1.76 /FTDataLog/J750/F098 C:\j750\STDF\CP\F098\Backup_To_IT\*.txt.gz
REM --------------------  Upload STDF&TXT file finish  --------------------
REM ====================  F098 CP Auto Upload STDF&TXT END  ====================