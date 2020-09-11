unit Boost.LinkedList;

interface

type
  TLinkedList<T> = class;

  TLinkedListNode<T> = class
    Value: T;
    Next, Prev: TLinkedListNode<T>;
    Owner: TLinkedList<T>;
  end;

  TEnumeratorLinkedList<T> = record
  private
    Node: TLinkedListNode<T>;
    IsFirst: boolean;
    function GetCurrent: T; inline;
  public
    constructor Create(FirstNode: TLinkedListNode<T>);
    function MoveNext: Boolean; inline;
    property Current: T read GetCurrent;
  end;

  TLinkedList<T> = class
  private
    FCount: Integer;
    FFirst: TLinkedListNode<T>;
    class function Compare(a, b: T): Integer; static;
    function Add: TLinkedListNode<T>; overload;
    procedure CheckNode(Node: TLinkedListNode<T>);
    function GetNodeByIndex(Index: Integer): TLinkedListNode<T>;
    function GetItem(Index: Integer): T;
    procedure SetItem(Index: Integer; const Value: T);
    procedure CheckIndex(Index: Integer);
    class function GenericToString<T>(aValue: T): string; static;
  public
    function ToString: string; override;
    procedure Remove(Node: TLinkedListNode<T>; QueueFree: boolean = False); overload;
    procedure Remove(Value: T); overload;
    function Extract(Index: Integer): TLinkedListNode<T>;
    function ElementAt(Index: Integer): T;
    procedure Delete(Index: Integer);
    function GetEnumerator: TEnumeratorLinkedList<T>;
    procedure Clear;
    function Last: TLinkedListNode<T>;
    function Add(value: T): TLinkedListNode<T>; overload;
    function AddAfter(Node: TLinkedListNode<T>; value: T): TLinkedListNode<T>;
    function AddBefore(Node: TLinkedListNode<T>; value: T): TLinkedListNode<T>;
    function AddFirst(Value: T): TLinkedListNode<T>;
    function AddLast(Value: T): TLinkedListNode<T>;
    function Find(value: T): TLinkedListNode<T>;
    function FindLast(value: T): TLinkedListNode<T>;
    function Contains(value: T): boolean;
    destructor Destroy; override;
    constructor Create;
    property Items[Index: Integer]: T read GetItem write SetItem; default;
    property Count: Integer read FCount;
    property First: TLinkedListNode<T> read FFirst;
  end;

implementation

uses
  System.SysUtils, system.generics.defaults, System.Rtti, System.TypInfo;

{ TLinkedList<T> }

function TLinkedList<T>.Add(value: T): TLinkedListNode<T>;
var
  node: TLinkedListNode<T>;
begin
  Result := Add;
  Result.Value := value;
  if not Assigned(First) then
  begin
    FFirst := Result;
    FFirst.Prev := nil;
    FFirst.Next := nil;
  end
  else
  begin
    node := last;
    Result.Prev := node;
    node.Next := result;
  end;
  inc(FCount);
end;

function TLinkedList<T>.AddAfter(Node: TLinkedListNode<T>; value: T): TLinkedListNode<T>;
begin
  CheckNode(Node);

  Result := Add;
  Result.Value := value;

  if Assigned(Node.Next) then
  begin
    Node.Next.Prev := Result;
    Result.Next := Node.Next;
  end;
  Result.Prev := Node;
  Node.Next := Result;

  inc(FCount);
end;

function TLinkedList<T>.AddBefore(Node: TLinkedListNode<T>; value: T): TLinkedListNode<T>;
begin
  CheckNode(Node);

  Result := Add;
  Result.Value := value;
  if Node = FFirst then
    FFirst := Result
  else
  begin
    Result.Prev := Node.Prev;
    Result.Prev.Next := Result;
  end;

  Node.Prev := Result;
  Result.Next := Node;
  inc(FCount);
end;

function TLinkedList<T>.AddFirst(Value: T): TLinkedListNode<T>;
begin
  if not Assigned(FFirst) then
    exit(Add(Value));
  Result := AddBefore(FFirst, Value);
end;

function TLinkedList<T>.AddLast(Value: T): TLinkedListNode<T>;
begin
  Result := AddAfter(Last, Value);
end;

function TLinkedList<T>.Add: TLinkedListNode<T>;
begin
  Result := TLinkedListNode<T>.Create;
  Result.Owner := self;
end;

constructor TLinkedList<T>.Create;
begin
  FCount := 0;
  FFirst := nil;
end;

procedure TLinkedList<T>.Delete(Index: Integer);
var
  node: TLinkedListNode<T>;
begin
  CheckIndex(Index);
  node := GetNodeByIndex(Index);
  Remove(node, True);
end;

destructor TLinkedList<T>.Destroy;
begin
  Clear;
  inherited;
end;

function TLinkedList<T>.ElementAt(Index: Integer): T;
begin
  Result := GetItem(Index);
end;

function TLinkedList<T>.Extract(Index: Integer): TLinkedListNode<T>;
begin
  Result := GetNodeByIndex(Index);
  Remove(Result);
end;

function TLinkedList<T>.Find(value: T): TLinkedListNode<T>;
begin
  if FFirst = nil then
    exit(nil);
  result := FFirst;
  while Assigned(result.Next) do
  begin
    if Compare(Result.Value, value) = 0 then
      exit;
    result := result.Next;
  end;
