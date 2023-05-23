PROGRAM CountWords(INPUT, OUTPUT);
USES
  WorkWithWordReading, WorkWithTree;
CONST
  Data = 1000;
VAR
  Str: STRING;
  GlobalCounter: LONGINT;
BEGIN {CountWords}
  GlobalCounter := 0;
  WHILE (NOT EOF(INPUT)) AND (GlobalCounter <= Data - 1) 
  DO
    BEGIN
      ReadWord(INPUT, Str);
      IF Str[0] <> '#'
      THEN
        BEGIN      
          GlobalCounter := GlobalCounter + 1;
          InsertWord(Str)
        END
      ELSE 
        BREAK
    END;
  PrintWordAndAmount(OUTPUT);
  WRITELN(OUTPUT);
  WRITELN(OUTPUT, 'Общее количество слов - ', GlobalCounter)
END.  {CountWords}
        