unit Boost.Generics.Collection;

interface

uses System.SysUtils, System.Generics.Defaults;

Type
  TQueue<T> = record
  private
    FItems: TArray<T>;
    FCapacity: Integer;

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
  public
    constructor Create(Items: TArray<T>);
    function GetEnumerator: TEnumerator<T>;
    function Enqueue(const Value: T): Boolean; inline;
    function Dequeue: T; inline;
    function Peek: T; inline;
    function Count: Integer; inline;
    procedure Clear;
    function IsFull: Boolean;
    function IsEmpty: Boolean;
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
    FItems: TArray<T>;
    FCapacity: Integer;
  public
    function GetEnumerator: TEnumerator<T>;
    constructor Create(Items: TArray<T>);
    function Push(const Value: T): Boolean; inline;
    function Pop: T; inline;
    function Peek: T; inline;
    procedure Clear;
    function Count: Integer; inline;
    function IsFull: Boolean;
    function IsEmpty: Boolean;
    function ToArray: TArray<T>;
    procedure TrimExcess;
    property Capacity: Integer read FCapacity write FCapacity;
  end;

  TRange = record
  private
    Fincrement: Integer;
    FIndex: Integer;
    FStart, FStop, FValue: Integer;
    function GetCurrent: Integer; inline;
  public
    constructor Create(start, stop, Increment: Integer);
    function MoveNext: Boolean; inline;
    function GetEnumerator: TRange;
    property Current: Integer read GetCurrent;
  end;

  TCustomToString<T> = reference to function(e: T): string;

  TSet<T> = record
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
    FElements: TArray<T>;
    FCount: Integer;
    FCustomToString: TCustomToString<T>;
    procedure Init;
    function IndexOf(aElement: T): Integer;
    class function GenericToString<T>(aValue: T): string; static;
  public
    class operator Add(a, b: TSet<T>): TSet<T>;
    class operator Add(a: TSet<T>; b: T): TSet<T>;
    class operator Add(a: TSet<T>; b: TArray<T>): TSet<T>;
    class operator Subtract(a, b: TSet<T>): TSet<T>;
    class operator Subtract(a: TSet<T>; b: T): TSet<T>;
    class operator Subtract(a: TSet<T>; b: TArray<T>): TSet<T>;
    class operator Multiply(a, b: TSet<T>): TSet<T>;
    class operator Divide(a, b: TSet<T>): TSet<T>;
    class operator LessThan(a, b: TSet<T>): Boolean;
    class operator LessThanOrEqual(a, b: TSet<T>): Boolean;
    class operator GreaterThan(a, b: TSet<T>): Boolean;
    class operator GreaterThanOrEqual(a, b: TSet<T>): Boolean;
    class operator NotEqual(a, b: TSet<T>): Boolean;
    class operator Equal(a, b: TSet<T>): Boolean;
    class operator Implicit(a: T): TSet<T>;
    class operator Implicit(a: TArray<T>): TSet<T>;
    class operator Implicit(a: TSet<T>): string;
    class operator Implicit(a: TSet<T>): TArray<T>;
    class operator Implicit(a: TSet<T>): Boolean;
    function Has(aElement: T): Boolean;
    procedure Add(aElement: T); overload;
    procedure Add(aElements: TSet<T>); overload;
    procedure Add(aElements: TArray<T>); overload;
    procedure Remove(aElement: T); overload;
    procedure Remove(aElements: TSet<T>); overload;
    procedure Remove(aElements: TArray<T>); overload;
    function GetEnumerator: TEnumerator<T>;
    function Equal(aOther: TSet<T>): Boolean;
    function IsSubSet(SubSet: TSet<T>): Boolean;
    function ToString: string;
    function ToArray: TArray<T>;
    constructor Create(aElement: T); overload;
    constructor Create(aElements: TSet<T>); overload;
    constructor Create(aElements: TArray<T>); overload;
    property Count: Integer read FCount;
    property CustomToString: TCustomToString<T> read FCustomToString
      write FCustomToString;
  end;

  TDictionary<TKEY, TVal> = record
  private
    FKeys: TArray<TKEY>;
    FValues: TArray<TVal>;
    function GetItem(key: TKEY): TVal;
    procedure SetItem(key: TKEY; const Value: TVal);
    function IndexOf(key: TKEY): Integer;
    function GetItemDef(key: TKEY; Def: TVal): TVal;
    procedure Exchange(i, j: Integer);
    class function GenericToString<T>(aValue: T): string; static;
    function Same(a: TDictionary<TKEY, TVal>): Boolean;
    class function CompareKey(a, b: TKEY): Integer; static;
    class function CompareValue(a, b: TVal): Integer; static;
  public
    class operator Implicit(a: TDictionary<TKEY, TVal>): string;
    class operator Implicit(a: TDictionary<TKEY, TVal>): Integer;
    class operator Equal(a: TDictionary<TKEY, TVal>; b: Integer): Boolean;
    class operator NotEqual(a: TDictionary<TKEY, TVal>; b: Integer): Boolean;
    class operator GreaterThan(a: TDictionary<TKEY, TVal>; b: Integer): Boolean;
    class operator GreaterThanOrEqual(a: TDictionary<TKEY, TVal>;
      b: Integer): Boolean;
    class operator LessThan(a: TDictionary<TKEY, TVal>; b: Integer): Boolean;
    class operator LessThanOrEqual(a: TDictionary<TKEY, TVal>;
      b: Integer): Boolean;
    class operator Add(a: TDictionary<TKEY, TVal>; b: Integer): Integer;
    class operator Subtract(a: TDictionary<TKEY, TVal>; b: Integer): Integer;
    class operator Multiply(a: TDictionary<TKEY, TVal>; b: Integer): Integer;
    class operator Divide(a: TDictionary<TKEY, TVal>; b: Integer): Double;
    class operator IntDivide(a: TDictionary<TKEY, TVal>; b: Integer): Integer;
    class operator Modulus(a: TDictionary<TKEY, TVal>; b: Integer): Integer;
    class operator Negative(a: TDictionary<TKEY, TVal>): Integer;
    class operator Positive(a: TDictionary<TKEY, TVal>): Integer;
    class operator Add(a, b: TDictionary<TKEY, TVal>): TDictionary<TKEY, TVal>;
    class operator Subtract(a, b: TDictionary<TKEY, TVal>)
      : TDictionary<TKEY, TVal>;
    class operator Equal(a, b: TDictionary<TKEY, TVal>): Boolean;
    class operator NotEqual(a, b: TDictionary<TKEY, TVal>): Boolean;
    procedure Init;
    procedure Remove(key: TKEY); overload;
    procedure Remove(keys: TArray<TKEY>); overload;
    procedure SortByKey; overload;
    procedure SortByValue; overload;
    procedure Sort(Custom: TFunc<TKEY, TKEY, TVal, TVal, Integer>); overload;
    function Count: Integer;
    procedure Clear;
    function ToString: string;
    procedure Add(key: TKEY; Value: TVal); overload;
    procedure Add(aKeys: TArray<TKEY>; aValues: TArray<TVal>); overload;
    function HasKey(key: TKEY): Boolean;
    function HasValue(Value: TVal): Boolean;
    constructor Create(aKeys: TArray<TKEY>; aValues: TArray<TVal>);
    property Item[key: TKEY]: TVal read GetItem write SetItem; default;
    property Item[key: TKEY; Def: TVal]: TVal read GetItemDef; default;
    property keys: TArray<TKEY> read FKeys;
    property Values: TArray<TVal> read FValues;
  end;

  TPriorityQueue<T> = record
  private type
    TPair<T> = record
      Priority: Integer;
      Value: T;
      constructor Create(Priority: Integer; Value: T);
    end;
  private
    FItems: TArray<TPair<T>>;
    FCapacity: Integer;
    FEnableSort: Boolean;
    procedure Sort(); overload;
    procedure Sort(Custom: TFunc<TPair<T>, TPair<T>, Integer>); overload;

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
  public
    constructor Create(Items: TArray<T>; Priorities: TArray<Integer>);
    function GetEnumerator: TEnumerator<T>;
    function Enqueue(const Value: T; const Priority: Integer = Integer.MinValue)
      : Boolean; inline;
    function Dequeue: T; inline;
    function DequeueEx: TPair<T>; inline;
    function Peek: T; inline;
    function Count: Integer; inline;
    procedure Clear;
    function IsFull: Boolean;
    function IsEmpty: Boolean;
    function ToArray: TArray<T>;
    procedure TrimExcess;
    property Capacity: Integer read FCapacity write FCapacity;
  end;

  TArrays<T> = record
  private
    FItems: TArray<T>;
    FIndex: Integer;
    function GetItem(Index: Integer): T;
    procedure SetItem(Index: Integer; const Value: T);
    function GetCurrent: T;
    class operator Implicit(a: TArray<T>): TArrays<T>;
    class operator Implicit(a: TArrays<T>): TArray<T>;
    class function Compare(a, b: T): Integer; static;
    class function ToString(a: T): string; overload; static;
    function GetLength: Integer;
    procedure SetLength(const Value: Integer);
  public
    class function Create(Items: TArray<T>): TArrays<T>; static;
    procedure Assign(Items: TArray<T>);
    function MoveNext: Boolean; inline;
    function GetEnumerator: TArrays<T>;
    procedure Insert(const Index: Integer; const Value: T); overload;
    procedure Insert(const Index: Integer; const Value: TArray<T>); overload;
    procedure Insert(const Index: Integer; const Value: TArrays<T>); overload;
    procedure Add(const Value: T); overload;
    procedure Add(const Value: TArray<T>); overload;
    procedure Add(const Value: TArrays<T>); overload;
    procedure Delete(const Index: Integer); overload;
    procedure Delete(const Index, Count: Integer); overload;
    procedure Clear;
    procedure Sort(Custom: TFunc<T, T, Integer>); overload;
    procedure Sort; overload;
    procedure SortReverse;
    procedure Reverse;
    procedure Shuffle;
    function IndexOf(const Value: T; StartPos: Integer = 0): Integer;
    function ToString: string; overload;
    procedure Exchange(const Index1, index2: Integer);
    function Max: T;
    function Min: T;
    function IsEmpty: Boolean;
    function Clone(Len: Integer = MaxInt): TArrays<T>;
    function Group: TDictionary<T, Integer>;
    property Current: T read GetCurrent;
    property AsArray: TArray<T> read FItems;
    property Items[Index: Integer]: T read GetItem write SetItem; default;
    property Length: Integer read GetLength write SetLength;
  end;

