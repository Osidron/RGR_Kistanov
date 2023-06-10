PROGRAM CountWords(INPUT, OUTPUT);
USES
  WorkWithFiles, WorkWithTree, WorkWithWordReading;
VAR
  Str: STRING;
BEGIN {CountWords}
  Initialise;
  WHILE (NOT EOF(INPUT))  
  DO                                                                                   
    BEGIN
      ReadWord(INPUT, Str);
      InsertWord(Str)
    END;
  PrintOutput
END.  {CountWords} 
