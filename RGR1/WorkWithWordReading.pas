UNIT
  WorkWithWordReading;
INTERFACE
CONST
  ArrLen = 64;
  Space = [' ', '!', '"', '#', '$', '%', '&', '''','(', ')', '*', '+', ',', '.', '/', ':', ';', '<', '=', '>', '?', '@', '\', '[', ']', '^', '_', '`', '{', '}', '|', '~', '0' .. '9', '�', '�'];
TYPE
  LenType = 0 .. ArrLen;
  ArrType = ARRAY [LenType] OF CHAR;  
PROCEDURE ReadWord(VAR F: TEXT; VAR ChArr: ArrType); {������ ����� �� ����� � �������� ��� (������� ������ ������, ��������� � ������ �������). �������� ChArr[0] �������� '#' ��� ����� ����� � ���������� �����}


IMPLEMENTATION

PROCEDURE LowerCase(VAR Ch: CHAR);
BEGIN {LowerCase}
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
END;  {LowerCase}

PROCEDURE CleanHyphensAtTheEnd(VAR ChArr: ArrType);
VAR
  L: LenType;
BEGIN {CleanHyphensAtTheEnd}
  L := 0;
  WHILE ChArr[L] <> '$'
  DO
    L := L + 1;
  IF ChArr[L - 1] = '-'
  THEN
    BEGIN
      L := L - 1;
      WHILE ChArr[L] = '-'
      DO
        BEGIN
          ChArr[L] := '$';
          L := L - 1
        END
    END
END;  {CleanHyphensAtTheEnd}

PROCEDURE ReadSpace(VAR F: TEXT; VAR Ch: CHAR);
BEGIN {ReadSpace}
  Ch := '*';
  IF NOT EOF(F)
  THEN
    REPEAT
      IF NOT EOLN(F)
      THEN
        READ(F, Ch)
      ELSE
        READLN(F);
    UNTIL NOT(((Ch IN Space) OR (Ch = '-')) AND (NOT EOF(F)));
  IF EOF(F)
  THEN
    Ch := '#'
END;   {ReadSpace}
 
PROCEDURE ReadWord(VAR F: TEXT; VAR ChArr: ArrType);
VAR
  I: LenType;
  EndOfWord, HyphenFound: BOOLEAN;  
BEGIN {ReadWord}
  EndOfWord := FALSE;
  HyphenFound := FALSE;
  ReadSpace(F, ChArr[0]);
  LowerCase(ChArr[0]);
  I := 1;
  IF ChArr[0] <> '#'
  THEN
    BEGIN
      WHILE (NOT EOLN(F)) AND (NOT EndOfWord) AND (NOT EOF(F)) AND (I <= ArrLen - 1)
      DO
        BEGIN
          READ(F, ChArr[I]);
          LowerCase(ChArr[I]); 
          IF NOT(ChArr[I] IN Space)
          THEN
            BEGIN
              IF (NOT HyphenFound)
              THEN
                IF (ChArr[I] <> '-')
                THEN
                  I := I + 1
                ELSE
                  BEGIN
                    HyphenFound := TRUE;
                    I := I + 1
                  END
              ELSE
                IF (ChArr[I] <> '-')
                THEN
                  BEGIN
                    HyphenFound := FALSE;
                    I := I + 1
                  END
            END 
          ELSE
            EndOfWord := TRUE
        END;
        ChArr[I] := '$';
        CleanHyphensAtTheEnd(ChArr);
    END
  
END;   {ReadWord}
BEGIN {WorkWithWordReading}
END.  {WorkWithWordReading}