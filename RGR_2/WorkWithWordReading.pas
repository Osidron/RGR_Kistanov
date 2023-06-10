UNIT
  WorkWithWordReading;
INTERFACE
PROCEDURE ReadWord(VAR F: TEXT; VAR Str: STRING);
IMPLEMENTATION
CONST
  Len = 255;
  SupportedSymbols = ['A' .. 'Z', 'a' .. 'z', '�' .. '�', '�' .. '�', '�', '�', '-'];
TYPE
  LenType = 0 .. Len;

PROCEDURE LowerCase(VAR Ch: CHAR);
BEGIN 
  CASE Ch OF
    'A': Ch := 'a';
    'B': Ch := 'b';
    'C': Ch := 'c';
    'D': Ch := 'd';
    'E': Ch := 'e';
    'F': Ch := 'f';
    'G': Ch := 'g';
    'H': Ch := 'h';
    'I': Ch := 'i';
    'J': Ch := 'j';
    'K': Ch := 'k';
    'L': Ch := 'l';
    'M': Ch := 'm';
    'N': Ch := 'n';
    'O': Ch := 'o';
    'P': Ch := 'p';
    'Q': Ch := 'q';
    'R': Ch := 'r';
    'S': Ch := 's';
    'T': Ch := 't';
    'U': Ch := 'u';
    'V': Ch := 'v';
    'W': Ch := 'w';
    'X': Ch := 'x';
    'Y': Ch := 'y';
    'Z': Ch := 'z';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
    '�': Ch := '�';
  ELSE
    Ch := Ch;
  END
END;  

PROCEDURE CleanStr(VAR Str: STRING);
VAR
  I: LenType;
BEGIN
  FOR I := 0 TO Len
  DO
    Str[I] := ' '
END;

PROCEDURE CleanAfterDollar(VAR Str: STRING);
VAR
  I: LenType;
BEGIN
  I := 1;
  WHILE Str[I] <> '$'
  DO
    I := I + 1;
  I := I + 1;
  FOR I := I TO Len
  DO
    Str[I] := ' ';
END;

PROCEDURE CleanHyphensAtTheEnd(VAR Str: STRING);
VAR
  L: LenType;
BEGIN
  L := 1;
  WHILE Str[L] <> '$'
  DO
    L := L + 1;
  IF Str[L - 1] = '-'
  THEN
    BEGIN
      L := L - 1;
      WHILE Str[L] = '-'                                          
      DO
        BEGIN
          Str[L] := '$';
          L := L - 1
        END
    END
END;

PROCEDURE ReadUntilLetter(VAR F: TEXT; VAR Ch: CHAR);
BEGIN
  Ch := '*';
  REPEAT
    IF NOT EOF(F)
    THEN
      IF NOT EOLN(F)
      THEN
        READ(F, Ch)
      ELSE
        READLN(F)
    ELSE
      BREAK
  UNTIL NOT(NOT(Ch IN SupportedSymbols) OR (Ch = '-'));
  IF EOF(F) AND NOT(Ch IN SupportedSymbols)
  THEN
    Ch := '#'
END;
 
PROCEDURE ReadWord(VAR F: TEXT; VAR Str: STRING);
VAR
  I: LenType;
  EndOfWord, HyphenFound: BOOLEAN;  
BEGIN
  EndOfWord := FALSE;
  HyphenFound := FALSE;
  CleanStr(Str);
  ReadUntilLetter(F, Str[1]);
  LowerCase(Str[1]);
  I := 2;
  IF Str[1] <> '#'
  THEN
    BEGIN
      WHILE (NOT EOLN(F)) AND (NOT EndOfWord) AND (NOT EOF(F)) AND (I <= Len - 1)
      DO
        BEGIN
          READ(F, Str[I]);
          LowerCase(Str[I]); 
          IF Str[I] IN SupportedSymbols
          THEN
            BEGIN
              IF (NOT HyphenFound)
              THEN
                IF (Str[I] <> '-')
                THEN
                  I := I + 1
                ELSE
                  BEGIN
                    HyphenFound := TRUE;
                    I := I + 1
                  END
              ELSE
                IF (Str[I] <> '-')
                THEN
                  BEGIN
                    HyphenFound := FALSE;
                    I := I + 1
                  END
            END 
          ELSE
            EndOfWord := TRUE
        END;  
      Str[I] := '$';
      CleanHyphensAtTheEnd(Str);
      CleanAfterDollar(Str);
    END  
END;
BEGIN 
END.  