end;

function TLinkedList<T>.FindLast(value: T): TLinkedListNode<T>;
begin
  result := Last;
  while Assigned(Result) do
  begin
    if Compare(Result.Value, value) = 0 then
      exit;
    result := result.Prev;
  end;
end;

function TLinkedList<T>.GetEnumerator: TEnumeratorLinkedList<T>;
begin
  Result := TEnumeratorLinkedList<T>.Create(FFirst);
end;

function TLinkedList<T>.GetItem(Index: Integer): T;
begin
  CheckIndex(Index);
  Result := GetNodeByIndex(Index).value;
end;

function TLinkedList<T>.GetNodeByIndex(Index: Integer): TLinkedListNode<T>;
begin
  if (FFirst = nil) or (Index >= Count) then
    exit(nil);

  result := FFirst;

  while Assigned(result) and (Index > 0) do
  begin
    Result := Result.Next;
    dec(Index);
  end;
end;

function TLinkedList<T>.Last: TLinkedListNode<T>;
begin
  if FFirst = nil then
    exit(nil);
  result := FFirst;
  while Assigned(result.Next) do
    result := result.Next;
end;

procedure TLinkedList<T>.Remove(Value: T);
begin
  Remove(Find(Value));
end;

procedure TLinkedList<T>.Remove(Node: TLinkedListNode<T>; QueueFree: boolean = False);
begin
  CheckNode(Node);
  if Node = FFirst then
  begin
    FFirst := Node.Next;
    Node.Prev := nil;
  end
  else
  begin
    Node.Prev.Next := Node.Next;
    if Assigned(Node.Next) then
      Node.Next.Prev := Node.Prev;
  end;

  dec(FCount);

  if QueueFree then
    Node.Free;
end;

procedure TLinkedList<T>.SetItem(Index: Integer; const Value: T);
begin
  CheckIndex(Index);
  GetNodeByIndex(Index).Value := Value;
end;

function TLinkedList<T>.ToString: string;
var
  i: Integer;
begin
  Result := '[ ';
  for i := 0 to count - 1 do
  begin
    if i > 0 then
      Result := Result + ', ';

    Result := Result + GenericToString<T>(GetItem(i));
  end;
  Result := Result + ']';
end;

procedure TLinkedList<T>.CheckIndex(Index: Integer);
begin
  if (Index >= Count) or (Index < 0) then
    raise Exception.Create('Index ' + Index.tostring + ' is invalid');
end;

procedure TLinkedList<T>.CheckNode(Node: TLinkedListNode<T>);
begin
  if not Assigned(Node) then
    raise EArgumentNilException.Create('Node not assinged');

  if Node.Owner <> Self then
    raise EInvalidOp.Create('Node is not child from this object');
end;

procedure TLinkedList<T>.Clear;
var
  node: TLinkedListNode<T>;
begin
  node := Last;
  while Assigned(node) do
  begin
    if Assigned(node.Prev) then
      node.Prev.Next := nil
    else
      FFirst := nil;
    node.Free;
    node := Last;
  end;
end;

class function TLinkedList<T>.Compare(a, b: T): Integer;
begin
  Result := TComparer<T>.Default.Compare(a, b);
end;

function TLinkedList<T>.Contains(value: T): boolean;
begin
  Result := Assigned(Find(value));
end;

class function TLinkedList<T>.GenericToString<T>(aValue: T): string;
var
  ElementValue, Value: TValue;
  Data: PTypeData;
  I: Integer;
  AContext: TRttiContext;
  ARecord: TRttiRecordType;
  am: TRttiMethod;
begin
  TValue.Make(@aValue, System.TypeInfo(T), Value);

  if Value.IsArray then
  begin
    if Value.GetArrayLength = 0 then
      Exit('[ø]');

    Result := '[';

    for I := 0 to Value.GetArrayLength - 1 do
    begin
      ElementValue := Value.GetArrayElement(I);
      Result := Result + ElementValue.ToString + ',';
    end;

    Result[Length(Result)] := ']';
    Exit;
  end;

  Data := GetTypeData(Value.TypeInfo);

  if (Value.IsObject) and (Value.TypeInfo^.Kind <> tkInterface) then
    Exit(Format('0x%p %s', [pointer(Value.AsObject), Data.ClassType.ClassName]));

  if Value.TypeInfo^.Kind = tkRecord then
  begin
    AContext := TRttiContext.Create;
    ARecord := AContext.GetType(Value.TypeInfo).AsRecord;

    Writeln('>>', Ord(ARecord.GetMethod('ToString').MethodKind));

    Exit(Format('0x%p (Record ''%s'' @ %p)', [Value.GetReferenceToRawData,
      ARecord.Name, Data]));
  end;

  Result := Value.ToString;
end;

{ TEnumeratorLinkedList<T> }

constructor TEnumeratorLinkedList<T>.Create(FirstNode: TLinkedListNode<T>);
begin
  self.Node := FirstNode;
  IsFirst := true;
end;

function TEnumeratorLinkedList<T>.GetCurrent: T;
begin
  Result := node.Value;
end;

function TEnumeratorLinkedList<T>.MoveNext: Boolean;
begin
  if not Assigned(node) then
    exit(false);

  if IsFirst then
  begin
    IsFirst := false;
    exit(true);
  end;

  node := node.Next;
  Result := Assigned(node);
end;

end.

