//**************************************************************
// Replace Integer with a type you want, like Double for example.
// Set the right value for const DEFAULT_VALUE
// Ajust the function "_Of" for the right conversions
// Ajust others functions for the right conversions
//**************************************************************
unit Boost.Int;

interface

uses
  SysUtils, Classes, System.Generics.Collections, System.types,
  System.Generics.Defaults, logutils, Boost.Arrays, Boost.Strings;

const
  DEFAULT_VALUE: Integer = 0;
  BOOL_TO_INTEGER: array[boolean] of Integer = (0, 1);

type
  TIntegerHelperDynArray = record helper for TIntegerDynArray
  private
    function GetItem(Index: Integer): Integer;
    procedure SetItem(Index: Integer; const Value: Integer);
    function GetCount: Integer;
    procedure SetCount(const Value: Integer);
    function GetAsComa: string;
    procedure SetAsComma(const Value: string);
    class function InternalIntegerToStr(value: Integer): string; static;
    class function InternalStrToInteger(value: string; Default: Integer): Integer; static;
    class function InternalToStringDynArray(const a: TIntegerDynArray): TStringDynArray;
    class function InternalFloatToInteger(value: Extended): Integer;
    class function InternalIntegerToInteger(value: Integer): Integer;
  public
    property Items[Index: Integer]: Integer read GetItem write SetItem;
    property Count: Integer read GetCount write SetCount;
    function Join(const Separator: string): string;
    property Comma: string read GetAsComa write SetAsComma;
    procedure Sort; overload;
    procedure RSort;
    procedure Shuffle;
    procedure Sort(const Comparison: TComparison<Integer>); overload;
    procedure Sort(const Comparison: TComparison<Integer>; Index, Count: Integer);
      overload;
    procedure Reverse;
    function IndexOf(const Value: Integer; StartPos: Integer = 0): Integer;
    function LastIndexOf(const Value: Integer; EndPos: Integer = MaxInt): Integer;
    procedure Delete(Index: Integer); overload;
    procedure Delete(Index, Count: Integer); overload;
    procedure Insert(Index: Integer; Value: Integer); overload;
    procedure Insert(Index: Integer; Values: TIntegerDynArray); overload;
    procedure Add(Value: Integer); overload;
    procedure Add(Values: TIntegerDynArray); overload;
    function CountItems(Item: Integer): Integer;
    procedure Remove(Item: Integer); overload;
    procedure Remove(Item: Integer; count: Integer); overload;
    procedure Clear();
    function Slice(StartPos, EndPos: Integer): TIntegerDynArray; overload;
    function Slice(StartPos: Integer): TIntegerDynArray; overload;
    function Head(EndPos: Integer): TIntegerDynArray;
    function Tail(StartPos: Integer): TIntegerDynArray;
    function Save(FileName: string): boolean;
    function Load(FileName: string): boolean;
    function Clone: TIntegerDynArray;
    procedure Assign(const Values: TIntegerDynArray); overload;
    procedure Assign(const Values: TStringDynArray); overload;
    procedure Assign(const Values: string; Separator: array of char); overload;
    procedure Assign(const Values: string; Separator: TStringDynArray); overload;
    procedure Fill(const Value: Integer; const StartIndex: Integer = 0; const
      EndIndex: Integer = -1);
    procedure ForEach(proc: TProcVar<Integer, Integer>); overload;
    procedure ForEach(proc: TProcVar<Integer>); overload;
    procedure ForEach(proc: TProc<Integer, Integer>); overload;
    procedure ForEach(proc: TProc<Integer>); overload;
    procedure _Of(const Args: array of const);
    function Every(func: TFunc<Integer, Boolean>): Boolean; overload;
    function Every(func: TFunc<Integer, Integer, Boolean>): Boolean; overload;
    function Filter(func: TFunc<Integer, Boolean>): TIntegerDynArray; overload;
    function Filter(func: TFunc<Integer, Integer, Boolean>): TIntegerDynArray; overload;
    function Find(func: TFunc<Integer, Integer, Boolean>): Integer; overload;
    function Find(func: TFunc<Integer, Boolean>): Integer; overload;
    procedure Shift(aCount: Integer = 1);
    procedure Unshift(aCount: Integer = 1);
    function Union(const Values: TIntegerDynArray): TIntegerDynArray;
    function Diference(const Values: TIntegerDynArray): TIntegerDynArray;
    function Interception(const Values: TIntegerDynArray): TIntegerDynArray;
    function Exclusion(const Values: TIntegerDynArray): TIntegerDynArray;
    function Same(const Values: TIntegerDynArray): Boolean;
    function SameData(const Values: TIntegerDynArray): Boolean;
    function RemoveDuplicate: Integer;
    function PushBack: Integer;
    function PushFront: Integer;
    function First: Integer;
    function Last: Integer;
    function Has(const value: Integer): Boolean;
  end;