function Range(start, stop: Integer; Increment: Integer = 1): TRange; overload;
function Range(Count: Integer): TRange; overload;

implementation

uses
  System.Generics.Collections, Boost.arrays, RTTI, TypInfo;

function Range(start, stop: Integer; Increment: Integer = 1): TRange;
begin
  Result := TRange.Create(start, stop, Increment);
end;

function Range(Count: Integer): TRange;
begin
  Result := TRange.Create(0, Count - 1, 1);
end;

{ TQueue }

constructor TQueue<T>.TEnumerator<T>.Create(const AList: TArray<T>);
begin
  FList := AList;
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
  Result := FIndex < Length(FList);
end;

procedure TQueue<T>.Clear;
begin
  SetLength(FItems, 0);
end;

function TQueue<T>.Count: Integer;
begin
  Result := Length(FItems);
end;

constructor TQueue<T>.Create(Items: TArray<T>);
var
  i: Integer;
begin
  FCapacity := -1;
  SetLength(FItems, 0);
  if Length(Items) > 0 then
    for i := 0 to High(Items) do
      Enqueue(Items[i]);
end;

function TQueue<T>.Dequeue: T;
begin
  if IsEmpty then
    raise EArgumentOutOfRangeException.Create('Queue is Empty');
  Result := FItems[high(FItems)];
  Delete(FItems, high(FItems), 1);
