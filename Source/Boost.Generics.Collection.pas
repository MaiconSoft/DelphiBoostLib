unit Boost.Generics.Collection;

interface

Type
  TQueue<T> = record
    private
     FItems:TArray<T>;
     FCapacity:Integer;
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
    constructor Create(Items:TArray<T>);
    function GetEnumerator: TEnumerator<T>;
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

  TCustomToString<T> = reference to function (e:T):string;
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
    FElements:TArray<T>;
    FCount:Integer;
    FCustomToString: TCustomToString<T>;
    procedure Init;
    function IndexOf(aElement:T):Integer;
    class function GenericToString<T>(aValue: T): string; static;
   public
    class operator Add(a, b: TSet<T>): TSet<T>;
    class operator Add(a: TSet<T>; b:T): TSet<T>;
    class operator Add(a: TSet<T>; b:TArray<T>): TSet<T>;
    class operator Subtract(a, b: TSet<T>): TSet<T>;
    class operator Subtract(a: TSet<T>; b:T): TSet<T>;
    class operator Subtract(a: TSet<T>; b:TArray<T>): TSet<T>;
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
    function Has(aElement:T):Boolean;
    procedure Add(aElement:T);overload;
    procedure Add(aElements:TSet<T>);overload;
    procedure Add(aElements:TArray<T>);overload;
    procedure Remove(aElement:T);overload;
    procedure Remove(aElements:TSet<T>);overload;
    procedure Remove(aElements:TArray<T>);overload;
    function GetEnumerator: TEnumerator<T>;
    function Equal(aOther: TSet<T>):Boolean;
    function IsSubSet(SubSet: TSet<T>):Boolean;
    function ToString:string;
    function ToArray:TArray<T>;
    constructor Create(aElement: T);overload;
    constructor Create(aElements: TSet<T>);overload;
    constructor Create(aElements: TArray<T>); overload;
    property Count: Integer read FCount;
    property CustomToString: TCustomToString<T> read FCustomToString write FCustomToString;
  end;



  function Range(start, stop: Integer; Increment: Integer=1):TRange;

implementation

uses
  System.SysUtils, System.Generics.Collections, RTTI, TypInfo;


function Range(start, stop: Integer; Increment: Integer=1):TRange;
begin
 Result:= TRange.Create(start, stop,Increment);
end;

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


{TRange }

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
 inc(FCount);
 setLength(FElements,FCount);
 FElements[FCount-1] := aElement;
 TArray.Sort<T>(FElements);
end;

procedure TSet<T>.Add(aElements: TArray<T>);
var
 e:T;
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
  FCustomToString:= aElements.CustomToString;
end;

class operator TSet<T>.Add(a, b: TSet<T>): TSet<T>;
begin
  Result:= TSet<T>.Create(a);
  Result.Add(b);
end;

constructor TSet<T>.Create(aElement: T);
begin
  Init;
  Add(aElement);
end;


class operator TSet<T>.Divide(a, b: TSet<T>): TSet<T>;
begin
  Result:= (a+b)-(a*b);
end;

class operator TSet<T>.Equal(a, b: TSet<T>): Boolean;
begin
  Result:= a.Equal(b);
end;

function TSet<T>.Equal(aOther: TSet<T>): Boolean;
var
 e:T;
begin
  if Count <> aOther.Count then
    exit(False);

  Result:= IsSubSet(aOther);
end;

function TSet<T>.GetEnumerator: TEnumerator<T>;
begin
  Result:= TEnumerator<T>.Create(FElements);
end;

class operator TSet<T>.GreaterThan(a, b: TSet<T>): Boolean;
begin
  Result:= a.IsSubSet(b);
end;

class operator TSet<T>.GreaterThanOrEqual(a, b: TSet<T>): Boolean;
begin
  Result:= a.IsSubSet(b);
end;

function TSet<T>.Has(aElement: T): Boolean;
begin
  Result:= IndexOf(aElement) > -1;
end;

class operator TSet<T>.Implicit(a: T): TSet<T>;
begin
  Result:= TSet<T>.Create(a);
end;

