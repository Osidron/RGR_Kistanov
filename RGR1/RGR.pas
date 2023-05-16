UNIT
  RGR;
INTERFACE
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
PROCEDURE ReadWord(VAR F: TEXT; VAR ChArr: ArrType);        {��������� ������ �����. ���������� '#' � 0 ������ �������� ������� ��� ������� EOF. ���������� �������, ����� ����. ������������ �������� ��������� ����}
PROCEDURE InsertWordInTree(VAR Node: Tree; ChArr: ArrType); {��������� ���������� ����� � �������� ������}
PROCEDURE PrintTree(VAR F: TEXT; VAR Node: Tree);           {��������� ������ ���� �� ������ � ���� � �������: <�����><������><���������� ���������>}
IMPLEMENTATION
CONST
  Space = [' ', '!', '"', '#', '$', '%', '&', '''','(', ')', '*', '+', ',', '.', '/', ':', ';', '<', '=', '>', '?', '@', '\', '[', ']', '^', '_', '`', '{', '}', '|', '~', '0' .. '9', '�', '�'];
  ArrLen = 64;
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

FUNCTION ArrComparison(VAR Arr1, Arr2: ArrType): INTEGER;
VAR
  I: LenType;
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
        ChArr[I] := '$';
        CleanHyphensAtTheEnd(ChArr);
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
BEGIN {PrintWord}
  I := 0;
  WHILE ChArr[I] <> '$'
  DO                                             
    BEGIN
      WRITE(F, ChArr[I]);
      I := I + 1
    END
END; {PrintWord}

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

BEGIN {UNIT RGR}
END.  {UNIT RGR}
        