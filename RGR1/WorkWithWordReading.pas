UNIT
  WorkWithWordReading;
INTERFACE
CONST
  Len = 255;
  SupportedSymbols = ['A' .. 'Z', 'a' .. 'z', 'а' .. 'я', 'А' .. 'Я', '-'];
TYPE
  LenType = 0 .. Len;
PROCEDURE ReadWord(VAR F: TEXT; VAR Str: STRING);

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
    'А': Ch := 'а';
    'Б': Ch := 'б';
    'В': Ch := 'в';
    'Г': Ch := 'г';
    'Д': Ch := 'д';
    'Е': Ch := 'е';
    'Ё': Ch := 'ё';
    'Ж': Ch := 'ж';
    'З': Ch := 'з';
    'И': Ch := 'и';
    'Й': Ch := 'й';
    'К': Ch := 'к';
    'Л': Ch := 'л';
    'М': Ch := 'м';
    'Н': Ch := 'н';
    'О': Ch := 'о';
    'П': Ch := 'п';
    'Р': Ch := 'р';
    'С': Ch := 'с';
    'Т': Ch := 'т';
    'У': Ch := 'у';
    'Ф': Ch := 'ф';
    'Х': Ch := 'х';
    'Ц': Ch := 'ц';
    'Ч': Ch := 'ч';
    'Ш': Ch := 'ш';
    'Щ': Ch := 'щ';
    'Ь': Ch := 'ь';
    'Ы': Ch := 'Ы';
    'Ъ': Ch := 'ъ';
    'Э': Ch := 'э';
    'Ю': Ch := 'ю';
    'Я': Ch := 'я';
  ELSE
    Ch := Ch;
  END
END;  {LowerCase}

PROCEDURE CleanAfterDollar(VAR Str: STRING);
VAR
  I: LenType;
BEGIN
  I := 0;
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
BEGIN {CleanHyphensAtTheEnd}
  L := 0;
  WHILE Str[L] <> '$'
  DO
    L := L + 1;
  IF Str[L - 1] = '-'
  THEN
    BEGIN
      L := L - 1;
      WHILE Str[L] = '-'                                            {Остановился здесь. Надо проверить, что все перешло на STRING, чекнуть работу ANSILOWERCASE, заменить ReadUntilLetter, убрать Space окончательно}
      DO
        BEGIN
          Str[L] := '$';
          L := L - 1
        END
    END
END;  {CleanHyphensAtTheEnd}

PROCEDURE ReadUntilLetter(VAR F: TEXT; VAR Ch: CHAR);
BEGIN {ReadSpace}
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
  IF EOF(F) AND (Ch = '*')
  THEN
    Ch := '#'
END;   {ReadSpace}
 
PROCEDURE ReadWord(VAR F: TEXT; VAR Str: STRING);
VAR
  I: LenType;
  EndOfWord, HyphenFound: BOOLEAN;  
BEGIN {ReadWord}
  EndOfWord := FALSE;
  HyphenFound := FALSE;
  ReadUntilLetter(F, Str[0]);
  LowerCase(Str[0]);
  WRITELN;
  I := 1;
  IF Str[0] <> '#'
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
END;   {ReadWord}
BEGIN {WorkWithWordReading}
END.  {WorkWithWordReading}