end;

function TQueue<T>.Enqueue(const Value: T): Boolean;
begin
  if IsFull then
    exit(False);
  Insert([Value], FItems, 0);
  Result := True;
end;

function TQueue<T>.GetEnumerator: TEnumerator<T>;
begin
  Result := TEnumerator<T>.Create(FItems);
end;

function TQueue<T>.IsEmpty: Boolean;
begin
  Result := Count = 0;
end;

function TQueue<T>.IsFull: Boolean;
begin
  Result := (FCapacity > 0) and (Count >= FCapacity);
end;

function TQueue<T>.Peek: T;
begin
  Result := FItems[high(FItems)];
end;

function TQueue<T>.ToArray: TArray<T>;
begin
  Result := FItems;
end;

procedure TQueue<T>.TrimExcess;
begin
  while Count > FCapacity do
    Dequeue;
end;

{ TStack<T> }

procedure TStack<T>.Clear;
begin
  SetLength(FItems, 0);
end;

function TStack<T>.Count: Integer;
begin
  Result := Length(FItems);
end;

constructor TStack<T>.Create(Items: TArray<T>);
var
  i: Integer;
begin
  FCapacity := -1;
  SetLength(FItems, 0);
  if Length(Items) > 0 then
    for i := 0 to High(Items) do
      Push(Items[i]);
end;

function TStack<T>.GetEnumerator: TEnumerator<T>;
begin
  Result := TEnumerator<T>.Create(FItems);
end;

function TStack<T>.IsEmpty: Boolean;
begin
  Result := Count = 0;
end;

function TStack<T>.IsFull: Boolean;
begin
  Result := (FCapacity > 0) and (Count >= FCapacity);
end;

function TStack<T>.Peek: T;
begin
  Result := FItems[high(FItems)];
end;

function TStack<T>.Pop: T;
begin
  if IsEmpty then
    raise EArgumentOutOfRangeException.Create('Stack is Empty');
  Result := FItems[high(FItems)];
  Delete(FItems, high(FItems), 1);
end;

function TStack<T>.Push(const Value: T): Boolean;
begin
  if IsFull then
    exit(False);
  SetLength(FItems, Count + 1);
  FItems[high(FItems)] := Value;
  Result := True;
end;

function TStack<T>.ToArray: TArray<T>;
begin
  Result := FItems;
end;

procedure TStack<T>.TrimExcess;
begin
  while Count > FCapacity do
    Pop;
end;

{ TStack<T>.TEnumerator<T> }

constructor TStack<T>.TEnumerator<T>.Create(const AList: TArray<T>);
begin
  FList := AList;
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
  Result := FIndex < Length(FList);
end;

{ TRange }

constructor TRange.Create(start, stop, Increment: Integer);
begin
  FStart := start;
  FStop := stop;
  Fincrement := Increment;
  FValue := start - Increment;
end;

function TRange.GetCurrent: Integer;
begin
  Result := FValue;
end;

function TRange.GetEnumerator: TRange;
begin
  Result := self;
end;

function TRange.MoveNext: Boolean;
begin
  FValue := FValue + Fincrement;
  if (Fincrement > 0) and (FValue > FStop) then
    exit(False);

  if (Fincrement < 0) and (FValue < FStop) then
    exit(False);

  Result := True;
end;
{ TSet<T> }

procedure TSet<T>.Add(aElement: T);
begin
  if Has(aElement) then
    exit;
  Inc(FCount);
  SetLength(FElements, FCount);
  FElements[FCount - 1] := aElement;
  TArray.Sort<T>(FElements);
end;

procedure TSet<T>.Add(aElements: TArray<T>);
var
  e: T;
begin
  for e in aElements do
    Add(e);
end;

class operator TSet<T>.Add(a: TSet<T>; b: TArray<T>): TSet<T>;
begin
  Result := TSet<T>.Create(a);
  Result.Add(b);
end;

class operator TSet<T>.Add(a: TSet<T>; b: T): TSet<T>;
begin
  Result := TSet<T>.Create(a);
  Result.Add(b);
end;

constructor TSet<T>.Create(aElements: TSet<T>);
begin
  Init;
  Add(aElements);
  FCustomToString := aElements.CustomToString;
end;

class operator TSet<T>.Add(a, b: TSet<T>): TSet<T>;
begin
  Result := TSet<T>.Create(a);
  Result.Add(b);
end;

constructor TSet<T>.Create(aElement: T);
begin
  Init;
  Add(aElement);
end;

class operator TSet<T>.Divide(a, b: TSet<T>): TSet<T>;
begin
  Result := (a + b) - (a * b);
end;

class operator TSet<T>.Equal(a, b: TSet<T>): Boolean;
begin
  Result := a.Equal(b);
end;

function TSet<T>.Equal(aOther: TSet<T>): Boolean;
var
  e: T;
begin
  if Count <> aOther.Count then
    exit(False);

  Result := IsSubSet(aOther);
end;

function TSet<T>.GetEnumerator: TEnumerator<T>;
begin
  Result := TEnumerator<T>.Create(FElements);
end;

class operator TSet<T>.GreaterThan(a, b: TSet<T>): Boolean;
begin
  Result := a.IsSubSet(b);
end;

class operator TSet<T>.GreaterThanOrEqual(a, b: TSet<T>): Boolean;
begin
  Result := a.IsSubSet(b);