implementation

uses
  System.IOUtils;

{ TIntegerHelperDynArray }

class function TIntegerHelperDynArray.InternalStrToInteger(value: string;
  Default: Integer): Integer;
begin
  Result := StrToIntDef(value, Default);
end;

class function TIntegerHelperDynArray.InternalIntegerToStr(value: Integer): string;
begin
  Result := IntToStr(value);
end;

class function TIntegerHelperDynArray.InternalToStringDynArray(const a:
  TIntegerDynArray): TStringDynArray;
var
  buffer: TStringDynArray;
begin
  SetLength(buffer, a.Count);

  a.ForEach(
    procedure(Index: Integer; Item: Integer)
    begin
      buffer[Index] := InternalIntegerToStr(Item);
    end);
  Result := buffer;
end;

class function TIntegerHelperDynArray.InternalFloatToInteger(value: Extended): Integer;
begin
  Result := Round(value);
end;

class function TIntegerHelperDynArray.InternalIntegerToInteger(value: Integer): Integer;
begin
  Result := value;
end;

function TIntegerHelperDynArray.GetCount: Integer;
begin
  Result := Length(self);
end;

function TIntegerHelperDynArray.GetItem(Index: Integer): Integer;
begin
  Result := Self[TArray.SurroundIndex<Integer>(Index, self)];
end;

procedure TIntegerHelperDynArray.SetCount(const Value: Integer);
begin
  SetLength(self, Value);
end;

procedure TIntegerHelperDynArray.SetItem(Index: Integer; const Value: Integer);
begin
  Self[TArray.SurroundIndex<Integer>(Index, self)] := Value;
end;

function TIntegerHelperDynArray.Last: Integer;
begin
  if Count = 0 then
    exit(DEFAULT_VALUE);
  Result := self[Count - 1];
end;

function TIntegerHelperDynArray.LastIndexOf(const Value: Integer; EndPos:
  Integer): Integer;
begin
  Result := TArray.LastIndexOf<Integer>(Value, self, EndPos);
end;

function TIntegerHelperDynArray.Load(FileName: string): boolean;
begin
  Result := False;
  if FileExists(FileName) then
  begin
    Assign(TFile.ReadAllLines(FileName));
    Result := True;
  end;
end;

function TIntegerHelperDynArray.PushBack: Integer;
begin
  Result := TArray.PushBack<Integer>(self, DEFAULT_VALUE);
end;

function TIntegerHelperDynArray.PushFront: Integer;
begin
  Result := TArray.PushFront<Integer>(self, DEFAULT_VALUE);
end;

procedure TIntegerHelperDynArray.Sort;
begin
  TArray.Sort<Integer>(self);
end;

procedure TIntegerHelperDynArray.Add(Value: Integer);
begin
  Insert(Count, Value);
end;

procedure TIntegerHelperDynArray.Add(Values: TIntegerDynArray);
var
  i: Integer;
begin
  if Values.count > 0 then
    for i := 0 to High(Values) do
      add(Values[i]);
end;

procedure TIntegerHelperDynArray.Assign(const Values: string; Separator: TStringDynArray);
begin
  Assign(Values.Split(Separator));
end;

procedure TIntegerHelperDynArray.Assign(const Values: TStringDynArray);
var
  buffer: TIntegerDynArray;
begin
  buffer.Clear;
  Values.ForEach(
    procedure(Item: string)
    begin
      buffer.Add(InternalStrToInteger(Item, DEFAULT_VALUE));
    end);
  Assign(buffer);
end;

procedure TIntegerHelperDynArray.Assign(const Values: string; Separator: array of char);
begin
  Assign(Values.Split(Separator));
end;

procedure TIntegerHelperDynArray.Assign(const Values: TIntegerDynArray);
begin
  Self := Values.Clone;
end;

procedure TIntegerHelperDynArray.Clear;
begin
  SetLength(self, 0);
end;

function TIntegerHelperDynArray.Clone: TIntegerDynArray;
begin
  Result.Count := Count;
  TArray.Copy<Integer>(self, Result, Count);