class operator TSet<T>.Implicit(a: TArray<T>): TSet<T>;
begin
  Result:= TSet<T>.Create(a);
end;

class operator TSet<T>.Implicit(a: TSet<T>): TArray<T>;
begin
  Result:= a.ToArray;
end;

class operator TSet<T>.Implicit(a: TSet<T>): Boolean;
begin
  Result := a.Count > 0;
end;

function TSet<T>.IndexOf(aElement: T): Integer;
begin
  if not TArray.BinarySearch<T>(FElements,aElement,Result) then
    Result:= -1;
end;

procedure TSet<T>.Init;
begin
  FCount:= 0;
  SetLength(FElements,0);
end;

function TSet<T>.IsSubSet(SubSet: TSet<T>): Boolean;
var
 e:T;
begin
  if Count < SubSet.Count then
    exit(False);

  for e in SubSet do
  begin
    if not Has(e) then
      exit(False);
  end;
  Result:= True;
end;


class operator TSet<T>.LessThan(a, b: TSet<T>): Boolean;
begin
  Result:= b.IsSubSet(a);
end;

class operator TSet<T>.LessThanOrEqual(a, b: TSet<T>): Boolean;
begin
  Result:= b.IsSubSet(a);
end;

class operator TSet<T>.Multiply(a, b: TSet<T>): TSet<T>;
var
 e:T;
begin
  Result:= TSet<T>.Create([]);

  for e in a do
    if b.Has(e) then
      Result.Add(e);
end;

class operator TSet<T>.NotEqual(a, b: TSet<T>): Boolean;
begin
  Result:= not a.Equal(b);
end;

procedure TSet<T>.Remove(aElements: TArray<T>);
var
 e:T;
begin
  for e in aElements do
    remove(e);
end;

class operator TSet<T>.Subtract(a: TSet<T>; b: TArray<T>): TSet<T>;
begin
  Result:= TSet<T>.Create(a);
  Result.Remove(b);
end;

class operator TSet<T>.Subtract(a: TSet<T>; b: T): TSet<T>;
begin
  Result:= TSet<T>.Create(a);
  Result.Remove(b);
end;

procedure TSet<T>.Remove(aElements: TSet<T>);
var
 e:T;
begin
  for e in aElements do
    remove(e);
end;

class operator TSet<T>.Subtract(a, b: TSet<T>): TSet<T>;
begin
  Result:= TSet<T>.Create(a);
  Result.Remove(b);
end;

function TSet<T>.ToArray: TArray<T>;
begin
 Result:= copy(FElements,0,FCount);
end;

function TSet<T>.ToString: string;
var
  i:Integer;
begin
  Result:= '{ ';
  if FCount > 0 then
    for i := 0 to FCount-1 do
    begin
      if i > 0 then
        Result:= Result+', ';
      if Assigned(FCustomToString) then
        Result:= Result+ FCustomToString(FElements[i])
      else
        Result:= Result+ GenericToString<T>(FElements[i]);
    end;
    Result:= Result + ' }';
end;

procedure TSet<T>.Remove(aElement: T);
var
 Index:Integer;
begin
  Index := IndexOf(aElement);
  if Index = -1 then
     exit;
  Delete(FElements,Index,1);
  Dec(FCount);
end;

procedure TSet<T>.Add(aElements: TSet<T>);
var
 e:T;
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
  Result:= a.ToString;
end;

{ TSet<T>.TEnumerator<T> }

constructor TSet<T>.TEnumerator<T>.Create(const AList: TArray<T>);
begin
  FList:= AList;
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
  Result := FIndex < length(FList);
end;

class function TSet<T>.GenericToString<T>(aValue: T): string;
var
  ElementValue, Value: TValue;
  Data: PTypeData;
  I: Integer;
  AContext: TRttiContext;
  ARecord: TRttiRecordType;
  am:TRttiMethod;
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

    Writeln('>>',Ord(ARecord.GetMethod('ToString').MethodKind));

    Exit(Format('0x%p (Record ''%s'' @ %p)', [Value.GetReferenceToRawData, ARecord.Name, Data]));
  end;

  Result := Value.ToString;
end;


end.
