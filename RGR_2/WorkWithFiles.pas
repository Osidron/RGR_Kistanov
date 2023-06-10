UNIT
  WorkWithFiles;
INTERFACE
PROCEDURE CopyFileToFile(VAR FOut, FIn: TEXT);
PROCEDURE MergeTreeAndFile(VAR F: TEXT);

IMPLEMENTATION
USES
  WorkWithTree;

PROCEDURE ReadWord(VAR F: TEXT; VAR Str: STRING);
VAR
  I: INTEGER;
BEGIN
  I := 0;
  REPEAT
    I := I + 1;
    READ(F, Str[I])
  UNTIL Str[I] = ' '
END;

PROCEDURE WriteWord(VAR F: TEXT; VAR Str: STRING);
VAR
  I: INTEGER;
BEGIN
  I := 1;
  WHILE Str[I] <> ' '
  DO
    BEGIN
      WRITE(F, Str[I]);
      I := I + 1
    END
END;

PROCEDURE CopyFileToFile(VAR FOut, FIn: TEXT);
VAR
  Ch: CHAR;
BEGIN
  WHILE NOT EOF(FIn)
  DO
    IF NOT EOLN(FIn)
    THEN
      BEGIN
        READ(FIn, Ch);
        WRITE(FOut, Ch)
      END
    ELSE
      BEGIN
        READLN(FIn);
        WRITELN(FOut)
      END
END;

PROCEDURE Clean(VAR Str: STRING);
VAR
  I: INTEGER;
BEGIN                                                                      
  FOR I := 0 TO 255
  DO
    Str[I] := ' ';
  Str[1] := '@'
END;

PROCEDURE ReadFormatedLine(VAR F: TEXT; VAR Line: FileLN);
BEGIN
  IF NOT EOF(F)
  THEN
    IF NOT EOLN(F)
    THEN
      BEGIN
        ReadWord(F, Line.Str);
        READLN(F, Line.Amount)
      END
    ELSE
      READLN(F)
END;

PROCEDURE WriteFormatedLine(VAR F: TEXT; Line: FileLN);
BEGIN
  WriteWord(F, Line.Str);
  WRITELN(F, ' ', Line.Amount)
END;

PROCEDURE MergeTreeAndFile(VAR F: TEXT);
VAR
  Line1, Line2: FileLN;
  Temp: TEXT;
BEGIN
  ASSIGN(Temp, 'Temp1.txt');
  Clean(Line1.Str);
  Clean(Line2.Str);
  REWRITE(Temp); 
  CopyFileToFile(Temp, F);
  REWRITE(F);
  RESET(Temp);
  WHILE ((NOT EOT) AND (NOT EOF(Temp))) OR (EOT AND (Line1.Str[1] <> '$') AND (Line1.Str[1] <> '@') AND (NOT EOF(Temp)))
  DO
    BEGIN
      IF (Line1.Str[1] = '@') AND NOT EOT
      THEN                               
        BringWord(Line1);
      IF (Line2.Str[1] = '@') AND NOT EOF(Temp)
      THEN
        BEGIN
          ReadFormatedLine(Temp, Line2)
        END;
      IF Line1.Str > Line2.Str
      THEN
        BEGIN                     
          WriteFormatedLine(F, Line2);
          Clean(Line2.Str)
        END
      ELSE
        IF Line1.Str < Line2.Str
        THEN
          BEGIN                   
            WriteFormatedLine(F, Line1);
            Clean(Line1.Str)
          END
        ELSE
          BEGIN
            Line2.Amount := Line2.Amount + Line1.Amount;
            WriteFormatedLine(F, Line2); 
            Clean(Line1.Str);
            Clean(Line2.Str)
          END
    END;
  IF Line1.Str[1] <> '@'
  THEN
    WriteFormatedLine(F, Line1)
  ELSE
    IF Line2.Str[1] <> '@'
    THEN
      WriteFormatedLine(F, Line2);
  IF EOT AND NOT EOF(Temp)
  THEN
    BEGIN
      CopyFileToFile(F, Temp);
    END;
  IF EOF(Temp) AND NOT EOT
  THEN            
    PrintWordAndAmount(F);
  RESET(F);                    
  CLOSE(Temp)
END;

BEGIN
END.

