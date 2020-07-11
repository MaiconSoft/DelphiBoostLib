unit Boost.Arrays;

interface

uses
  SysUtils, Classes, System.Generics.Collections, System.types,
  System.Generics.Defaults, logutils;

type
  TProcVar<T> = reference to procedure(var Item: T);

  TProcVar<Integer, T> = reference to procedure(index: Integer; var Item: T);

  TArray = class(System.Generics.Collections.TArray)
  private
  public
    class function SurroundIndex<T>(Index: Integer; Values: TArray<T>): Integer; static;
    class function Exchange<T>(Index1, index2: Integer; Values: TArray<T>):
      Integer; static;
    class procedure Shuffle<T>(var Values: TArray<T>); static;
    class procedure Delete<T>(Index: Integer; var Values: TArray<T>); overload; static;
    class procedure Delete<T>(Index, Count: Integer; var Values: TArray<T>);
      overload; static;
    class procedure Insert<T>(Index: Integer; const Value: T; var Values: TArray
      <T>); static;
    class function IndexOf<T>(const Value: T; const Values: TArray<T>; StartPos:
      Integer = 0): Integer; static;
    class function LastIndexOf<T>(const Value: T; var Values: TArray<T>; EndPos:
      Integer = MaxInt): Integer; static;
    class function CountItems<T>(const Value: T; const Values: TArray<T>):
      Integer; static;
    class procedure Remove<T>(Item: T; count: integer; var Values: TArray<T>); static;
    class procedure Slice<T>(StartPos, EndPos: integer; const Values: TArray<T>;
      var Return: TArray<T>); overload; static;
    class procedure Slice<T>(StartPos: integer; const Values: TArray<T>; var
      Return: TArray<T>); overload; static;
    class procedure Fill<T>(const Value: T; var Values: TArray<T>; StartIndex,
      Endindex: integer); static;
    class procedure ForEach<T>(proc: TProcVar<T>; var Values: TArray<T>);
      overload; static;
    class procedure ForEach<T>(proc: TProc<Integer, T>; const Values: TArray<T>);
      overload; static;
    class procedure ForEach<T>(proc: TProcVar<Integer, T>; var Values: TArray<T>);
      overload; static;
    class procedure ForEach<T>(proc: TProc<T>; const Values: TArray<T>); overload; static;
    class function ForEach<T>(func: TFunc<T, Integer, Boolean>; const Values:
      TArray<T>): Boolean; overload; static;
    class procedure Reverse<T>(var Values: TArray<T>); static;
    class function Every<T>(Func: TFunc<T, Boolean>; const Values: TArray<T>):
      Boolean; overload; static;
    class function Every<T>(Func: TFunc<T, Integer, Boolean>; const Values:
      TArray<T>): Boolean; overload; static;
    class procedure Filter<T>(Func: TFunc<T, Boolean>; const Values: TArray<T>;
      var Return: TArray<T>); overload; static;
    class procedure Filter<T>(Func: TFunc<T, Integer, Boolean>; const Values:
      TArray<T>; var Return: TArray<T>); overload; static;
    class function Find<T>(Func: TFunc<T, Boolean>; const Values: TArray<T>; var
      value: T): Boolean; overload; static;
    class function Find<T>(Func: TFunc<T, Integer, Boolean>; const Values:
      TArray<T>; var value: T): Boolean; overload; static;
    class procedure Clone<T>(const Values: TArray<T>; var Return: TArray<T>); static;
    class procedure Shift<T>(var Values: TArray<T>; aCount: Integer = 1); static;
    class procedure Unshift<T>(var Values: TArray<T>; aCount: Integer = 1); static;
    class procedure Union<T>(const a, b: TArray<T>; var Values: TArray<T>); static;
    class procedure Diference<T>(const a, b: TArray<T>; var Values: TArray<T>); static;
    class procedure Interception<T>(const a, b: TArray<T>; var Values: TArray<T>); static;
    class procedure Exclusion<T>(const a, b: TArray<T>; var Values: TArray<T>); static;
    class function Same<T>(const a, b: TArray<T>): boolean; static;
    class function SameData<T>(const a, b: TArray<T>): boolean; static;
    class function RemoveDuplicate<T>(var a: TArray<T>): Integer; static;
    class function PushBack<T>(var a: TArray<T>; const Default: T): T; static;
    class function PushFront<T>(var a: TArray<T>; const Default: T): T; static;
  end;

  TStringHelperDynArray = record helper for TStringDynArray
  private
    function GetItem(Index: Integer): string;
    procedure SetItem(Index: Integer; const Value: string);
    function GetCount: Integer;
    procedure SetCount(const Value: Integer);
    function GetAsComa: string;
    procedure SetAsComma(const Value: string);
  public
    function Join(const Separator: string = ' '): string;
    procedure Sort; overload;
    procedure RSort;
    procedure Shuffle;
    procedure Sort(const Comparison: TComparison<string>); overload;
    procedure Sort(const Comparison: TComparison<string>; Index, Count: integer);
      overload;
    procedure Reverse;
    function IndexOf(const Value: string; StartPos: Integer = 0): Integer;
    function LastIndexOf(const Value: string; EndPos: Integer = MaxInt): Integer;
    procedure Delete(Index: Integer); overload;
    procedure Delete(Index, Count: Integer); overload;
    procedure Insert(Index: Integer; Value: string); overload;
    procedure Insert(Index: Integer; Values: TStringDynArray); overload;
    procedure Add(Value: string); overload;
    procedure Add(Values: TStringDynArray); overload;
    function CountItems(Item: string): Integer;
    procedure Remove(Item: string); overload;
    procedure Remove(Item: string; count: integer); overload;
    procedure Clear();
    function Slice(StartPos, EndPos: integer): TStringDynArray; overload;
    function Slice(StartPos: integer): TStringDynArray; overload;
    function Head(EndPos: integer): TStringDynArray;
    function Tail(StartPos: integer): TStringDynArray;
    function Save(FileName: string): boolean;
    function Load(FileName: string): boolean;
    function Clone: TStringDynArray;
    procedure Assign(const Values: TStringDynArray); overload;
    procedure Assign(const Values: string; Separator: array of char); overload;
    procedure Assign(const Values: string; Separator: TStringDynArray); overload;
    procedure Fill(const Value: string; const StartIndex: integer = 0; const
      Endindex: integer = -1);
    property Comma: string read GetAsComa write SetAsComma;
    property Items[Index: Integer]: string read GetItem write SetItem;
    property Count: Integer read GetCount write SetCount;
    procedure ForEach(proc: TProcVar<Integer, string>); overload;
    procedure ForEach(proc: TProcVar<string>); overload;
    procedure ForEach(proc: TProc<Integer, string>); overload;
    procedure ForEach(proc: TProc<string>); overload;
    procedure _Of(const Args: array of const);
    function Every(func: TFunc<string, Boolean>): Boolean; overload;
    function Every(func: TFunc<string, Integer, Boolean>): Boolean; overload;
    function Filter(func: TFunc<string, Boolean>): TStringDynArray; overload;
    function Filter(func: TFunc<string, Integer, Boolean>): TStringDynArray; overload;
    function Find(func: TFunc<string, Integer, Boolean>): string; overload;
    function Find(func: TFunc<string, Boolean>): string; overload;
    procedure Shift(aCount: Integer = 1);
    procedure Unshift(aCount: Integer = 1);
    function Union(const Values: TStringDynArray): TStringDynArray;
    function Diference(const Values: TStringDynArray): TStringDynArray;
    function Interception(const Values: TStringDynArray): TStringDynArray;
    function Exclusion(const Values: TStringDynArray): TStringDynArray;
    function Same(const Values: TStringDynArray): Boolean;
    function SameData(const Values: TStringDynArray): Boolean;
    function RemoveDuplicate: Integer;
    procedure Trim;
    function PushBack: string;
    function PushFront: string;
    function First: string;
    function Last: string;
    function Has(const value: string): Boolean;



    // procedure From(const Values: TStringDynArray; proc: TProc<Integer, string>); overload;
    // procedure From(const Values: TStringDynArray; proc: TProc<string>); overload;
  end;