end;

function TIntegerHelperDynArray.CountItems(Item: Integer): Integer;
begin
  Result := TArray.CountItems<Integer>(Item, Self);
end;

procedure TIntegerHelperDynArray.Delete(Index: Integer);
begin
  Delete(Index, 1);
end;

procedure TIntegerHelperDynArray.Delete(Index, Count: Integer);
begin
  TArray.Delete<Integer>(Index, Count, self);
end;

function TIntegerHelperDynArray.Diference(const Values: TIntegerDynArray):
  TIntegerDynArray;
begin
  TArray.Diference<Integer>(self, Values, Result);
end;

function TIntegerHelperDynArray.Every(func: TFunc<Integer, Integer, Boolean>): Boolean;
begin
  Result := TArray.Every<Integer>(func, self);
end;

function TIntegerHelperDynArray.Exclusion(const Values: TIntegerDynArray):
  TIntegerDynArray;
begin
  TArray.Exclusion<Integer>(self, Values, Result);
end;

function TIntegerHelperDynArray.Every(func: TFunc<Integer, Boolean>): Boolean;
begin
  Result := TArray.Every<Integer>(func, self);
end;

procedure TIntegerHelperDynArray.Fill(const Value: Integer; const StartIndex,
  Endindex: Integer);
begin
  TArray.Fill<Integer>(Value, Self, StartIndex, Endindex);
end;

function TIntegerHelperDynArray.Filter(func: TFunc<Integer, Integer, Boolean>):
  TIntegerDynArray;
begin
  TArray.Filter<Integer>(func, Self, Result);
end;

function TIntegerHelperDynArray.Find(func: TFunc<Integer, Boolean>): Integer;
begin
  Result := DEFAULT_VALUE;
  TArray.Find<Integer>(func, self, Result);
end;

function TIntegerHelperDynArray.First: Integer;
begin
  if Count = 0 then
    exit(DEFAULT_VALUE);
  Result := self[0];
end;

function TIntegerHelperDynArray.Find(func: TFunc<Integer, Integer, Boolean>): Integer;
begin
  Result := DEFAULT_VALUE;
  TArray.Find<Integer>(func, self, Result);
end;

function TIntegerHelperDynArray.Filter(func: TFunc<Integer, Boolean>): TIntegerDynArray;
begin
  TArray.Filter<Integer>(func, Self, Result);
end;

procedure TIntegerHelperDynArray.ForEach(proc: TProcVar<Integer, Integer>);
begin
  TArray.ForEach<Integer>(proc, Self);
end;

procedure TIntegerHelperDynArray.ForEach(proc: TProcVar<Integer>);
begin
  TArray.ForEach<Integer>(proc, Self);
end;

procedure TIntegerHelperDynArray.ForEach(proc: TProc<Integer, Integer>);
begin
  TArray.ForEach<Integer>(proc, Self);
end;

procedure TIntegerHelperDynArray.ForEach(proc: TProc<Integer>);
begin
  TArray.ForEach<Integer>(proc, Self);
end;

function TIntegerHelperDynArray.GetAsComa: string;
begin
  Result := join(',');
end;

function TIntegerHelperDynArray.IndexOf(const Value: Integer; StartPos: Integer
  = 0): Integer;
begin
  Result := TArray.IndexOf<Integer>(Value, self, StartPos);
end;

procedure TIntegerHelperDynArray.Insert(Index: Integer; Values: TIntegerDynArray);
var
  i: Integer;
begin
  if Values.Count > 0 then
    for i := High(Values) downto 0 do
    begin
      Insert(Index, Values[i]);
    end;
end;

function TIntegerHelperDynArray.Interception(const Values: TIntegerDynArray):
  TIntegerDynArray;
begin
  TArray.Interception<Integer>(self, Values, Result);
end;

function TIntegerHelperDynArray.Join(const Separator: string): string;
var
  buffer, sep: string;
begin
  buffer := '';
  sep := Separator;

  ForEach(
    procedure(Index: Integer; Item: Integer)
    begin
      if Index > 0 then
        buffer := buffer + sep;
      buffer := buffer + InternalIntegerToStr(Item);
    end);

  Result := buffer;
end;

procedure TIntegerHelperDynArray.Insert(Index: Integer; Value: Integer);
begin
  TArray.Insert<Integer>(Index, Value, Self);
end;

procedure TIntegerHelperDynArray.Remove(Item: Integer);
begin
  TArray.Remove<Integer>(Item, 1, self);
