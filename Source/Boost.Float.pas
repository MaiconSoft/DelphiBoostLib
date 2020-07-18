//**************************************************************
// Replace Double with a type you want, like Double for example.
// Set the right value for const DEFAULT_VALUE
// Ajust the function "_Of" for the right conversions
// Ajust others functions for the right conversions
//**************************************************************
unit Boost.Float;

interface

uses
  SysUtils, Classes, System.Generics.Collections, System.Generics.Defaults,
  logutils, System.types, Boost.Arrays, Boost.Strings;

const
  DEFAULT_VALUE: Double = 0.0;
  BOOL_TO_DOUBLE: array[boolean] of Double = (0.0, 1.0);

type
  TDoubleHelperDynArray = record helper for TDoubleDynArray
  private
    function GetItem(Index: Integer): Double;
    procedure SetItem(Index: Integer; const Value: Double);
    function GetCount: Integer;
    procedure SetCount(const Value: Integer);
    function GetAsComa: string;
    procedure SetAsComma(const Value: string);
    class function InternalDoubleToStr(value: Double): string; static;
    class function InternalStrToDouble(value: string; Default: Double): Double; static;
    class function InternalToStringDynArray(const a: TDoubleDynArray): TStringDynArray;
    class function InternalFloatToDouble(value: Extended): Double;
    class function InternalIntegerToDouble(value: Integer): Double;
  public
    property Items[Index: Integer]: Double read GetItem write SetItem;
    property Count: Integer read GetCount write SetCount;
    function Join(const Separator: string): string;
    property Comma: string read GetAsComa write SetAsComma;
    procedure Sort; overload;
    procedure RSort;
    procedure Shuffle;
    procedure Sort(const Comparison: TComparison<Double>); overload;
    procedure Sort(const Comparison: TComparison<Double>; Index, Count: Integer);
      overload;
    procedure Reverse;
    function IndexOf(const Value: Double; StartPos: Integer = 0): Integer;
    function LastIndexOf(const Value: Double; EndPos: Integer = MaxInt): Integer;
    procedure Delete(Index: Integer); overload;
    procedure Delete(Index, Count: Integer); overload;
    procedure Insert(Index: Integer; Value: Double); overload;
    procedure Insert(Index: Integer; Values: TDoubleDynArray); overload;
    procedure Add(Value: Double); overload;
    procedure Add(Values: TDoubleDynArray); overload;
    function CountItems(Item: Double): Integer;
    procedure Remove(Item: Double); overload;
    procedure Remove(Item: Double; count: Integer); overload;
    procedure Clear();
    function Slice(StartPos, EndPos: Integer): TDoubleDynArray; overload;
    function Slice(StartPos: Integer): TDoubleDynArray; overload;
    function Head(EndPos: Integer): TDoubleDynArray;
    function Tail(StartPos: Integer): TDoubleDynArray;
    function Save(FileName: string): boolean;
    function Load(FileName: string): boolean;
    function Clone: TDoubleDynArray;
    procedure Assign(const Values: TDoubleDynArray); overload;
    procedure Assign(const Values: TStringDynArray); overload;
    procedure Assign(const Values: string; Separator: array of char); overload;
    procedure Assign(const Values: string; Separator: TStringDynArray); overload;
    procedure Fill(const Value: Double; const StartIndex: Integer = 0; const
      EndIndex: Integer = -1);
    procedure ForEach(proc: TProcVar<Integer, Double>); overload;
    procedure ForEach(proc: TProcVar<Double>); overload;
    procedure ForEach(proc: TProc<Integer, Double>); overload;
    procedure ForEach(proc: TProc<Double>); overload;
    procedure _Of(const Args: array of const);
    function Every(func: TFunc<Double, Boolean>): Boolean; overload;
    function Every(func: TFunc<Double, Integer, Boolean>): Boolean; overload;
    function Filter(func: TFunc<Double, Boolean>): TDoubleDynArray; overload;
    function Filter(func: TFunc<Double, Integer, Boolean>): TDoubleDynArray; overload;
    function Find(func: TFunc<Double, Integer, Boolean>): Double; overload;
    function Find(func: TFunc<Double, Boolean>): Double; overload;
    procedure Shift(aCount: Integer = 1);
    procedure Unshift(aCount: Integer = 1);
    function Union(const Values: TDoubleDynArray): TDoubleDynArray;
    function Diference(const Values: TDoubleDynArray): TDoubleDynArray;
    function Interception(const Values: TDoubleDynArray): TDoubleDynArray;
    function Exclusion(const Values: TDoubleDynArray): TDoubleDynArray;
    function Same(const Values: TDoubleDynArray): Boolean;
    function SameData(const Values: TDoubleDynArray): Boolean;
    function RemoveDuplicate: Integer;
    function PushBack: Double;
    function PushFront: Double;
    function First: Double;
    function Last: Double;
    function Has(const value: Double): Boolean;