end;

function TSet<T>.Has(aElement: T): Boolean;
begin
  Result := IndexOf(aElement) > -1;
end;

class operator TSet<T>.Implicit(a: T): TSet<T>;
begin
  Result := TSet<T>.Create(a);
end;

class operator TSet<T>.Implicit(a: TArray<T>): TSet<T>;
begin
  Result := TSet<T>.Create(a);
end;

class operator TSet<T>.Implicit(a: TSet<T>): TArray<T>;
begin
  Result := a.ToArray;
end;

class operator TSet<T>.Implicit(a: TSet<T>): Boolean;
begin
  Result := a.Count > 0;
end;

function TSet<T>.IndexOf(aElement: T): Integer;
begin
  if not TArray.BinarySearch<T>(FElements, aElement, Result) then
    Result := -1;
end;

procedure TSet<T>.Init;
begin
  FCount := 0;
  SetLength(FElements, 0);
end;

function TSet<T>.IsSubSet(SubSet: TSet<T>): Boolean;
var
  e: T;
begin
  if Count < SubSet.Count then
    exit(False);

  for e in SubSet do
  begin
    if not Has(e) then
      exit(False);
  end;
  Result := True;
end;

class operator TSet<T>.LessThan(a, b: TSet<T>): Boolean;
begin
  Result := b.IsSubSet(a);
end;

class operator TSet<T>.LessThanOrEqual(a, b: TSet<T>): Boolean;
begin
  Result := b.IsSubSet(a);
end;

class operator TSet<T>.Multiply(a, b: TSet<T>): TSet<T>;
var
  e: T;
begin
  Result := TSet<T>.Create([]);

  for e in a do
    if b.Has(e) then
      Result.Add(e);
end;

class operator TSet<T>.NotEqual(a, b: TSet<T>): Boolean;
begin
  Result := not a.Equal(b);
end;

procedure TSet<T>.Remove(aElements: TArray<T>);
var
  e: T;
begin
  for e in aElements do
    Remove(e);
end;

class operator TSet<T>.Subtract(a: TSet<T>; b: TArray<T>): TSet<T>;
begin
  Result := TSet<T>.Create(a);
  Result.Remove(b);
end;

class operator TSet<T>.Subtract(a: TSet<T>; b: T): TSet<T>;
begin
  Result := TSet<T>.Create(a);
  Result.Remove(b);
end;

procedure TSet<T>.Remove(aElements: TSet<T>);
var
  e: T;
begin
  for e in aElements do
    Remove(e);
end;

class operator TSet<T>.Subtract(a, b: TSet<T>): TSet<T>;
begin
  Result := TSet<T>.Create(a);
  Result.Remove(b);
end;

function TSet<T>.ToArray: TArray<T>;
begin
  Result := copy(FElements, 0, FCount);
end;

function TSet<T>.ToString: string;
var
  i: Integer;
begin
  Result := '{ ';
  if FCount > 0 then
    for i := 0 to FCount - 1 do
    begin
      if i > 0 then
        Result := Result + ', ';
      if Assigned(FCustomToString) then
        Result := Result + FCustomToString(FElements[i])
      else
        Result := Result + GenericToString<T>(FElements[i]);
    end;
  Result := Result + ' }';
end;

procedure TSet<T>.Remove(aElement: T);
var
  Index: Integer;
begin
  Index := IndexOf(aElement);
  if Index = -1 then
    exit;
  Delete(FElements, Index, 1);
  Dec(FCount);
end;

procedure TSet<T>.Add(aElements: TSet<T>);
var
  e: T;
begin
  for e in aElements do
    Add(e);
end;

constructor TSet<T>.Create(aElements: TArray<T>);
begin
  Init;
  Add(aElements);
end;

class operator TSet<T>.Implicit(a: TSet<T>): string;
begin
  Result := a.ToString;
end;

{ TSet<T>.TEnumerator<T> }

constructor TSet<T>.TEnumerator<T>.Create(const AList: TArray<T>);
begin
  FList := AList;
  FIndex := -1;
end;

function TSet<T>.TEnumerator<T>.DoGetCurrent: T;
begin
  Result := Current;
end;

function TSet<T>.TEnumerator<T>.DoMoveNext: Boolean;
begin
  Result := MoveNext;
end;

function TSet<T>.TEnumerator<T>.GetCurrent: T;
begin
  Result := FList[FIndex];
end;

function TSet<T>.TEnumerator<T>.MoveNext: Boolean;
begin
  Inc(FIndex);
  Result := FIndex < Length(FList);
end;

class function TSet<T>.GenericToString<T>(aValue: T): string;
var
  ElementValue, Value: TValue;
  Data: PTypeData;
  i: Integer;
  AContext: TRttiContext;
  ARecord: TRttiRecordType;
  am: TRttiMethod;
begin
  TValue.Make(@aValue, System.TypeInfo(T), Value);

  if Value.IsArray then
  begin
    if Value.GetArrayLength = 0 then
      exit('[�]');

    Result := '[';

    for i := 0 to Value.GetArrayLength - 1 do
    begin
      ElementValue := Value.GetArrayElement(i);
      Result := Result + ElementValue.ToString + ',';
    end;

    Result[Length(Result)] := ']';
    exit;
  end;

  Data := GetTypeData(Value.TypeInfo);

  if (Value.IsObject) and (Value.TypeInfo^.Kind <> tkInterface) then
    exit(Format('0x%p %s', [pointer(Value.AsObject),
      Data.ClassType.ClassName]));

  if Value.TypeInfo^.Kind = tkRecord then
  begin
    AContext := TRttiContext.Create;
    ARecord := AContext.GetType(Value.TypeInfo).AsRecord;

    Writeln('>>', Ord(ARecord.GetMethod('ToString').MethodKind));

    exit(Format('0x%p (Record ''%s'' @ %p)', [Value.GetReferenceToRawData,
      ARecord.Name, Data]));
  end;

  Result := Value.ToString;