end;

procedure TIntegerHelperDynArray.Remove(Item: Integer; count: Integer);
begin
  TArray.Remove<Integer>(Item, count, self);
end;

function TIntegerHelperDynArray.RemoveDuplicate: Integer;
begin
  Result := TArray.RemoveDuplicate<Integer>(self);
end;

procedure TIntegerHelperDynArray.Reverse;
begin
  TArray.Reverse<Integer>(self);
end;

procedure TIntegerHelperDynArray.RSort;
begin
  Sort(
    function(const Left, Right: Integer): Integer
    begin
      Result := Integer(Left < Right);
    end);
end;

function TIntegerHelperDynArray.Same(const Values: TIntegerDynArray): Boolean;
begin
  Result := TArray.Same<Integer>(self, Values);
end;

function TIntegerHelperDynArray.SameData(const Values: TIntegerDynArray): Boolean;
begin
  Result := TArray.SameData<Integer>(self, Values);
end;

function TIntegerHelperDynArray.Save(FileName: string): boolean;
begin
  TFile.WriteAllLines(FileName, InternalToStringDynArray(self));
  Result := True;
end;

procedure TIntegerHelperDynArray.SetAsComma(const Value: string);
begin
  Assign(Value.Split([',']));
end;

procedure TIntegerHelperDynArray.Shift(aCount: Integer = 1);
begin
  TArray.Shift<Integer>(self);
end;

procedure TIntegerHelperDynArray.Shuffle;
begin
  TArray.Shuffle<Integer>(self);
end;

function TIntegerHelperDynArray.Slice(StartPos: Integer): TIntegerDynArray;
begin
  TArray.Slice<Integer>(StartPos, Self, Result);
end;

function TIntegerHelperDynArray.Has(const value: Integer): Boolean;
begin
  Result := IndexOf(value) > -1;
end;

function TIntegerHelperDynArray.Head(EndPos: Integer): TIntegerDynArray;
begin
  Result := Slice(0, EndPos);
end;

function TIntegerHelperDynArray.Tail(StartPos: Integer): TIntegerDynArray;
begin
  Result := Slice(StartPos);
end;

function TIntegerHelperDynArray.Union(const Values: TIntegerDynArray): TIntegerDynArray;
begin
  TArray.Union<Integer>(self, Values, Result);
end;

procedure TIntegerHelperDynArray.Unshift(aCount: Integer = 1);
begin
  TArray.Unshift<Integer>(self);
end;

function TIntegerHelperDynArray.Slice(StartPos, EndPos: Integer): TIntegerDynArray;
begin
  TArray.Slice<Integer>(StartPos, EndPos, Self, Result);
end;

procedure TIntegerHelperDynArray.Sort(const Comparison: TComparison<Integer>;
  Index, Count: Integer);
begin
  TArray.Sort<Integer>(self, TComparer<Integer>.Construct(Comparison), Index, Count);
end;

procedure TIntegerHelperDynArray._Of(const Args: array of const);
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
          self[I] := InternalIntegerToInteger(VInteger);
        vtBoolean:
          self[I] := BOOL_TO_Integer[VBoolean];
        vtChar:
          self[I] := InternalStrToInteger(VChar, DEFAULT_VALUE);
        vtExtended:
          self[I] := InternalFloatToInteger(VExtended^);
        vtString:
          self[I] := InternalStrToInteger(VString^, DEFAULT_VALUE);
        vtPChar:
          self[I] := InternalStrToInteger(VPChar, DEFAULT_VALUE);
        vtObject:
          self[I] := InternalIntegerToInteger(cardinal(VObject));
        vtClass:
          self[I] := InternalIntegerToInteger(cardinal(VClass));
        vtAnsiString:
          self[I] := InternalStrToInteger(string(VAnsiString), DEFAULT_VALUE);
        vtCurrency:
          self[I] := InternalFloatToInteger(VCurrency^);
        vtVariant:
          self[I] := Integer(VVariant^);
        vtInt64:
          self[I] := InternalIntegerToInteger(Integer(VInt64^));
        vtUnicodeString:
          self[I] := InternalStrToInteger(string(VUnicodeString), DEFAULT_VALUE);
      end;
end;

procedure TIntegerHelperDynArray.Sort(const Comparison: TComparison<Integer>);
begin
  TArray.Sort<Integer>(self, TComparer<Integer>.Construct(Comparison));
end;

end.