//    function Max:Double;
//    function Min:Double;
//    function Mean:Double;
//    function Sum:Double;overload;
//    procedure Normalize;
//    procedure Multiply(value:Double); overload;
//    procedure Divide(value:Double); overload;
//    procedure Sum(value:Double); overload;
//    procedure Apply(func: Tfunc<double,double>);
//    function Sum(values:TDoubleDynArray):TDoubleDynArray; overload;
//    function Multiply(value:TDoubleDynArray):TDoubleDynArray; overload;
//    function Divide(value:TDoubleDynArray):TDoubleDynArray; overload;
//    procedure sqr;overload;
//    procedure sqrt;overload;
//    function sqr(value:TDoubleDynArray):TDoubleDynArray; overload;
//    function sqrt(value:TDoubleDynArray):TDoubleDynArray; overload;
//    procedure Clamp(aMin,aMax:Double);
//    procedure Map(inMin,inMax,outMin,outMax:Double);

  end;

implementation

uses
  System.IOUtils;

{ TDoubleHelperDynArray }

class function TDoubleHelperDynArray.InternalStrToDouble(value: string; Default:
  Double): Double;
begin
  Result := StrToFloatDef(value, Default);
end;

class function TDoubleHelperDynArray.InternalDoubleToStr(value: Double): string;
begin
  Result := FloatToStr(value);
end;

class function TDoubleHelperDynArray.InternalToStringDynArray(const a:
  TDoubleDynArray): TStringDynArray;
var
  buffer: TStringDynArray;
begin
  SetLength(buffer, a.Count);

  a.ForEach(
    procedure(Index: Integer; Item: Double)
    begin
      buffer[Index] := InternalDoubleToStr(Item);
    end);
  Result := buffer;
end;

class function TDoubleHelperDynArray.InternalFloatToDouble(value: Extended): Double;
begin
  Result := value;
end;

class function TDoubleHelperDynArray.InternalIntegerToDouble(value: Integer): Double;
begin
  Result := value;
end;

function TDoubleHelperDynArray.GetCount: Integer;
begin
  Result := Length(self);
end;

function TDoubleHelperDynArray.GetItem(Index: Integer): Double;
begin
  Result := Self[TArray.SurroundIndex<Double>(Index, self)];
end;

procedure TDoubleHelperDynArray.SetCount(const Value: Integer);
begin
  SetLength(self, Value);
end;

procedure TDoubleHelperDynArray.SetItem(Index: Integer; const Value: Double);
begin
  Self[TArray.SurroundIndex<Double>(Index, self)] := Value;
end;

function TDoubleHelperDynArray.Last: Double;
begin
  if Count = 0 then
    exit(DEFAULT_VALUE);
  Result := self[Count - 1];
end;

function TDoubleHelperDynArray.LastIndexOf(const Value: Double; EndPos: Integer): Integer;
begin
  Result := TArray.LastIndexOf<Double>(Value, self, EndPos);
end;

function TDoubleHelperDynArray.Load(FileName: string): boolean;
begin
  Result := False;
  if FileExists(FileName) then
  begin
    Assign(TFile.ReadAllLines(FileName));
    Result := True;
  end;
end;

function TDoubleHelperDynArray.PushBack: Double;
begin
  Result := TArray.PushBack<Double>(self, DEFAULT_VALUE);
end;

function TDoubleHelperDynArray.PushFront: Double;
begin
  Result := TArray.PushFront<Double>(self, DEFAULT_VALUE);
end;

procedure TDoubleHelperDynArray.Sort;
begin
  TArray.Sort<Double>(self);
end;

procedure TDoubleHelperDynArray.Add(Value: Double);
begin
  Insert(Count, Value);
end;

procedure TDoubleHelperDynArray.Add(Values: TDoubleDynArray);
var
  i: Integer;
begin
  if Values.count > 0 then
    for i := 0 to High(Values) do
      add(Values[i]);
end;

procedure TDoubleHelperDynArray.Assign(const Values: string; Separator: TStringDynArray);
begin
  Assign(Values.Split(Separator));
end;

procedure TDoubleHelperDynArray.Assign(const Values: TStringDynArray);
var
  buffer: TDoubleDynArray;
begin
  buffer.Clear;
  Values.ForEach(
    procedure(Item: string)
    begin
      buffer.Add(InternalStrToDouble(Item, DEFAULT_VALUE));
    end);
  Assign(buffer);