implementation

uses
  System.IOUtils;



{ TStringHelperDynArray }

function TStringHelperDynArray.Join(const Separator: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to High(self) do
  begin
    Result := Result + self[i];
    if i < high(self) then
      Result := Result + Separator;
  end;
end;

function TStringHelperDynArray.Last: string;
begin
  if count = 0 then
    exit('');
  Result := self[count - 1];
end;

function TStringHelperDynArray.LastIndexOf(const Value: string; EndPos: Integer): Integer;
begin
  Result := TArray.LastIndexOf<string>(Value, self, EndPos);
end;

function TStringHelperDynArray.Load(FileName: string): boolean;
begin
  Result := false;
  if FileExists(FileName) then
  begin
    Assign(TFile.ReadAllLines(FileName));
    Result := true;
  end;
end;

function TStringHelperDynArray.PushBack: string;
begin
  Result := TArray.PushBack<string>(self,'');
end;

function TStringHelperDynArray.PushFront: string;
begin
  Result := TArray.PushFront<string>(self,'');
end;

procedure TStringHelperDynArray.Sort;
begin
  TArray.Sort<string>(self);
end;

procedure TStringHelperDynArray.Add(Value: string);
begin
  Insert(count, Value);
//  Insert(-1, Value);
end;

procedure TStringHelperDynArray.Add(Values: TStringDynArray);
var
  i: Integer;
begin
  if Values.count > 0 then
    for i := 0 to High(Values) do
      add(Values[i]);
end;

procedure TStringHelperDynArray.Assign(const Values: string; Separator: array of char);
begin
  Assign(Values.Split(Separator));
end;

procedure TStringHelperDynArray.Assign(const Values: TStringDynArray);
begin
  Self := Values.Clone;
end;

procedure TStringHelperDynArray.Clear;
begin
  SetLength(self, 0);
end;

function TStringHelperDynArray.Clone: TStringDynArray;
begin
  Result.Count := count;
  TArray.Copy<string>(self, result, count);
end;

function TStringHelperDynArray.CountItems(Item: string): Integer;
begin
  Result := TArray.CountItems<string>(Item, Self);
end;

procedure TStringHelperDynArray.Delete(Index: Integer);
begin
  Delete(Index, 1);
end;

procedure TStringHelperDynArray.Delete(Index, Count: Integer);
begin
  TArray.Delete<string>(Index, Count, self);
end;

function TStringHelperDynArray.Diference(const Values: TStringDynArray): TStringDynArray;
begin
  TArray.Diference<string>(self, Values, Result);
end;

function TStringHelperDynArray.Every(func: TFunc<string, Integer, Boolean>): Boolean;
begin
  Result := TArray.Every<string>(func, self);
end;

function TStringHelperDynArray.Exclusion(const Values: TStringDynArray): TStringDynArray;
begin
  TArray.Exclusion<string>(self, Values, Result);
end;

function TStringHelperDynArray.Every(func: TFunc<string, Boolean>): Boolean;
begin
  Result := TArray.Every<string>(func, self);
end;

procedure TStringHelperDynArray.Fill(const Value: string; const StartIndex,
  Endindex: integer);
begin
  TArray.Fill<string>(Value, Self, StartIndex, Endindex);
end;

function TStringHelperDynArray.Filter(func: TFunc<string, Integer, Boolean>):
  TStringDynArray;
begin
  TArray.Filter<string>(func, Self, result);
end;

function TStringHelperDynArray.Find(func: TFunc<string, Boolean>): string;
begin
  Result := '';
  TArray.Find<string>(func, self, Result);
end;

function TStringHelperDynArray.First: string;
begin
  if Count = 0 then
    exit('');
  Result := self[0];
end;

function TStringHelperDynArray.Find(func: TFunc<string, Integer, Boolean>): string;
begin
  Result := '';
  TArray.Find<string>(func, self, Result);
end;

function TStringHelperDynArray.Filter(func: TFunc<string, Boolean>): TStringDynArray;
begin
  TArray.Filter<string>(func, Self, result);
end;

procedure TStringHelperDynArray.ForEach(proc: TProcVar<Integer, string>);
begin
  TArray.ForEach<string>(proc, Self);
end;

procedure TStringHelperDynArray.ForEach(proc: TProcVar<string>);
begin
  TArray.ForEach<string>(proc, Self);
end;

procedure TStringHelperDynArray.ForEach(proc: TProc<Integer, string>);
begin
  TArray.ForEach<string>(proc, Self);
end;

procedure TStringHelperDynArray.ForEach(proc: TProc<string>);
begin
  TArray.ForEach<string>(proc, Self);
end;

function TStringHelperDynArray.GetAsComa: string;
begin
  Result := join(',');
end;

function TStringHelperDynArray.GetCount: Integer;
begin
  Result := Length(self);
end;

function TStringHelperDynArray.GetItem(Index: Integer): string;
begin
  Result := Self[TArray.SurroundIndex<string>(Index, self)];
end;


function TStringHelperDynArray.IndexOf(const Value: string; StartPos: Integer =
  0): Integer;
begin
  Result := TArray.IndexOf<string>(Value, self, StartPos);
end;

procedure TStringHelperDynArray.Insert(Index: Integer; Values: TStringDynArray);
var
  i: Integer;
begin
  if Values.Count > 0 then
    for i := High(Values) downto 0 do
    begin
      Insert(Index, Values[i]);
    end;
end;

function TStringHelperDynArray.Interception(const Values: TStringDynArray):
  TStringDynArray;
begin
  TArray.Interception<string>(self, Values, Result);
end;

procedure TStringHelperDynArray.Insert(Index: Integer; Value: string);
begin
  TArray.Insert<string>(Index, Value, Self);
end;

procedure TStringHelperDynArray.Remove(Item: string);
begin
  TArray.Remove<string>(Item, 1, self);
end;

procedure TStringHelperDynArray.Remove(Item: string; count: integer);
begin
  TArray.Remove<string>(Item, count, self);
end;

function TStringHelperDynArray.RemoveDuplicate: Integer;
begin
  Result := TArray.RemoveDuplicate<string>(self);
end;

procedure TStringHelperDynArray.Reverse;
begin
  TArray.Reverse<string>(self);
end;

procedure TStringHelperDynArray.RSort;
begin
  Sort(
    function(const Left, Right: string): Integer
    begin
      Result := -1 * CompareText(Left, Right);
    end);
end;

function TStringHelperDynArray.Same(const Values: TStringDynArray): Boolean;
begin
  Result := TArray.Same<string>(self, Values);
end;

function TStringHelperDynArray.SameData(const Values: TStringDynArray): Boolean;
begin
  Result := TArray.SameData<string>(self, Values);
end;

function TStringHelperDynArray.Save(FileName: string): boolean;
begin
  TFile.WriteAllLines(FileName, Self);
  Result := true;
end;

procedure TStringHelperDynArray.SetAsComma(const Value: string);
begin
  Assign(Value.Split([',']));
end;

procedure TStringHelperDynArray.SetCount(const Value: Integer);
begin
  SetLength(self, Value);
end;

procedure TStringHelperDynArray.SetItem(Index: Integer; const Value: string);
begin
  Self[TArray.SurroundIndex<string>(Index, self)] := Value;
end;


procedure TStringHelperDynArray.Shift(aCount: Integer = 1);
begin
  TArray.Shift<string>(self);
end;

procedure TStringHelperDynArray.Shuffle;
begin
  TArray.Shuffle<string>(self);
end;

function TStringHelperDynArray.Slice(StartPos: integer): TStringDynArray;
begin
  TArray.Slice<string>(StartPos, Self, Result);
end;

function TStringHelperDynArray.Has(const value: string): Boolean;
begin
  Result := IndexOf(value) > -1;
end;

function TStringHelperDynArray.Head(EndPos: integer): TStringDynArray;
begin
  Result := Slice(0, EndPos);
end;

function TStringHelperDynArray.Tail(StartPos: integer): TStringDynArray;
begin
  Result := Slice(StartPos);
end;

procedure TStringHelperDynArray.Trim;
var
  i: Integer;
begin
  if Count > 0 then
    for i := Count - 1 downto 0 do
    begin
      self[i] := Self[i].Trim;
      if self[i].IsEmpty then
        Delete(i);
    end;
end;

function TStringHelperDynArray.Union(const Values: TStringDynArray): TStringDynArray;
begin
  TArray.Union<string>(self, Values, Result);
end;

procedure TStringHelperDynArray.Unshift(aCount: Integer = 1);
begin
  TArray.Unshift<string>(self);
end;

function TStringHelperDynArray.Slice(StartPos, EndPos: integer): TStringDynArray;
begin
  TArray.Slice<string>(StartPos, EndPos, Self, Result);
end;

procedure TStringHelperDynArray.Sort(const Comparison: TComparison<string>;
  Index, Count: integer);
begin
  TArray.Sort<string>(self, TComparer<string>.Construct(Comparison), Index, Count);
end;

procedure TStringHelperDynArray._Of(const Args: array of const);
var
  I: Integer;
begin
  Count := Length(Args);
  if Count = 0 then
    exit;

  for I := 0 to High(Args) do
    with Args[I] do
      case VType of
        vtInteger:
          self[I] := IntToStr(VInteger);
        vtBoolean:
          self[I] := BoolToStr(VBoolean, true);
        vtChar:
          self[I] := VChar;
        vtExtended:
          self[I] := FloatToStr(VExtended^);
        vtString:
          self[I] := VString^;
        vtPChar:
          self[I] := VPChar;
        vtObject:
          self[I] := VObject.ClassName;
        vtClass:
          self[I] := VClass.ClassName;
        vtAnsiString:
          self[I] := string(VAnsiString);
        vtCurrency:
          self[I] := CurrToStr(VCurrency^);
        vtVariant:
          self[I] := string(VVariant^);
        vtInt64:
          self[I] := IntToStr(VInt64^);
        vtUnicodeString:
          self[I] := string(VUnicodeString);
      end;

end;

procedure TStringHelperDynArray.Sort(const Comparison: TComparison<string>);
begin
  TArray.Sort<string>(self, TComparer<string>.Construct(Comparison));
end;

procedure TStringHelperDynArray.Assign(const Values: string; Separator: TStringDynArray);
begin
  Assign(Values.Split(Separator));
end;

{ TArray }

class function TArray.SurroundIndex<T>(Index: Integer; Values: TArray<T>): Integer;
var
  count: integer;
begin
  count := length(Values);
  if count = 0 then
    exit(-1);

  result := Index mod count;

  if result < 0 then
    exit(result + count);
end;

class procedure TArray.Union<T>(const a, b: TArray<T>; var Values: TArray<T>);
var
  Alength, rLength, i: Integer;
begin
  rLength := 0;
  Alength := Length(a);
  TArray.Clone<T>(a, Values);
  SetLength(Values, Alength + Length(b));

  if length(b) > 0 then
    for i := 0 to length(b) - 1 do
    begin
      if TArray.IndexOf<T>(b[i], a) = -1 then
      begin
        Values[Alength + rLength] := b[i];
        inc(rLength);
      end;
    end;
  SetLength(Values, Alength + rLength);
end;

class procedure TArray.Unshift<T>(var Values: TArray<T>; aCount: Integer = 1);
var
  Alength, i: Integer;
begin
  Alength := Length(Values);
  if Alength < 2 then
    exit;

  aCount := aCount mod Alength;

  if aCount > 0 then
    for i := 0 to aCount - 1 do
    begin
      TArray.Insert<T>(0, Values[Alength - 1], Values);
      SetLength(Values, Alength);
    end;
end;

class procedure TArray.Delete<T>(Index, Count: Integer; var Values: TArray<T>);
var
  i, ALength: Integer;
begin
  ALength := Length(Values);
  if ALength = 0 then
    exit;

  if Index + Count >= ALength then
  begin
    SetLength(Values, Index);
  end;

  for i := 0 to Count - 1 do
  begin
    if ((Index + i) >= Length(Values)) then
      break;
    TArray.Delete<T>(Index, Values);
  end;

end;

class procedure TArray.Diference<T>(const a, b: TArray<T>; var Values: TArray<T>);
var
  Alength, rLength, i: Integer;
begin
  rLength := 0;
  Alength := Length(a);
  SetLength(Values, Alength);

  if length(a) > 0 then
    for i := 0 to length(a) - 1 do
    begin
      if TArray.IndexOf<T>(a[i], b) = -1 then
      begin
        Values[rLength] := a[i];
        inc(rLength);
      end;
    end;
  SetLength(Values, rLength);
end;

//class procedure TArray.Delete<T>(Index, Count: Integer; var Values: TArray<T>);
//var
//  ALength: Cardinal;
//  TailElements: Cardinal;
//  i: Integer;
//begin
//  ALength := Length(Values);
//
//  if Count >= ALength then
//  begin
//    SetLength(Values, 0);
//    exit;
//  end;
//
//  Index := TArray.SurroundIndex<T>(Index, Values);
//
//  Assert(ALength > 0);
//  Assert(Index < ALength);
//
//
//  for i := Index to Index + Count - 1 do
//    Finalize(Values[i]);
//
//  TailElements := ALength - Index - Count + 1;
//  if TailElements > 0 then
//    Move(Values[Index + Count], Values[Index], SizeOf(T) * TailElements);
//  Initialize(Values[ALength - 1]);
//  SetLength(Values, ALength - Count);
//end;

class procedure TArray.Delete<T>(Index: Integer; var Values: TArray<T>);
var
  ALength: Cardinal;
  TailElements: Cardinal;
begin
  ALength := Length(Values);
  Index := TArray.SurroundIndex<T>(Index, Values);

  Assert(ALength > 0);
  Assert(Index < ALength);
  Finalize(Values[Index]);

  TailElements := ALength - Index;
  if TailElements > 0 then
    Move(Values[Index + 1], Values[Index], SizeOf(T) * TailElements);
  Initialize(Values[ALength - 1]);
  SetLength(Values, ALength - 1);
end;

class function TArray.Every<T>(Func: TFunc<T, Integer, Boolean>; const Values:
  TArray<T>): Boolean;
var
  Alength: Integer;
  i: Integer;
begin
  Alength := Length(Values);
  if (Alength = 0) or (not Assigned(Func)) then
    exit(False);

  for i := 0 to Alength - 1 do
  begin
    if not Func(Values[i], i) then
      exit(False);
  end;
  Result := true;
end;

class function TArray.Every<T>(Func: TFunc<T, Boolean>; const Values: TArray<T>): Boolean;
var
  Alength: Integer;
  i: Integer;
begin
  Alength := Length(Values);
  if (Alength = 0) or (not Assigned(Func)) then
    exit(False);

  for i := 0 to Alength - 1 do
  begin
    if not Func(Values[i]) then
      exit(False);
  end;
  Result := true;
end;

class function TArray.Exchange<T>(Index1, Index2: Integer; Values: TArray<T>): Integer;
var
  tmp: T;
begin
  Index1 := TArray.SurroundIndex<T>(Index1, Values);
  Index2 := TArray.SurroundIndex<T>(Index2, Values);
  tmp := Values[Index1];
  Values[Index1] := Values[Index2];
  Values[Index2] := tmp;
end;

class procedure TArray.Exclusion<T>(const a, b: TArray<T>; var Values: TArray<T>);
var
  Alength, rLength, i: Integer;
begin
  rLength := 0;
  Alength := Length(a);
  SetLength(Values, Alength);

  if length(a) > 0 then
    for i := 0 to length(a) - 1 do
    begin
      if TArray.IndexOf<T>(a[i], b) = -1 then
      begin
        Values[rLength] := a[i];
        inc(rLength);
      end;
    end;

  if length(b) > 0 then
    for i := 0 to length(b) - 1 do
    begin
      if TArray.IndexOf<T>(b[i], a) = -1 then
      begin
        Values[rLength] := b[i];
        inc(rLength);
      end;
    end;
  SetLength(Values, rLength);
end;

class procedure TArray.Fill<T>(const Value: T; var Values: TArray<T>; StartIndex,
  Endindex: integer);
var
  ALength: Integer;
  i: Integer;
begin
  StartIndex := TArray.SurroundIndex<T>(StartIndex, Values);
  Endindex := TArray.SurroundIndex<T>(Endindex, Values);
  ALength := Endindex - StartIndex + 1;
  if ALength <= 0 then
    exit;
  for i := 0 to ALength - 1 do
    Values[i + StartIndex] := Value;

end;

class procedure TArray.Filter<T>(Func: TFunc<T, Integer, Boolean>; const Values:
  TArray<T>; var Return: TArray<T>);
var
  Alength, AReturnLength: Integer;
  i: Integer;
begin
  Alength := Length(Values);
  if (Alength = 0) or (not Assigned(Func)) then
  begin
    SetLength(Return, 0);
    exit();
  end;

  SetLength(Return, Alength);
  AReturnLength := 0;

  for i := 0 to Alength - 1 do
  begin
    if Func(Values[i], i) then
    begin
      Return[AReturnLength] := Values[i];
      inc(AReturnLength);
    end;
  end;
  SetLength(Return, AReturnLength);
end;

class function TArray.Find<T>(Func: TFunc<T, Integer, Boolean>; const Values:
  TArray<T>; var value: T): Boolean;
var
  return: T;
begin
  if (length(Values) = 0) or (not Assigned(Func)) then
  begin
    exit(False);
  end;

  Result := not TArray.ForEach<T>(
  function(Item: T; Index: Integer): Boolean
  begin
    Result := Func(Item, Index);
    if Result then
      return := Item;
  end, Values);
  if Result then
    value := return;
end;

class function TArray.ForEach<T>(func: TFunc<T, Integer, Boolean>; const Values:
  TArray<T>): Boolean;
var
  i: Integer;
begin
  if not Assigned(func) then
    exit(False);

  for i := 0 to Length(Values) - 1 do
  begin
    if func(Values[i], i) then
      exit(False);
  end;
  Result := true;
end;

class function TArray.Find<T>(Func: TFunc<T, Boolean>; const Values: TArray<T>;
  var value: T): Boolean;
var
  return: T;
begin
  if (length(Values) = 0) or (not Assigned(Func)) then
  begin
    exit(False);
  end;

  Result := not TArray.ForEach<T>(
  function(Item: T; Index: Integer): Boolean
  begin
    Result := Func(Item);
    if Result then
      return := Item;
  end, Values);

  if Result then
    value := return;
end;

class procedure TArray.Filter<T>(Func: TFunc<T, Boolean>; const Values: TArray<T
  >; var Return: TArray<T>);
var
  Alength, AReturnLength: Integer;
  i: Integer;
begin
  Alength := Length(Values);
  if (Alength = 0) or (not Assigned(Func)) then
  begin
    SetLength(Return, 0);
    exit();
  end;

  SetLength(Return, Alength);
  AReturnLength := 0;

  for i := 0 to Alength - 1 do
  begin
    if Func(Values[i]) then
    begin
      Return[AReturnLength] := Values[i];
      inc(AReturnLength);
    end;
  end;
  SetLength(Return, AReturnLength);
end;

class procedure TArray.ForEach<T>(proc: TProcVar<Integer, T>; var Values: TArray<T>);
var
  i: Integer;
  buf: T;
begin
  if not Assigned(proc) then
    exit;
  for i := 0 to Length(Values) - 1 do
  begin
    buf := Values[i];
    proc(i, buf);
    Values[i] := buf;
  end;
end;

class procedure TArray.ForEach<T>(proc: TProcVar<T>; var Values: TArray<T>);
var
  i: Integer;
  buf: T;
begin
  if not Assigned(proc) then
    exit;
  for i := 0 to Length(Values) - 1 do
  begin
    buf := Values[i];
    proc(buf);
    Values[i] := buf;
  end;
end;

class procedure TArray.ForEach<T>(proc: TProc<Integer, T>; const Values: TArray<T>);
var
  i: Integer;
begin
  if not Assigned(proc) then
    exit;
  for i := 0 to Length(Values) - 1 do
  begin
    proc(i, Values[i]);
  end;
end;

class procedure TArray.ForEach<T>(proc: TProc<T>; const Values: TArray<T>);
var
  i: Integer;
begin
  if not Assigned(proc) then
    exit;
  for i := 0 to Length(Values) - 1 do
  begin
    proc(Values[i]);
  end;
end;

class function TArray.IndexOf<T>(const Value: T; const Values: TArray<T>;
  StartPos: Integer = 0): Integer;
var
  i, ALength: Integer;
begin
  Result := -1;
  ALength := Length(Values);
  if (ALength = 0) or (StartPos >= ALength) then
    exit();

  for i := StartPos to High(Values) do
  begin
    if TComparer<T>.Default.Compare(Value, Values[i]) = 0 then
      Exit(i);
  end;
end;

class procedure TArray.Clone<T>(const Values: TArray<T>; var Return: TArray<T>);
var
  Alength: Integer;
  i: Integer;
begin
  Alength := Length(Values);
  SetLength(Return, Alength);

  if Alength = 0 then
  begin
    exit();
  end;

  for i := 0 to Alength - 1 do
  begin
    Return[i] := Values[i];
  end;
end;

class function TArray.CountItems<T>(const Value: T; const Values: TArray<T>): Integer;
var
  i: Integer;
begin
  Result := 0;
  if Length(Values) = 0 then
    exit();

  for i := 0 to High(Values) do
  begin
    if TComparer<T>.Default.Compare(Value, Values[i]) = 0 then
      inc(Result);
  end;
end;

class procedure TArray.Insert<T>(Index: Integer; const Value: T; var Values: TArray<T>);
var
  ALength: Cardinal;
  TailElements: Cardinal;
begin

  ALength := Length(Values);
  Assert(Index <= ALength);
  SetLength(Values, ALength + 1);

  if Index = ALength then
  begin
    Values[ALength] := Value;
    exit;
  end;

  Index := TArray.SurroundIndex<T>(Index, Values);

  Finalize(Values[ALength]);
  TailElements := ALength - Index;
  if TailElements > 0 then
  begin
    Move(Values[Index], Values[Index + 1], SizeOf(T) * TailElements);
    Initialize(Values[Index]);
    Values[Index] := Value;
  end;
end;

class procedure TArray.Interception<T>(const a, b: TArray<T>; var Values: TArray<T>);
var
  Alength, rLength, i: Integer;
begin
  rLength := 0;
  Alength := Length(a);
  SetLength(Values, Alength);

  if length(a) > 0 then
    for i := 0 to length(a) - 1 do
    begin
      if TArray.IndexOf<T>(a[i], b) <> -1 then
      begin
        Values[rLength] := a[i];
        inc(rLength);
      end;
    end;
  SetLength(Values, rLength);
end;

class function TArray.LastIndexOf<T>(const Value: T; var Values: TArray<T>;
  EndPos: Integer): Integer;
var
  i, ALength: Integer;
begin
  Result := -1;
  ALength := Length(Values);
  if (ALength = 0) then
    exit();

  if EndPos >= ALength then
    EndPos := ALength - 1;

  for i := EndPos downto 0 do
  begin
    if TComparer<T>.Default.Compare(Value, Values[i]) = 0 then
      Exit(i);
  end;
end;

class function TArray.PushBack<T>(var a: TArray<T>; const Default: T): T;
var
  ALength: Integer;
begin
  ALength := Length(a);
  if ALength = 0 then
    exit(Default);

  Result := a[ALength - 1];
  SetLength(a,ALength - 1);
end;

class function TArray.PushFront<T>(var a: TArray<T>; const Default: T): T;
var
  ALength: Integer;
begin
  ALength := Length(a);
  if ALength = 0 then
    exit(Default);

  Result := a[0];
  TArray.Delete<T>(0, a);
end;

class procedure TArray.Remove<T>(Item: T; count: integer; var Values: TArray<T>);
var
  i, index: Integer;
begin
  if (Length(Values) = 0) or (count < 1) then
    exit();

  repeat
    index := TArray.IndexOf<T>(Item, Values);
    if index = -1 then
      exit;
    TArray.Delete<T>(index, 1, Values);
    dec(count);
  until (count = 0);
end;

class function TArray.RemoveDuplicate<T>(var a: TArray<T>): Integer;
var
  ALength: Integer;
  i: Integer;
  j: Integer;
begin
  ALength := length(a);
  Result := 0;

  if ALength < 2 then
    exit;

  for i := ALength - 1 downto 1 do
    for j := i - 1 downto 0 do
    begin
      if TComparer<T>.Default.Compare(a[i], a[j]) = 0 then
      begin
        TArray.Delete<T>(i, a);
        inc(Result);
        Break;
      end;
    end;
end;

class procedure TArray.Reverse<T>(var Values: TArray<T>);
var
  ALength, halfLength: Integer;
  i: Integer;
begin
  ALength := length(Values);
  if ALength < 2 then
    exit;
  halfLength := ALength div 2;

  for i := 0 to halfLength - 1 do
  begin
    TArray.Exchange<T>(i, ALength - i - 1, Values);
  end;
end;

class function TArray.Same<T>(const a, b: TArray<T>): boolean;
var
  i: Integer;
begin
  Result := false;
  if Length(a) = Length(b) then
  begin
    for i := 0 to High(a) do
    begin
      if TComparer<T>.Default.Compare(a[i], b[i]) <> 0 then
        exit;
    end;
    Result := true;
  end;
end;

class function TArray.SameData<T>(const a, b: TArray<T>): boolean;
var
  r: TArray<T>;
begin
  TArray.Diference<T>(a, b, r);
  Result := Length(r) = 0;
end;

class procedure TArray.Shift<T>(var Values: TArray<T>; aCount: Integer = 1);
var
  Alength: Integer;
  i: Integer;
begin
  Alength := Length(Values);
  if Alength < 2 then
    exit;

  aCount := aCount mod Alength;
  if aCount > 0 then
    for i := 0 to aCount - 1 do
    begin
      TArray.Insert<T>(Alength, Values[0], Values);
      TArray.Delete<T>(0, Values);
    end;
end;

class procedure TArray.Shuffle<T>(var Values: TArray<T>);
//randomize positions by swapping the position of two elements randomly
var
  randomIndex: integer;
  cnt: integer;
  count: integer;
begin
  count := length(Values);
  Randomize;

  for cnt := 0 to -1 + count do
  begin
    randomIndex := Random(-cnt + count);
    Exchange<T>(cnt, cnt + randomIndex, Values);
  end;
end;

class procedure TArray.Slice<T>(StartPos: integer; const Values: TArray<T>; var
  Return: TArray<T>);
var
  aLength: Integer;
  i: Integer;
begin
  StartPos := TArray.SurroundIndex<T>(StartPos, Values);

  aLength := Length(Values) - StartPos;
  SetLength(Return, aLength);

  for i := 0 to aLength - 1 do
    Return[i] := Values[i + StartPos];
end;

class procedure TArray.Slice<T>(StartPos, EndPos: integer; const Values: TArray<
  T>; var Return: TArray<T>);
var
  aLength: Integer;
  i: Integer;
begin
  SetLength(Return, 0);
  StartPos := TArray.SurroundIndex<T>(StartPos, Values);
  EndPos := TArray.SurroundIndex<T>(EndPos, Values);
  aLength := EndPos - StartPos + 1;

  if aLength <= 0 then
    exit;

  SetLength(Return, aLength);
  for i := StartPos to EndPos do
    Return[i - StartPos] := Values[i];

end;

end.