end;

{ TDictionary<TKEY, TVal> }

procedure TDictionary<TKEY, TVal>.Add(key: TKEY; Value: TVal);
var
  Index: Integer;
begin
  if HasKey(key) then
  begin
    SetItem(key, Value);
    exit;
  end;

  TArray.Insert<TKEY>(Length(FKeys), key, FKeys);
  TArray.Insert<TVal>(Length(FValues), Value, FValues);
end;

procedure TDictionary<TKEY, TVal>.Add(aKeys: TArray<TKEY>;
  aValues: TArray<TVal>);
var
  Max, kLen, vLen, i: Integer;
begin
  kLen := Length(aKeys);
  vLen := Length(aValues);

  If (kLen > vLen) then
    Max := vLen
  else
    Max := kLen;

  if Max > 0 then
    for i := 0 to Max - 1 do
      Add(aKeys[i], aValues[i]);
end;

class operator TDictionary<TKEY, TVal>.Add(a: TDictionary<TKEY, TVal>;
  b: Integer): Integer;
begin
  Result := a.Count + b;
end;

class operator TDictionary<TKEY, TVal>.Add(a, b: TDictionary<TKEY, TVal>)
  : TDictionary<TKEY, TVal>;
begin
  Result := TDictionary<TKEY, TVal>.Create(a.FKeys, a.Values);
  Result.Add(b.FKeys, b.Values);
end;

procedure TDictionary<TKEY, TVal>.Clear;
begin
  SetLength(FKeys, 0);
  SetLength(FValues, 0);
end;

class function TDictionary<TKEY, TVal>.CompareKey(a, b: TKEY): Integer;
begin
  Result := TComparer<TKEY>.Default.Compare(a, b);
end;

class function TDictionary<TKEY, TVal>.CompareValue(a, b: TVal): Integer;
begin
  Result := TComparer<TVal>.Default.Compare(a, b);
end;

function TDictionary<TKEY, TVal>.Count: Integer;
begin
  Result := Length(FKeys);
end;

constructor TDictionary<TKEY, TVal>.Create(aKeys: TArray<TKEY>;
  aValues: TArray<TVal>);
begin
  Init;
  Add(aKeys, aValues);
end;

class operator TDictionary<TKEY, TVal>.Divide(a: TDictionary<TKEY, TVal>;
  b: Integer): Double;
begin
  Result := a.Count / b;
end;

class operator TDictionary<TKEY, TVal>.Equal(a: TDictionary<TKEY, TVal>;
  b: Integer): Boolean;
begin
  Result := a.Count = b;
end;

class operator TDictionary<TKEY, TVal>.Equal(a,
  b: TDictionary<TKEY, TVal>): Boolean;
begin
  Result := a.Same(b);
end;

procedure TDictionary<TKEY, TVal>.Exchange(i, j: Integer);
var
  k: TKEY;
  v: TVal;
begin
  k := FKeys[i];
  v := FValues[i];
  FKeys[i] := FKeys[j];
  FValues[i] := FValues[j];
  FKeys[j] := k;
  FValues[j] := v;
end;

function TDictionary<TKEY, TVal>.GetItem(key: TKEY): TVal;
var
  Index: Integer;
begin
  Index := IndexOf(key);
  if (Index < 0) or (Index > Count) then
    raise EArgumentOutOfRangeException.Create('Index:' + index.ToString +
      ' out range ');
  Result := FValues[Index];
end;

function TDictionary<TKEY, TVal>.GetItemDef(key: TKEY; Def: TVal): TVal;
begin
  if HasKey(key) then
    Result := Item[key]
  else
    Result := Def;
end;

class operator TDictionary<TKEY, TVal>.GreaterThan(a: TDictionary<TKEY, TVal>;
  b: Integer): Boolean;
begin
  Result := a.Count > b;
end;

class operator TDictionary<TKEY, TVal>.GreaterThanOrEqual
  (a: TDictionary<TKEY, TVal>; b: Integer): Boolean;
begin
  Result := a.Count >= b;
end;

function TDictionary<TKEY, TVal>.HasKey(key: TKEY): Boolean;
var
  Index: Integer;
begin
  Index := IndexOf(key);
  Result := Index > -1;

end;

function TDictionary<TKEY, TVal>.HasValue(Value: TVal): Boolean;
begin
  Result := TArray.IndexOf<TVal>(Value, FValues, 0) > -1;
end;

class operator TDictionary<TKEY, TVal>.Implicit
  (a: TDictionary<TKEY, TVal>): string;
begin
  Result := a.ToString;
end;

class operator TDictionary<TKEY, TVal>.Implicit
  (a: TDictionary<TKEY, TVal>): Integer;
begin
  Result := a.Count;
end;

function TDictionary<TKEY, TVal>.IndexOf(key: TKEY): Integer;
begin
  Result := TArray.IndexOf<TKEY>(key, FKeys, 0);
end;

procedure TDictionary<TKEY, TVal>.Init;
begin
  Clear;
end;

class operator TDictionary<TKEY, TVal>.IntDivide(a: TDictionary<TKEY, TVal>;
  b: Integer): Integer;
begin
  Result := a.Count div b;
end;

class operator TDictionary<TKEY, TVal>.LessThan(a: TDictionary<TKEY, TVal>;
  b: Integer): Boolean;
begin
  Result := a.Count < b;
end;

class operator TDictionary<TKEY, TVal>.LessThanOrEqual
  (a: TDictionary<TKEY, TVal>; b: Integer): Boolean;
begin
  Result := a.Count <= b;
end;

class operator TDictionary<TKEY, TVal>.Modulus(a: TDictionary<TKEY, TVal>;
  b: Integer): Integer;