end;

procedure TDoubleHelperDynArray.Assign(const Values: string; Separator: array of char);
begin
  Assign(Values.Split(Separator));
end;

procedure TDoubleHelperDynArray.Assign(const Values: TDoubleDynArray);
begin
  Self := Values.Clone;
end;

procedure TDoubleHelperDynArray.Clear;
begin
  SetLength(self, 0);
end;

function TDoubleHelperDynArray.Clone: TDoubleDynArray;
begin
  Result.Count := Count;
  TArray.Copy<Double>(self, Result, Count);
end;

function TDoubleHelperDynArray.CountItems(Item: Double): Integer;
begin
  Result := TArray.CountItems<Double>(Item, Self);
end;

procedure TDoubleHelperDynArray.Delete(Index: Integer);
begin
  Delete(Index, 1);
end;

procedure TDoubleHelperDynArray.Delete(Index, Count: Integer);
begin
  TArray.Delete<Double>(Index, Count, self);
end;

function TDoubleHelperDynArray.Diference(const Values: TDoubleDynArray): TDoubleDynArray;
begin
  TArray.Diference<Double>(self, Values, Result);
end;

function TDoubleHelperDynArray.Every(func: TFunc<Double, Integer, Boolean>): Boolean;
begin
  Result := TArray.Every<Double>(func, self);
end;

function TDoubleHelperDynArray.Exclusion(const Values: TDoubleDynArray): TDoubleDynArray;
begin
  TArray.Exclusion<Double>(self, Values, Result);
end;

function TDoubleHelperDynArray.Every(func: TFunc<Double, Boolean>): Boolean;
begin
  Result := TArray.Every<Double>(func, self);
end;

procedure TDoubleHelperDynArray.Fill(const Value: Double; const StartIndex,
  Endindex: Integer);
begin
  TArray.Fill<Double>(Value, Self, StartIndex, Endindex);
end;

function TDoubleHelperDynArray.Filter(func: TFunc<Double, Integer, Boolean>):
  TDoubleDynArray;
begin
  TArray.Filter<Double>(func, Self, Result);
end;

function TDoubleHelperDynArray.Find(func: TFunc<Double, Boolean>): Double;
begin
  Result := DEFAULT_VALUE;
  TArray.Find<Double>(func, self, Result);
end;

function TDoubleHelperDynArray.First: Double;
begin
  if Count = 0 then
    exit(DEFAULT_VALUE);
  Result := self[0];
end;

function TDoubleHelperDynArray.Find(func: TFunc<Double, Integer, Boolean>): Double;
begin
  Result := DEFAULT_VALUE;
  TArray.Find<Double>(func, self, Result);
end;

function TDoubleHelperDynArray.Filter(func: TFunc<Double, Boolean>): TDoubleDynArray;
begin
  TArray.Filter<Double>(func, Self, Result);
end;

procedure TDoubleHelperDynArray.ForEach(proc: TProcVar<Integer, Double>);
begin
  TArray.ForEach<Double>(proc, Self);
end;

procedure TDoubleHelperDynArray.ForEach(proc: TProcVar<Double>);
begin
  TArray.ForEach<Double>(proc, Self);
end;

procedure TDoubleHelperDynArray.ForEach(proc: TProc<Integer, Double>);
begin
  TArray.ForEach<Double>(proc, Self);
end;

procedure TDoubleHelperDynArray.ForEach(proc: TProc<Double>);
begin
  TArray.ForEach<Double>(proc, Self);
end;

function TDoubleHelperDynArray.GetAsComa: string;
begin
  Result := join(',');
end;

function TDoubleHelperDynArray.IndexOf(const Value: Double; StartPos: Integer =
  0): Integer;
begin
  Result := TArray.IndexOf<Double>(Value, self, StartPos);
end;

procedure TDoubleHelperDynArray.Insert(Index: Integer; Values: TDoubleDynArray);
var
  i: Integer;
begin
  if Values.Count > 0 then
    for i := High(Values) downto 0 do
    begin
      Insert(Index, Values[i]);
    end;
end;

function TDoubleHelperDynArray.Interception(const Values: TDoubleDynArray):
  TDoubleDynArray;
begin
  TArray.Interception<Double>(self, Values, Result);
end;

function TDoubleHelperDynArray.Join(const Separator: string): string;
var
  buffer, sep: string;
begin
  buffer := '';
  sep := Separator;

  ForEach(
    procedure(Index: Integer; Item: Double)
    begin
      if Index > 0 then
        buffer := buffer + sep;
      buffer := buffer + InternalDoubleToStr(Item);
    end);

  Result := buffer;
