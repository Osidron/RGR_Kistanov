PROGRAM CountWords(INPUT, OUTPUT);
USES
  WorkWithWordReading, WorkWithTree;
CONST
  Data = 1000;
VAR
  GlobalCounter: LONGINT;
  ChArr: ArrType;
BEGIN {CountWords}
  GlobalCounter := 0;       
  WHILE (NOT EOF(INPUT)) AND (GlobalCounter <= Data - 1) 
  DO
    BEGIN
      ReadWord(INPUT, ChArr);
      WRITELN(OUTPUT, ChArr[0]);
      IF ChArr[0] <> '#'
      THEN
        BEGIN      
          GlobalCounter := GlobalCounter + 1;
          TreeSort(ChArr)
        END
      ELSE 
        BREAK
    END;
  PrintSorted(OUTPUT);
  WRITELN(OUTPUT);
  WRITELN(OUTPUT, 'Общее количество слов - ', GlobalCounter);
END.  {CountWords}
        