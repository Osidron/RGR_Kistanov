UNIT
  WorkWithTree;
INTERFACE
TYPE
  FileLN = RECORD
             Str: STRING;
             Amount: INTEGER
           END;
PROCEDURE Initialise;
PROCEDURE InsertWord(VAR Str: STRING);
PROCEDURE PrintWordAndAmount(VAR F: TEXT);
PROCEDURE PrintOutput;
PROCEDURE CopyStrToStr(VAR StrOut, StrIn: STRING);
PROCEDURE BringWord(VAR Line: FileLN);
FUNCTION EOT: BOOLEAN;

IMPLEMENTATION
USES
  WorkWithFiles;
CONST
  Len = 255;
  Data = 50000;
TYPE
  LenType = 0 .. Len;
  Tree = ^NodeType;
  NodeType = RECORD
               Str: STRING;
               Amount: LONGINT;
               Left, Right: Tree
              END;
VAR
  Temp: TEXT;
  StorageRoot: Tree;
  GlobalAmount: LONGINT;

PROCEDURE Initialise;
BEGIN
  ASSIGN(Temp, 'Temp.txt');
  REWRITE(Temp);
  StorageRoot := NIL;
  GlobalAmount := 0
END;

FUNCTION EOT: BOOLEAN;
BEGIN
  IF StorageRoot = NIL
  THEN
    EOT := TRUE
  ELSE
    EOT := FALSE
END;

PROCEDURE PrintWord(VAR F: TEXT; VAR Str: STRING);
VAR
  I: INTEGER;
BEGIN 
  I := 1;
  WHILE Str[I] <> '$'
  DO                                             
    BEGIN
      WRITE(F, Str[I]);
      I := I + 1
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

PROCEDURE CopyStrToStr(VAR StrOut, StrIn: STRING);
VAR
  I: LenType;
BEGIN
  CleanStr(StrOut);
  I := 1;
  WHILE StrIn[I] <> '$'
  DO
    BEGIN
      StrOut[I] := StrIn[I];
      I := I + 1
    END;
  StrOut[I] := '$'
END;

PROCEDURE BringWordFromTree(VAR Line: FileLN; VAR Node: Tree);
VAR
  I: LenType;
BEGIN
  IF Node^.Left <> NIL
  THEN
    BringWordFromTree(Line, Node^.Left)
  ELSE
    IF (Node^.Str[1] <> '$') AND (Line.Str[1] = '$')
    THEN
      BEGIN
        Line.Amount := Node^.Amount;
        CopyStrToStr(Line.Str, Node^.Str);
        I := 1;
        WHILE Line.Str[I] <> '$'                    
        DO
          I := I + 1;
        Line.Str[I] := ' ';
        Node^.Str[1] := '$'
      END
    ELSE
      BringWordFromTree(Line, Node^.Right);
  IF (Node^.Right = NIL) AND (Node^.Right = NIL) AND (Node^.Str[1] = '$')
  THEN
    BEGIN
      DISPOSE(Node);
      Node := NIL
    END
END;

PROCEDURE BringWord(VAR Line: FileLN);
BEGIN
  CleanStr(Line.Str);
  Line.Str[1] := '$';
  BringWordFromTree(Line, StorageRoot); 
END;

PROCEDURE InsertWordInTree(VAR Node: Tree; VAR Str: STRING); 
BEGIN 
  IF Node = NIL
  THEN
    BEGIN                                                               
      NEW(Node);                            
      Node^.Amount := 1;                    
      CopyStrToStr(Node^.Str, Str);
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
END;  

PROCEDURE InsertWord(VAR Str: STRING);
BEGIN 
  IF (Str[1] <> '#') AND (Str[1] <> '*')
  THEN
    BEGIN
      IF (GlobalAmount MOD Data = 0) AND (GlobalAmount <> 0)
      THEN
        BEGIN                              
          RESET(Temp);                                                                                
          MergeTreeAndFile(Temp);        
        END;
      GlobalAmount := GlobalAmount + 1;
      InsertWordInTree(StorageRoot, Str);
    END
END;  

PROCEDURE PrintTree(VAR F: TEXT; VAR Node: Tree);
BEGIN 
  IF Node <> NIL
  THEN
    BEGIN
      PrintTree(F, Node^.Left);
      DISPOSE(Node^.Left);
      Node^.Left := NIL;
      IF Node^.Str[1] <> '$'
      THEN
        BEGIN                
          PrintWord(F, Node^.Str);
          WRITELN(F, ' ', Node^.Amount)
        END;
      PrintTree(F, Node^.Right);
      DISPOSE(Node^.Right);
      Node^.Right := NIL
    END
END; 

PROCEDURE PrintWordAndAmount(VAR F: TEXT);
BEGIN
  PrintTree(F, StorageRoot);
  DISPOSE(StorageRoot);
  StorageRoot := NIL
END; 

PROCEDURE PrintOutput;
BEGIN
  RESET(Temp);
  MergeTreeAndFile(Temp);
  CopyFileToFile(OUTPUT, Temp);
  CLOSE(Temp);
  WRITELN;
  WRITELN('Общее количество слов - ', GlobalAmount)
END;

BEGIN
END. 
                      
