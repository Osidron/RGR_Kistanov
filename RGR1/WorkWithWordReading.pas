UNIT
  WorkWithWordReading;
INTERFACE
CONST
  ArrLen = 64;
  Space = [' ', '!', '"', '#', '$', '%', '&', '''','(', ')', '*', '+', ',', '.', '/', ':', ';', '<', '=', '>', '?', '@', '\', '[', ']', '^', '_', '`', '{', '}', '|', '~', '0' .. '9', 'Ђ', 'ї'];
TYPE
  LenType = 0 .. ArrLen;
  ArrType = ARRAY [LenType] OF CHAR;  
PROCEDURE ReadWord(VAR F: TEXT; VAR ChArr: ArrType); {„итает слово из файла и измен€ет его (убирает лишние дефисы, переводит в нижний регистр). ѕрисвает ChArr[0] значение '#' при конце файла и отсутствии слова}


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
    'А': Ch := '†';
    'Б': Ch := '°';
    'В': Ch := 'Ґ';
    'Г': Ch := '£';
    'Д': Ch := '§';
    'Е': Ch := '•';                               
    'р': Ch := 'с';
    'Ж': Ch := '¶';
    'З': Ch := 'І';
    'И': Ch := '®';
    'Й': Ch := '©';
    'К': Ch := '™';
    'Л': Ch := 'Ђ';
    'М': Ch := 'ђ';
    'Н': Ch := '≠';
    'О': Ch := 'Ѓ';
    'П': Ch := 'ѓ';
    'Р': Ch := 'а';
    'С': Ch := 'б';
    'Т': Ch := 'в';
    'У': Ch := 'г';
    'Ф': Ch := 'д';
    'Х': Ch := 'е';
    'Ц': Ch := 'ж';
    'Ч': Ch := 'з';
    'Ш': Ch := 'и';
    'Щ': Ch := 'й';
    'Ь': Ch := 'м';
    'Ы': Ch := 'Ы';
    'Ъ': Ch := 'к';
    'Э': Ch := 'н';
    'Ю': Ch := 'Ю';
    'Я': Ch := 'п';
    'ј': Ch := 'а';
    'Ѕ': Ch := 'б';
    '¬': Ch := 'в';
    '√': Ch := 'г';
    'ƒ': Ch := 'д';
    '≈': Ch := 'е';
    '®': Ch := 'Є';
    '∆': Ch := 'ж';
    '«': Ch := 'з';
    '»': Ch := 'и';
    '…': Ch := 'й';
    ' ': Ch := 'к';
    'Ћ': Ch := 'л';
    'ћ': Ch := 'м';
    'Ќ': Ch := 'н';
    'ќ': Ch := 'о';
    'ѕ': Ch := 'п';
    '–': Ch := 'р';
    '—': Ch := 'с';
    '“': Ch := 'т';
    '”': Ch := 'у';
    '‘': Ch := 'ф';
    '’': Ch := 'х';
    '÷': Ch := 'ц';
    '„': Ch := 'ч';
    'Ў': Ch := 'ш';
    'ў': Ch := 'щ';
    '№': Ch := 'ь';
    'џ': Ch := 'џ';
    'Џ': Ch := 'ъ';
    'Ё': Ch := 'э';
    'ё': Ch := 'ё';
    'я': Ch := '€';
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