PROGRAM CountWords(INPUT, OUTPUT);
USES
  RGR;
CONST
  Data = 1000;
VAR
  GlobalCounter: INTEGER;
  StorageRoot: Tree;
  ChArr: ArrType;
BEGIN {CountWords}
  GlobalCounter := 0;
  NEW(StorageRoot);
  StorageRoot := NIL;       
  WHILE (NOT EOF(INPUT)) AND (GlobalCounter <= Data - 1) 
  DO
    BEGIN
      ReadWord(INPUT, ChArr);
      IF ChArr[0] <> '#'
      THEN
        BEGIN      
          GlobalCounter := GlobalCounter + 1;
          InsertWordInTree(StorageRoot, ChArr)
        END
      ELSE 
        BREAK
    END;
  PrintTree(OUTPUT, StorageRoot);
  WRITELN(OUTPUT);
  WRITELN(OUTPUT, 'Общее количество слов - ', GlobalCounter);
END.  {CountWords}
        