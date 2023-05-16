PROGRAM CountWords(INPUT, OUTPUT);
CONST
  Data = 1000;
  Space = [' ', '!', '"', '#', '$', '%', '&', '''','(', ')', '*', '+', ',', '.', '/', ':', ';', '<', '=', '>', '?', '@', '\', '[', ']', '^', '_', '`', '{', '}', '|', '~', '0' .. '9', '«', '»'];
  ArrLen = 64;
TYPE
  LenType = 0 .. 64;
  ArrType = ARRAY [LenType] OF CHAR;
  Tree = ^NodeType;
  NodeType = RECORD
               ChArr: ArrType;
               Amount: INTEGER;
               Len: LenType;
               Left: Tree;
               Right: Tree
             END;
  
VAR
  GlobalCounter: LONGINT;
  StorageRoot: Tree;
  ChArr: ArrType;
  InF, OutF: TEXT;

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
    '€': Ch := ' ';
    '': Ch := '΅';
    '‚': Ch := 'Ά';
    'ƒ': Ch := '£';
    '„': Ch := '¤';
    '…': Ch := '¥';                               {RGR1 - 1; RGR1 - 0.8, RGR2 - 1; RGR1 - 0.6, RGR2 - 0.8, RGR3 - 1}
    'π': Ch := 'ρ';
    '†': Ch := '¦';
    '‡': Ch := '§';
    '': Ch := '¨';
    '‰': Ch := '©';
    '': Ch := 'ª';
    '‹': Ch := '«';
    '': Ch := '¬';
    '': Ch := '­';
    '': Ch := '®';
    '': Ch := '―';
    '': Ch := 'ΰ';
    '‘': Ch := 'α';
    '’': Ch := 'β';
    '“': Ch := 'γ';
    '”': Ch := 'δ';
    '•': Ch := 'ε';
    '–': Ch := 'ζ';
    '—': Ch := 'η';
    '': Ch := 'θ';
    '™': Ch := 'ι';
    '': Ch := 'μ';
    '›': Ch := '›';
    '': Ch := 'κ';
    '': Ch := 'ν';
    '': Ch := '';
    '': Ch := 'ο';
    'ΐ': Ch := 'ΰ';
    'Α': Ch := 'α';
    'Β': Ch := 'β';
    'Γ': Ch := 'γ';
    'Δ': Ch := 'δ';
    'Ε': Ch := 'ε';
    '¨': Ch := 'Έ';
    'Ζ': Ch := 'ζ';
    'Η': Ch := 'η';
    'Θ': Ch := 'θ';
    'Ι': Ch := 'ι';
    'Κ': Ch := 'κ';
    'Λ': Ch := 'λ';
    'Μ': Ch := 'μ';
    'Ν': Ch := 'ν';
    'Ξ': Ch := 'ξ';
    'Ο': Ch := 'ο';
    'Π': Ch := 'π';
    'Ρ': Ch := 'ρ';
    'Ò': Ch := 'ς';
    'Σ': Ch := 'σ';
    'Τ': Ch := 'τ';
    'Υ': Ch := 'υ';
    'Φ': Ch := 'φ';
    'Χ': Ch := 'χ';
    'Ψ': Ch := 'ψ';
    'Ω': Ch := 'ω';
    'ά': Ch := 'ό';
    'Ϋ': Ch := 'Ϋ';
    'Ϊ': Ch := 'ϊ';
    'έ': Ch := 'ύ';
    'ή': Ch := 'ή';
    'ί': Ch := 'ÿ';
  ELSE
    Ch := Ch;
  END
END;  {LowerCase}

FUNCTION ArrComparison(VAR Arr1, Arr2: ArrType): INTEGER;
VAR
  I: 0 .. 255;
BEGIN {ArrComparison}
  I := 0;
  ArrComparison := 0;
  REPEAT
    IF Arr1[I] < Arr2[I]
    THEN
      ArrComparison := 1
    ELSE
      IF Arr1[I] > Arr2[I]
      THEN
        ArrComparison := 2
      ELSE
        I := I + 1
  UNTIL NOT((Arr1[I] <> '$') AND (Arr2[I] <> '$') AND (ArrComparison = 0));
  IF (Arr1[I] = '$') AND (Arr2[I] <> '$')
  THEN
    ArrComparison := 1;
  IF (Arr1[I] <> '$') AND (Arr2[I] = '$')
  THEN
    ArrComparison := 2;
END;  {ArrComparison}

PROCEDURE CleanHyphensAtTheEnd(VAR ChArr: ArrType);
VAR
  L: LenType;
BEGIN
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
END;

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
  I: 0 .. ArrLen;
  EndOfWord, HyphenFound: BOOLEAN;  
BEGIN {ReadWord}
  EndOfWord := FALSE;
  HyphenFound := FALSE;
  ReadSpace(F, ChArr[0]);
  LowerCase(ChArr[0]);
  I := 1;
  IF ChArr[1] <> '#'
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
        ChArr[I] := '$'
    END
END;   {ReadWord}

PROCEDURE InsertWordInTree(VAR Node: Tree; ChArr: ArrType);
BEGIN {InsertWordInTree}
  IF Node = NIL
  THEN
    BEGIN
      NEW(Node);
      Node^.Amount := 1;
      Node^.Len := 0; 
      WHILE ChArr[Node^.Len] <> '$'
      DO
        Node^.Len := Node^.Len + 1;
      Node^.ChArr := ChArr;
      Node^.Left := NIL;
      Node^.Right := NIL
    END
  ELSE
    IF ArrComparison(ChArr, Node^.ChArr) = 1 
    THEN
      InsertWordInTree(Node^.Left, ChArr)
    ELSE
      IF ArrComparison(ChArr, Node^.ChArr) = 2
      THEN
        InsertWordInTree(Node^.Right, ChArr)
      ELSE
        IF ArrComparison(ChArr, Node^.ChArr) = 0
        THEN
          Node^.Amount := Node^.Amount + 1
END;  {InsertWordInTree}

PROCEDURE PrintWord(VAR F: TEXT; ChArr: ArrType);
VAR
  I: INTEGER;
BEGIN
  I := 0;
  WHILE ChArr[I] <> '$'
  DO                                             
    BEGIN
      WRITE(F, ChArr[I]);
      I := I + 1
    END
END;

PROCEDURE PrintTree(VAR F: TEXT; VAR Node: Tree);
BEGIN {PrintTree} 
  IF Node <> NIL
  THEN
    BEGIN
      PrintTree(F, Node^.Left);
      DISPOSE(Node^.Left);
      PrintWord(F, Node^.ChArr);
      WRITELN(F, ' ', Node^.Amount);
      PrintTree(F, Node^.Right);
      DISPOSE(Node^.Right)
    END
END; {PrintTree}

BEGIN {CountWords}
  GlobalCounter := 0;
  NEW(StorageRoot);
  StorageRoot := NIL;
  ASSIGN(InF, 'inf.txt');
  ASSIGN(OutF, 'outf.txt');
  RESET(InF);
  REWRITE(OutF);
  WHILE (NOT EOF(InF)) AND (GlobalCounter <= Data - 1) 
  DO
    BEGIN
      ReadWord(InF, ChArr);
      IF ChArr[0] <> '#'
      THEN
        BEGIN      
          GlobalCounter := GlobalCounter + 1;
          CleanHyphensAtTheEnd(ChArr);
          InsertWordInTree(StorageRoot, ChArr)
        END
      ELSE 
        BREAK
    END;
  PrintTree(OutF, StorageRoot);
  WRITELN(OutF);
  WRITELN(OutF, '΅ι¥¥ ª®«¨η¥αβΆ® α«®Ά - ', GlobalCounter);
  CLOSE(OutF)
END.  {CountWords}
        