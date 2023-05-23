UNIT
  WorkWithTree;
INTERFACE
PROCEDURE InsertWord(Str: STRING);          
PROCEDURE PrintWordAndAmount(VAR F: TEXT);  

IMPLEMENTATION
CONST
  Len = 255;
TYPE
  LenType = 0 .. Len;
  Tree = ^NodeType;
  NodeType = RECORD
               Str: STRING;
               Amount: INTEGER;
               Len: LenType;
               Left, Right: Tree
             END;

VAR
  StorageRoot: Tree;

PROCEDURE InsertWordInTree(VAR Node: Tree; Str: STRING); 
BEGIN {InsertWordInTree}
  IF Node = NIL
  THEN
    BEGIN                                                               
      NEW(Node);                            
      Node^.Amount := 1;                    
      Node^.Len := 0; 
      WHILE Str[Node^.Len] <> '$'
      DO
        Node^.Len := Node^.Len + 1;
      Node^.Str := Str;
      Node^.Left := NIL;
      Node^.Right := NIL
    END
  ELSE
    IF Str < Node^.Str
    THEN
      InsertWordInTree(Node^.Left, Str)
    ELSE
      IF Str > Node^.Str
      THEN
        InsertWordInTree(Node^.Right, Str)
      ELSE
        Node^.Amount := Node^.Amount + 1
END;  {InsertWordInTree}

PROCEDURE InsertWord(Str: STRING);
BEGIN {TreeSort}
  InsertWordInTree(StorageRoot, Str);
END;  {TreeSort}

PROCEDURE PrintWord(VAR F: TEXT; Str: STRING);
VAR
  I: INTEGER;
BEGIN {PrintWord}
  I := 0;
  WHILE Str[I] <> '$'
  DO                                             
    BEGIN
      WRITE(F, Str[I]);
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
      PrintWord(F, Node^.Str);
      WRITELN(F, ' ', Node^.Amount);
      PrintTree(F, Node^.Right);
      DISPOSE(Node^.Right)
    END
END; {PrintTree}

PROCEDURE PrintWordAndAmount(VAR F: TEXT);
BEGIN {PrintSorted}
  PrintTree(F, StorageRoot)
END;  {PrintSorted}

BEGIN {UNIT RGR}
  NEW(StorageRoot);
  StorageRoot := NIL
END.  {UNIT RGR}
                      