begin
  Result := a.Count mod b;
end;

class operator TDictionary<TKEY, TVal>.Multiply(a: TDictionary<TKEY, TVal>;
  b: Integer): Integer;
begin
  Result := a.Count * b;
end;

class operator TDictionary<TKEY, TVal>.Negative
  (a: TDictionary<TKEY, TVal>): Integer;
begin
  Result := -a.Count;
end;

class operator TDictionary<TKEY, TVal>.NotEqual(a,
  b: TDictionary<TKEY, TVal>): Boolean;
begin
  Result := not a.Same(b);
end;

class operator TDictionary<TKEY, TVal>.NotEqual(a: TDictionary<TKEY, TVal>;
  b: Integer): Boolean;
begin
  Result := a.Count <> b;
end;

class operator TDictionary<TKEY, TVal>.Positive
  (a: TDictionary<TKEY, TVal>): Integer;
begin
  Result := a.Count;
end;

procedure TDictionary<TKEY, TVal>.Remove(keys: TArray<TKEY>);
var
  key: TKEY;
begin
  for key in keys do
    Remove(key);
end;

procedure TDictionary<TKEY, TVal>.Remove(key: TKEY);
var
  Index: Integer;
begin
  Index := IndexOf(key);
  if Index > -1 then
  begin
    TArray.Delete<TKEY>(Index, FKeys);
    TArray.Delete<TVal>(Index, FValues);
  end;
end;

function TDictionary<TKEY, TVal>.Same(a: TDictionary<TKEY, TVal>): Boolean;
var
  i: Integer;
  key: TKEY;
begin
  if Count <> a.Count then
    exit(False);

  for key in FKeys do
  begin
    if not a.HasKey(key) then
      exit(False);

    if CompareValue(a[key], Item[key]) <> 0 then
      exit(False);
  end;
  Result := True;
end;

procedure TDictionary<TKEY, TVal>.SetItem(key: TKEY; const Value: TVal);
var
  Index: Integer;
begin
  Index := IndexOf(key);
  if Index > -1 then
    FValues[Index] := Value
  else
    Add(key, Value);
end;

procedure TDictionary<TKEY, TVal>.Sort(Custom: TFunc<TKEY, TKEY, TVal, TVal,
  Integer>);
var
  i, j: Integer;
begin
  if not Assigned(Custom) or (Count = 0) then
    exit;
  for i := 0 to High(FKeys) - 1 do
    for j := i + 1 to High(keys) do
      if Custom(FKeys[i], FKeys[j], FValues[i], FValues[j]) > 0 then
        Exchange(i, j);
end;

procedure TDictionary<TKEY, TVal>.SortByValue;
begin
  Sort(
    function(keyLeft, keyRight: TKEY; ValueLeft, ValueRight: TVal): Integer
    begin
      Result := CompareValue(ValueLeft, ValueRight);
    end);
end;

class operator TDictionary<TKEY, TVal>.Subtract(a, b: TDictionary<TKEY, TVal>)
  : TDictionary<TKEY, TVal>;
begin
  Result := TDictionary<TKEY, TVal>.Create(a.FKeys, a.Values);
  Result.Remove(b.FKeys);
end;

class operator TDictionary<TKEY, TVal>.Subtract(a: TDictionary<TKEY, TVal>;
b: Integer): Integer;
begin
  Result := a.Count - b;
end;

function TDictionary<TKEY, TVal>.ToString: string;
var
  i: Integer;
  key, Val: string;

begin
  Result := '[';
  if Count > 0 then
    for i := 0 to Count - 1 do
    begin
      if i > 0 then
        Result := Result + ', ';
      key := GenericToString<TKEY>(FKeys[i]);
      Val := GenericToString<TVal>(FValues[i]);

      Result := Result + Format('(%s: %s)', [key, Val]);
    end;
  Result := Result + ']';
end;

procedure TDictionary<TKEY, TVal>.SortByKey;
begin
  Sort(
    function(keyLeft, keyRight: TKEY; ValueLeft, ValueRight: TVal): Integer
    begin
      Result := CompareKey(keyLeft, keyRight);
    end);
end;

class function TDictionary<TKEY, TVal>.GenericToString<T>(aValue: T): string;
var
  ElementValue, Value: TValue;
  Data: PTypeData;
  i: Integer;
  AContext: TRttiContext;
  ARecord: TRttiRecordType;
  am: TRttiMethod;
begin
  TValue.Make(@aValue, System.TypeInfo(T), Value);

  if Value.IsArray then
  begin
    if Value.GetArrayLength = 0 then
      exit('[�]');

    Result := '[';

    for i := 0 to Value.GetArrayLength - 1 do
    begin
      ElementValue := Value.GetArrayElement(i);
      Result := Result + ElementValue.ToString + ',';
    end;

    Result[Length(Result)] := ']';
    exit;
  end;

  Data := GetTypeData(Value.TypeInfo);

  if (Value.IsObject) and (Value.TypeInfo^.Kind <> tkInterface) then
    exit(Format('0x%p %s', [pointer(Value.AsObject),
      Data.ClassType.ClassName]));

  if Value.TypeInfo^.Kind = tkRecord then
  begin
    AContext := TRttiContext.Create;
    ARecord := AContext.GetType(Value.TypeInfo).AsRecord;

    Writeln('>>', Ord(ARecord.GetMethod('ToString').MethodKind));

    exit(Format('0x%p (Record ''%s'' @ %p)', [Value.GetReferenceToRawData,
      ARecord.Name, Data]));
  end;

  Result := Value.ToString;
end;

{ TArrays<T> }

procedure TArrays<T>.Add(const Value: TArray<T>);
begin
  Insert(MaxInt, Value);
end;