end;

procedure TDoubleHelperDynArray.Insert(Index: Integer; Value: Double);
begin
  TArray.Insert<Double>(Index, Value, Self);
end;

procedure TDoubleHelperDynArray.Remove(Item: Double);
begin
  TArray.Remove<Double>(Item, 1, self);
end;

procedure TDoubleHelperDynArray.Remove(Item: Double; count: Integer);
begin
  TArray.Remove<Double>(Item, count, self);
end;

function TDoubleHelperDynArray.RemoveDuplicate: Integer;
begin
  Result := TArray.RemoveDuplicate<Double>(self);
end;

procedure TDoubleHelperDynArray.Reverse;
begin
  TArray.Reverse<Double>(self);
end;

procedure TDoubleHelperDynArray.RSort;
begin
  Sort(
    function(const Left, Right: Double): Integer
    begin
      Result := Integer(Left < Right);
    end);
end;

function TDoubleHelperDynArray.Same(const Values: TDoubleDynArray): Boolean;
begin
  Result := TArray.Same<Double>(self, Values);
end;

function TDoubleHelperDynArray.SameData(const Values: TDoubleDynArray): Boolean;
begin
  Result := TArray.SameData<Double>(self, Values);
end;

function TDoubleHelperDynArray.Save(FileName: string): boolean;
begin
  TFile.WriteAllLines(FileName, InternalToStringDynArray(self));
  Result := True;
end;

procedure TDoubleHelperDynArray.SetAsComma(const Value: string);
begin
  Assign(Value.Split([',']));
end;

procedure TDoubleHelperDynArray.Shift(aCount: Integer = 1);
begin
  TArray.Shift<Double>(self);
end;

procedure TDoubleHelperDynArray.Shuffle;
begin
  TArray.Shuffle<Double>(self);
end;

function TDoubleHelperDynArray.Slice(StartPos: Integer): TDoubleDynArray;
begin
  TArray.Slice<Double>(StartPos, Self, Result);
end;

function TDoubleHelperDynArray.Has(const value: Double): Boolean;
begin
  Result := IndexOf(value) > -1;
end;

function TDoubleHelperDynArray.Head(EndPos: Integer): TDoubleDynArray;
begin
  Result := Slice(0, EndPos);
end;

function TDoubleHelperDynArray.Tail(StartPos: Integer): TDoubleDynArray;
begin
  Result := Slice(StartPos);
end;

function TDoubleHelperDynArray.Union(const Values: TDoubleDynArray): TDoubleDynArray;
begin
  TArray.Union<Double>(self, Values, Result);
end;

procedure TDoubleHelperDynArray.Unshift(aCount: Integer = 1);
begin
  TArray.Unshift<Double>(self);
end;

function TDoubleHelperDynArray.Slice(StartPos, EndPos: Integer): TDoubleDynArray;
begin
  TArray.Slice<Double>(StartPos, EndPos, Self, Result);
end;

procedure TDoubleHelperDynArray.Sort(const Comparison: TComparison<Double>;
  Index, Count: Integer);
begin
  TArray.Sort<Double>(self, TComparer<Double>.Construct(Comparison), Index, Count);
end;

procedure TDoubleHelperDynArray._Of(const Args: array of const);
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
          self[I] := InternalIntegerToDouble(VInteger);
        vtBoolean:
          self[I] := BOOL_TO_DOUBLE[VBoolean];
        vtChar:
          self[I] := InternalStrToDouble(VChar, DEFAULT_VALUE);
        vtExtended:
          self[I] := InternalFloatToDouble(VExtended^);
        vtString:
          self[I] := InternalStrToDouble(VString^, DEFAULT_VALUE);
        vtPChar:
          self[I] := InternalStrToDouble(VPChar, DEFAULT_VALUE);
        vtObject:
          self[I] := InternalIntegerToDouble(cardinal(VObject));
        vtClass:
          self[I] := InternalIntegerToDouble(cardinal(VClass));
        vtAnsiString:
          self[I] := InternalStrToDouble(string(VAnsiString), DEFAULT_VALUE);
        vtCurrency:
          self[I] := InternalFloatToDouble(VCurrency^);
        vtVariant:
          self[I] := Double(VVariant^);
        vtInt64:
          self[I] := InternalIntegerToDouble(Integer(VInt64^));
        vtUnicodeString:
          self[I] := InternalStrToDouble(string(VUnicodeString), DEFAULT_VALUE);
      end;
end;

procedure TDoubleHelperDynArray.Sort(const Comparison: TComparison<Double>);
begin
  TArray.Sort<Double>(self, TComparer<Double>.Construct(Comparison));
end;

end.

