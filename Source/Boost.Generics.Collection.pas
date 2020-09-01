unit Boost.Generics.Collection;

interface

Type
  TQueue<T> = record
    type
      TEnumerator<T> = record
      private
        FList: TArray<T>;
        FIndex: Integer;
        function GetCurrent: T; inline;
        function DoGetCurrent: T;
        function DoMoveNext: Boolean;
      public
        constructor Create(const AList: TArray<T>);
        function MoveNext: Boolean; inline;
        property Current: T read GetCurrent;
      end;
    private
    var
     FItems:TArray<T>;
     FCapacity:Integer;
    public
    function GetEnumerator: TEnumerator<T>;
    constructor Create(Items:TArray<T>);
    function Enqueue(const Value: T):Boolean; inline;
    function Dequeue: T; inline;
    function Peek:T; inline;
    function Count:Integer; inline;
    procedure Clear;
    function IsFull:Boolean;
    function IsEmpty:Boolean;
    function ToArray: TArray<T>;
    procedure TrimExcess;
    property Capacity: Integer read FCapacity write FCapacity;
  end;

  TStack<T> = record
    type
      TEnumerator<T> = record
      private
        FList: TArray<T>;
        FIndex: Integer;
        function GetCurrent: T; inline;
        function DoGetCurrent: T;
        function DoMoveNext: Boolean;
      public
        constructor Create(const AList: TArray<T>);
        function MoveNext: Boolean; inline;
        property Current: T read GetCurrent;
      end;
    private
    var
     FItems:TArray<T>;
     FCapacity:Integer;
    public
    function GetEnumerator: TEnumerator<T>;
    constructor Create(Items:TArray<T>);
    function Push(const Value: T):Boolean; inline;
    function Pop: T; inline;
    function Peek:T; inline;
    procedure Clear;
    function Count:Integer; inline;
    function Isfull:Boolean;
    function IsEmpty:Boolean;
    function ToArray: TArray<T>;
    procedure TrimExcess;
    property Capacity: Integer read FCapacity write FCapacity;
  end;


implementation

uses
  System.SysUtils;

{ TQueue }

constructor TQueue<T>.TEnumerator<T>.Create(const AList: TArray<T>);
begin
  FList:= AList;
  FIndex := -1;
end;

function TQueue<T>.TEnumerator<T>.DoGetCurrent: T;
begin
  Result := Current;
end;

function TQueue<T>.TEnumerator<T>.DoMoveNext: Boolean;
begin
  Result := MoveNext;
end;

function TQueue<T>.TEnumerator<T>.GetCurrent: T;
begin
  Result := FList[FIndex];
end;

function TQueue<T>.TEnumerator<T>.MoveNext: Boolean;
begin
  Inc(FIndex);
  Result := FIndex < length(FList);
end;

procedure TQueue<T>.Clear;
begin
  SetLength(FItems,0);
end;

function TQueue<T>.Count: Integer;
begin
  Result:= Length(FItems);
end;

constructor TQueue<T>.Create(Items: TArray<T>);
var
i:Integer;
begin
  FCapacity := -1;
  SetLength(FItems,0);
  if Length(Items) > 0   then
  for i := 0 to High(Items) do
    Enqueue(Items[i]);
end;

function TQueue<T>.Dequeue: T;
begin
  if IsEmpty then
    raise EArgumentOutOfRangeException.Create('Queue is Empty');
  Result:= FItems[high(FItems)];
  Delete(FItems,high(FItems),1);
end;

function TQueue<T>.Enqueue(const Value: T): Boolean;
begin
  if Isfull then
    exit(False);
  Insert([value],FItems,0);
  Result:= True;
end;

function TQueue<T>.GetEnumerator: TEnumerator<T>;
begin
  Result :=   TEnumerator<T>.Create(FItems);
end;

function TQueue<T>.IsEmpty: Boolean;
begin
  Result:= Count = 0;
end;

function TQueue<T>.Isfull: Boolean;
begin
  Result:= (FCapacity > 0) and (Count >=FCapacity);
end;

function TQueue<T>.Peek: T;
begin
  Result:= FItems[high(FItems)];
end;

function TQueue<T>.ToArray: TArray<T>;
begin
  Result:= FItems;
end;

procedure TQueue<T>.TrimExcess;
begin
  while Count > FCapacity do
    Dequeue;
end;

{ TStack<T> }

procedure TStack<T>.Clear;
begin
  SetLength(FItems,0);
end;

function TStack<T>.Count: Integer;
begin
  Result:= Length(FItems);
end;

constructor TStack<T>.Create(Items: TArray<T>);
var
  i:Integer;
begin
  FCapacity := -1;
  SetLength(FItems,0);
  if Length(Items) > 0   then
  for i := 0 to High(Items) do
    Push(Items[i]);
end;


function TStack<T>.GetEnumerator: TEnumerator<T>;
begin
  Result := TEnumerator<T>.Create(FItems);
end;

function TStack<T>.IsEmpty: Boolean;
begin
  Result:= Count =0;
end;

function TStack<T>.Isfull: Boolean;
begin
  Result:= (FCapacity > 0) and (Count >=FCapacity);
end;

function TStack<T>.Peek: T;
begin
  Result:= FItems[high(FItems)];
end;

function TStack<T>.Pop: T;
begin
 if IsEmpty then
    raise EArgumentOutOfRangeException.Create('Stack is Empty');
  Result:= FItems[high(FItems)];
  Delete(FItems,high(FItems),1);
end;

function TStack<T>.Push(const Value: T): Boolean;
begin
  if Isfull then
    exit(False);
  SetLength(FItems,count+1);
  FItems[high(FItems)] := value;
  Result:= True;
end;

function TStack<T>.ToArray: TArray<T>;
begin
  Result:= FItems;
end;

procedure TStack<T>.TrimExcess;
begin
  while Count > FCapacity do
    Pop;
end;

{ TStack<T>.TEnumerator<T> }

constructor TStack<T>.TEnumerator<T>.Create(const AList: TArray<T>);
begin
  FList:= AList;
  FIndex := -1;
end;

function TStack<T>.TEnumerator<T>.DoGetCurrent: T;
begin
  Result := Current;
end;

function TStack<T>.TEnumerator<T>.DoMoveNext: Boolean;
begin
  Result := MoveNext;
end;

function TStack<T>.TEnumerator<T>.GetCurrent: T;
begin
  Result := FList[FIndex];
end;

function TStack<T>.TEnumerator<T>.MoveNext: Boolean;
begin
  Inc(FIndex);
  Result := FIndex < length(FList);
end;

end.