procedure TArrays<T>.Add(const Value: TArrays<T>);
begin
  Add(Value.FItems);
end;

procedure TArrays<T>.Assign(Items: TArray<T>);
begin
  FItems := copy(Items, 0, System.Length(Items));
end;

procedure TArrays<T>.Add(const Value: T);
begin
  Insert(MaxInt, Value);
end;

procedure TArrays<T>.Clear;
begin
  SetLength(0);
end;

function TArrays<T>.Clone(Len: Integer = MaxInt): TArrays<T>;
begin
  Result.FItems := copy(FItems, 0, Len);
end;

class function TArrays<T>.Compare(a, b: T): Integer;
begin
  Result := TComparer<T>.Default.Compare(a, b);
end;

class function TArrays<T>.Create(Items: TArray<T>): TArrays<T>;
begin
  Result.Assign(Items);
end;

procedure TArrays<T>.Delete(const Index, Count: Integer);
begin
  System.Delete(FItems, Index, Count);
end;

procedure TArrays<T>.Exchange(const Index1, index2: Integer);
var
  tmp: T;
begin
  tmp := FItems[Index1];
  FItems[Index1] := FItems[index2];
  FItems[index2] := tmp;
end;

procedure TArrays<T>.Delete(const Index: Integer);
begin
  Delete(Index, 1);
end;

function TArrays<T>.GetCurrent: T;
begin
  Result := FItems[FIndex];
end;

function TArrays<T>.GetEnumerator: TArrays<T>;
begin
  FIndex := -1;
  Result := self;
end;

function TArrays<T>.GetItem(Index: Integer): T;
begin
  Result := FItems[Index];
end;

class operator TArrays<T>.Implicit(a: TArray<T>): TArrays<T>;
begin
  Result.FItems := copy(a, 0, System.Length(a));
end;

class operator TArrays<T>.Implicit(a: TArrays<T>): TArray<T>;
begin
  Result := copy(a.FItems, 0, a.Length);
end;

procedure TArrays<T>.Insert(const Index: Integer; const Value: TArray<T>);
begin
  System.Insert(Value, FItems, Index);
end;

function TArrays<T>.IndexOf(const Value: T; StartPos: Integer): Integer;
var
  i, ALength: Integer;
begin
  Result := -1;
  ALength := Length;

  if (ALength = 0) or (StartPos >= ALength) then
    exit();

  for i := StartPos to ALength - 1 do
  begin
    if Compare(Value, Items[i]) = 0 then
      exit(i);
  end;
end;

procedure TArrays<T>.Insert(const Index: Integer; const Value: TArrays<T>);
begin
  Insert(Index, Value.FItems);
end;

function TArrays<T>.IsEmpty: Boolean;
begin
  Result := Length = 0;
end;

function TArrays<T>.GetLength: Integer;
begin
  Result := System.Length(FItems);
end;

function TArrays<T>.Group: TDictionary<T, Integer>;
var
  e: T;
begin
  Result.Init;
  for e in FItems do
    Result[e] := Result[e, 0] + 1;
end;

procedure TArrays<T>.Insert(const Index: Integer; const Value: T);
begin
  System.Insert(Value, FItems, Index);
end;

function TArrays<T>.Max: T;
var
  e: T;
begin
  if Length = 0 then
    raise Exception.Create('Array empty, can''t get max value');
  Result := FItems[0];
  for e in FItems do
  begin
    if Compare(e, Result) > 0 then
      Result := e;
  end;
end;

function TArrays<T>.Min: T;
var
  e: T;
begin
  if Length = 0 then
    raise Exception.Create('Array empty, can''t get max value');
  Result := FItems[0];
  for e in FItems do
  begin
    if Compare(e, Result) < 0 then
      Result := e;
  end;
end;

function TArrays<T>.MoveNext: Boolean;
begin
  Inc(FIndex);
  Result := FIndex < Length;
end;

procedure TArrays<T>.Reverse;
var
  ALength, halfLength: Integer;
  i: Integer;
begin
  ALength := Length;
  if ALength < 2 then
    exit;
  halfLength := ALength div 2;

  for i := 0 to halfLength - 1 do
    Exchange(i, ALength - i - 1);
end;

procedure TArrays<T>.SetItem(Index: Integer; const Value: T);
begin
  FItems[Index] := Value;
end;

procedure TArrays<T>.SetLength(const Value: Integer);
begin
  System.SetLength(self.FItems, Value);
end;

procedure TArrays<T>.Shuffle;
var
  randomIndex: Integer;
  cnt: Integer;
  Count: Integer;
begin
  Count := Length;
  Randomize;

  for cnt := 0 to -1 + Count do
  begin
    randomIndex := Random(-cnt + Count);
    Exchange(cnt, cnt + randomIndex);
  end;
end;

procedure TArrays<T>.Sort;
begin
  Sort(
    function(Left, Right: T): Integer
    begin
      Result := Compare(Left, Right);
    end);
end;

procedure TArrays<T>.SortReverse;
begin
  Sort(
    function(Left, Right: T): Integer
    begin
      Result := -Compare(Left, Right);
    end);
end;

procedure TArrays<T>.Sort(Custom: TFunc<T, T, Integer>);
var
  i, j, ALength: Integer;
begin
  ALength := Length;
  if (ALength > 0) and (Assigned(Custom)) then
    for i := 0 to ALength - 2 do
      for j := i + 1 to ALength - 1 do
        if Custom(Items[i], Items[j]) > 0 then
          Exchange(i, j);
end;

function TArrays<T>.ToString(): string;
var
  i, ALength: Integer;
begin
  ALength := Length;
  Result := '[ ';

  for i := 0 to ALength - 1 do
  begin
    if i > 0 then
      Result := Result + ', ';
    Result := Result + ToString(Items[i]);
  end;
  Result := Result + ']';
