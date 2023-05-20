UNIT
  WorkWithTree;
INTERFACE
CONST
  ArrLen = 64;
  Space = [' ', '!', '"', '#', '$', '%', '&', '''','(', ')', '*', '+', ',', '.', '/', ':', ';', '<', '=', '>', '?', '@', '\', '[', ']', '^', '_', '`', '{', '}', '|', '~', '0' .. '9', '«', '»'];
TYPE
  LenType = 0 .. ArrLen;
  ArrType = ARRAY [LenType] OF CHAR;  
PROCEDURE TreeSort(ChArr: ArrType);  {Процедура добавления слова в дерево для сортировки}
PROCEDURE PrintSorted(VAR F: TEXT);  {Процедура вывода отсортированных по алфавиту слов в файл в формате: <слово><пробел><количество вхождений>}
IMPLEMENTATION
TYPE
  Tree = ^NodeType;
  NodeType = RECORD
               ChArr: ArrType;
               Amount: INTEGER;
               Len: LenType;
               Left: Tree;
               Right: Tree
             END;

VAR
  StorageRoot: Tree;

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

PROCEDURE TreeSort(ChArr: ArrType);
BEGIN {TreeSort}
  InsertWordInTree(StorageRoot, ChArr);
END;  {TreeSort}

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

PROCEDURE PrintSorted(VAR F: TEXT);
BEGIN {PrintSorted}
  PrintTree(F, StorageRoot)
END;  {PrintSorted}

BEGIN {UNIT RGR}
  NEW(StorageRoot);
  StorageRoot := NIL
END.  {UNIT RGR}
                      