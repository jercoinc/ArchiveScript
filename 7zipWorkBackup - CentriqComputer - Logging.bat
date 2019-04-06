@echo off

@echo 7zipWorkBackup.bat ...


@echo off
@echo Setting Variables...
@echo. 
REM Set Path Variables
set FilesPathMove=C:\7zipBackup\Scripts\MoveList.lst
set FilesPathKeep=C:\7zipBackup\Scripts\KeepList.lst
set SevenZip=C:\7zipBackup\7-Zip\7z.exe
set ArchivePath=E:\
set TempArchivePath=C:\7zipBackup\TempArchives
set LogPath=C:\7zipBackup\Logs

REM Set Name Variables
set ArchiveFileNameKeep=WorkArchiveFilesKept
set ArchiveFileNameMove=WorkArchiveFilesMoved
set LogName=WorkArchive


REM Set Date Time Variables
set TodaysDate=%date:~-10,2%/%date:~-7,2%/%date:~-4%
set DateYear=%date:~10%
set DateMonth=%date:~4,2%
set DateDay=%date:~7,2%
set TimeHour=%time:~0,2%
set TimeMin=%time:~3,2%
set TimeSec=%time:~6,2%
set DateYear=%DateYear: =0%
set DateMonth=%DateMonth: =0%
set DateDay=%DateDay: =0%
set TimeHour=%TimeHour: =0%
set TimeMin=%TimeMin: =0%
set TimeSec=%TimeSec: =0%

REM A Holiday file is something I have used in the past
REM I am not using it in this script example

REM Exit if today is a holiday
REM @echo Check if it's a holiday... 
REM for /F "tokens=1-2" %%I in (C:\holiday.txt) do (
REM   if "%TodaysDate%" == "%%I" goto :END
REM )

REM Zip Data Folders
@echo Archiving files that need to be moved...
@echo.   
@echo ============================================== >> "%LogPath%\%LogName%_%DateYear%-%DateMonth%-%DateDay%_%TimeHour%-%TimeMin%.log"
@echo === Archiving Files That Need to Be Moved. === >> "%LogPath%\%LogName%_%DateYear%-%DateMonth%-%DateDay%_%TimeHour%-%TimeMin%.log"
@echo ============================================== >> "%LogPath%\%LogName%_%DateYear%-%DateMonth%-%DateDay%_%TimeHour%-%TimeMin%.log"
%SevenZip% a -r -sdel -tzip -spf -mx9 -mmt "%TempArchivePath%\%ArchiveFileNameMove%_%DateYear%-%DateMonth%-%DateDay%_%TimeHour%-%TimeMin%.zip" @"%FilesPathMove%" -bb >> "%LogPath%\%LogName%_%DateYear%-%DateMonth%-%DateDay%_%TimeHour%-%TimeMin%.log"


@echo.   
@echo Move archive to storage drive...
@echo.   
move "%TempArchivePath%\%ArchiveFileNameMove%_%DateYear%-%DateMonth%-%DateDay%_%TimeHour%-%TimeMin%.zip" "%ArchivePath%"

@echo Archiving files that need to be backed up...
@echo.   
@echo ================================================== >> "%LogPath%\%LogName%_%DateYear%-%DateMonth%-%DateDay%_%TimeHour%-%TimeMin%.log"
@echo === Archiving Files That Need to Be Backed Up. === >> "%LogPath%\%LogName%_%DateYear%-%DateMonth%-%DateDay%_%TimeHour%-%TimeMin%.log"
@echo ================================================== >> "%LogPath%\%LogName%_%DateYear%-%DateMonth%-%DateDay%_%TimeHour%-%TimeMin%.log"
%SevenZip% a  -r -tzip -spf -mx9 -mmt "%TempArchivePath%\%ArchiveFileNameKeep%_%DateYear%-%DateMonth%-%DateDay%_%TimeHour%-%TimeMin%.zip" @"%FilesPathKeep%" -bb >> "%LogPath%\%LogName%_%DateYear%-%DateMonth%-%DateDay%_%TimeHour%-%TimeMin%.log"

@echo.   
@echo Move archive to storage drive...
@echo.   
move "%TempArchivePath%\%ArchiveFileNameKeep%_%DateYear%-%DateMonth%-%DateDay%_%TimeHour%-%TimeMin%.zip" "%ArchivePath%"

@echo.   
@echo Remove old Archive Files...
@echo.   
forfiles -p "%TempArchivePath%" -s -m *.* /D -15 /C "cmd /c del @path"  

REM Log cleanup happens in SourceDataArchive.bat


pause 

 

 