end;

class function TArrays<T>.ToString(a: T): string;
var
  ElementValue, Value: TValue;
  Data: PTypeData;
  i: Integer;
  AContext: TRttiContext;
  ARecord: TRttiRecordType;
  am: TRttiMethod;
begin
  TValue.Make(@a, System.TypeInfo(T), Value);

  if Value.IsArray then
  begin
    if Value.GetArrayLength = 0 then
      exit('[�]');

    Result := '[';

    for i := 0 to Value.GetArrayLength - 1 do
    begin
      ElementValue := Value.GetArrayElement(i);
      Result := Result + ElementValue.ToString + ',';
    end;

    Result[System.Length(Result)] := ']';
    exit;
  end;

  Data := GetTypeData(Value.TypeInfo);

  if (Value.IsObject) and (Value.TypeInfo^.Kind <> tkInterface) then
    exit(Format('0x%p %s', [pointer(Value.AsObject),
      Data.ClassType.ClassName]));

  if Value.TypeInfo^.Kind = tkRecord then
  begin
    AContext := TRttiContext.Create;
    ARecord := AContext.GetType(Value.TypeInfo).AsRecord;

    Writeln('>>', Ord(ARecord.GetMethod('ToString').MethodKind));

    exit(Format('0x%p (Record ''%s'' @ %p)', [Value.GetReferenceToRawData,
      ARecord.Name, Data]));
  end;

  Result := Value.ToString;
end;

{ TPriorityQueue<T>.TPair<T> }

constructor TPriorityQueue<T>.TPair<T>.Create(Priority: Integer; Value: T);
begin
  self.Priority := Priority;
  self.Value := Value;
end;

{ TPriorityQueue<T> }

procedure TPriorityQueue<T>.Clear;
begin
  SetLength(FItems, 0);
end;

function TPriorityQueue<T>.Count: Integer;
begin
  Result := Length(FItems);
end;

constructor TPriorityQueue<T>.Create(Items: TArray<T>;
Priorities: TArray<Integer>);
var
  i, Priority: Integer;
begin
  FCapacity := -1;
  SetLength(FItems, 0);
  FEnableSort := False;
  if Length(Items) > 0 then
    for i := 0 to High(Items) do
    begin

      if (Length(Priorities) > i) then
        Priority := Priorities[i]
      else
        Priority := Integer.MinValue;
      Enqueue(Items[i], Priority);
    end;
  FEnableSort := True;
  Sort;
end;

function TPriorityQueue<T>.Dequeue: T;
begin
  Result := DequeueEx.Value;
end;

function TPriorityQueue<T>.DequeueEx: TPair<T>;
begin
  if IsEmpty then
    raise EArgumentOutOfRangeException.Create('Queue is Empty');
  Result := FItems[high(FItems)];
  Delete(FItems, high(FItems), 1);
end;

function TPriorityQueue<T>.Enqueue(const Value: T;
const Priority: Integer): Boolean;
begin
  if IsFull then
    exit(False);
  Insert([TPair<T>.Create(Priority, Value)], FItems, 0);
  Result := True;
  Sort;
end;

function TPriorityQueue<T>.GetEnumerator: TEnumerator<T>;
begin
  Result := TEnumerator<T>.Create(ToArray);
end;

function TPriorityQueue<T>.IsEmpty: Boolean;
begin
  Result := Count = 0;
end;

function TPriorityQueue<T>.IsFull: Boolean;
begin
  Result := (FCapacity > 0) and (Count >= FCapacity);
end;

function TPriorityQueue<T>.Peek: T;
begin
  Result := FItems[high(FItems)].Value;
end;

procedure TPriorityQueue<T>.Sort;
begin
  if (FEnableSort) then
    Sort(
      function(Left, Right: TPair<T>): Integer
      begin
        if (Right.Priority < Left.Priority) then
          Result := 1
        else
          Result := -1;
      end);
end;

procedure TPriorityQueue<T>.Sort(Custom: TFunc<TPair<T>, TPair<T>, Integer>);
var
  i, j, ALength: Integer;
  tmp: TPair<T>;
begin
  ALength := Count;
  if (ALength > 0) and (Assigned(Custom)) then
    for i := 0 to ALength - 2 do
      for j := i + 1 to ALength - 1 do
        if Custom(FItems[i], FItems[j]) > 0 then
        begin
          tmp := FItems[i];
          FItems[i] := FItems[j];
          FItems[j] := tmp;
        end;
end;

function TPriorityQueue<T>.ToArray: TArray<T>;
var
  i: Integer;
begin
  SetLength(Result, 0);

  if (IsEmpty) then
    exit;

  SetLength(Result, Count);

  for i := 0 to Count - 1 do
    Result[Count - 1 - i] := FItems[i].Value;
end;

procedure TPriorityQueue<T>.TrimExcess;
begin
  if (Count > FCapacity) then
  begin
    FEnableSort := False;
    while Count > FCapacity do
      Dequeue;
    FEnableSort := True;
    Sort;
  end;
end;

{ TPriorityQueue<T>.TEnumerator<T> }

constructor TPriorityQueue<T>.TEnumerator<T>.Create(const AList: TArray<T>);
begin
  FList := AList;
  FIndex := -1;
end;

function TPriorityQueue<T>.TEnumerator<T>.DoGetCurrent: T;
begin
  Result := Current;
end;

function TPriorityQueue<T>.TEnumerator<T>.DoMoveNext: Boolean;
begin
  Result := MoveNext;
end;

function TPriorityQueue<T>.TEnumerator<T>.GetCurrent: T;
begin
  Result := FList[FIndex];
end;

function TPriorityQueue<T>.TEnumerator<T>.MoveNext: Boolean;
begin
  Inc(FIndex);
  Result := FIndex < Length(FList);
end;

end.
