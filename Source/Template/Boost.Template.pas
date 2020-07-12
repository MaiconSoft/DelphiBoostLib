//**************************************************************
// Replace <TYPE> with a type you want, like Double for example.
// Set the right value for const DEFAULT_VALUE
// Ajust the function "_Of" for the right conversions
// Ajust others functions for the right conversions
//**************************************************************
unit Boost.<TYPE>;

interface

uses
  SysUtils, Classes, System.Generics.Collections, System.types,
  System.Generics.Defaults, logutils, Boost.Arrays;


const 
	DEFAULT_VALUE : <TYPE> = 0.0;
  	BOOL_TO_<TYPE> :array [boolean] of <TYPE> = (0.0,1.0);
type

  T<TYPE>HelperDynArray = record helper for T<TYPE>DynArray
  private
    function GetItem(Index: Integer): <TYPE>;
    procedure SetItem(Index: Integer; const Value: <TYPE>);
    function GetCount: Integer;
    procedure SetCount(const Value: Integer);
    function GetAsComa: string;
    procedure SetAsComma(const Value: string);
    class function Internal<TYPE>ToStr(value:<TYPE>):string; static;
	class function InternalStrTo<TYPE>(value:string; Default:<TYPE>):<TYPE>; static;
	class function InternalToStringDynArray(const a:T<TYPE>DynArray): TStringDynArray;
	class function InternalFloatTo<TYPE>(value:Extended):<TYPE>;
	class function InternalIntegerTo<TYPE>(value:Integer):<TYPE>;
  public
    property Items[Index: Integer]: <TYPE> read GetItem write SetItem;
    property Count: Integer read GetCount write SetCount;
    function Join(const Separator: string): string;
    property Comma: string read GetAsComa write SetAsComma;
    procedure Sort; overload;
    procedure RSort;
    procedure Shuffle;
    procedure Sort(const Comparison: TComparison<<TYPE>>); overload;
    procedure Sort(const Comparison: TComparison<<TYPE>>; Index, Count: Integer);
      overload;
    procedure Reverse;
    function IndexOf(const Value: <TYPE>; StartPos: Integer = 0): Integer;
    function LastIndexOf(const Value: <TYPE>; EndPos: Integer = MaxInt): Integer;
    procedure Delete(Index: Integer); overload;
    procedure Delete(Index, Count: Integer); overload;
    procedure Insert(Index: Integer; Value: <TYPE>); overload;
    procedure Insert(Index: Integer; Values: T<TYPE>DynArray); overload;
    procedure Add(Value: <TYPE>); overload;
    procedure Add(Values: T<TYPE>DynArray); overload;
    function CountItems(Item: <TYPE>): Integer;
    procedure Remove(Item: <TYPE>); overload;
    procedure Remove(Item: <TYPE>; count: Integer); overload;
    procedure Clear();
    function Slice(StartPos, EndPos: Integer): T<TYPE>DynArray; overload;
    function Slice(StartPos: Integer): T<TYPE>DynArray; overload;
    function Head(EndPos: Integer): T<TYPE>DynArray;
    function Tail(StartPos: Integer): T<TYPE>DynArray;
    function Save(FileName: string): boolean;
    function Load(FileName: string): boolean;
    function Clone: T<TYPE>DynArray;
    procedure Assign(const Values: T<TYPE>DynArray); overload;
    procedure Assign(const Values: TStringDynArray); overload;
    procedure Assign(const Values: string; Separator: array of char); overload;
    procedure Assign(const Values: string; Separator: TStringDynArray); overload;
    procedure Fill(const Value: <TYPE>; const StartIndex: Integer = 0; const
      EndIndex: Integer = -1);
    procedure ForEach(proc: TProcVar<Integer, <TYPE>>); overload;
    procedure ForEach(proc: TProcVar<<TYPE>>); overload;
    procedure ForEach(proc: TProc<Integer, <TYPE>>); overload;
    procedure ForEach(proc: TProc<<TYPE>>); overload;
    procedure _Of(const Args: array of const);
    function Every(func: TFunc<<TYPE>, Boolean>): Boolean; overload;
    function Every(func: TFunc<<TYPE>, Integer, Boolean>): Boolean; overload;
    function Filter(func: TFunc<<TYPE>, Boolean>): T<TYPE>DynArray; overload;
    function Filter(func: TFunc<<TYPE>, Integer, Boolean>): T<TYPE>DynArray; overload;
    function Find(func: TFunc<<TYPE>, Integer, Boolean>): <TYPE>; overload;
    function Find(func: TFunc<<TYPE>, Boolean>): <TYPE>; overload;
    procedure Shift(aCount: Integer = 1);
    procedure Unshift(aCount: Integer = 1);
    function Union(const Values: T<TYPE>DynArray): T<TYPE>DynArray;
    function Diference(const Values: T<TYPE>DynArray): T<TYPE>DynArray;
    function Interception(const Values: T<TYPE>DynArray): T<TYPE>DynArray;
    function Exclusion(const Values: T<TYPE>DynArray): T<TYPE>DynArray;
    function Same(const Values: T<TYPE>DynArray): Boolean;
    function SameData(const Values: T<TYPE>DynArray): Boolean;
    function RemoveDuplicate: Integer;
    function PushBack: <TYPE>;
    function PushFront: <TYPE>;
    function First: <TYPE>;
    function Last: <TYPE>;
    function Has(const value: <TYPE>): Boolean;
  end;

implementation

uses
  System.IOUtils;

{ T<TYPE>HelperDynArray }

class function T<TYPE>HelperDynArray.InternalStrTo<TYPE>(value:string; Default:<TYPE>):<TYPE>;
begin
	{$Message Error 'Not implemented InternalStrTo<TYPE>'}
	// Result:= StrToFloatDef(value,Default);
end;

class function T<TYPE>HelperDynArray.Internal<TYPE>ToStr(value:<TYPE>):string;
begin
	{$Message Error 'Not implemented Internal<TYPE>ToStr'}	
	//Result:= FloatToStr(value);
end;

class function T<TYPE>HelperDynArray.InternalToStringDynArray(const a:TIntegerDynArray): TStringDynArray;
var
  buffer:TStringDynArray;
begin
  SetLength(buffer, a.Count);

  a.ForEach(
    procedure (Index:Integer;Item:<TYPE>)
    begin
       buffer[Index]:= Internal<TYPE>ToStr(Item);
    end);
  Result := buffer;
end;

class function T<TYPE>HelperDynArray.InternalFloatTo<TYPE>(value:Extended):<TYPE>;
begin
	{$Message Error 'Not implemented InternalFloatTo<TYPE>'}		
	// Result:= Round(value);
end;

class function T<TYPE>HelperDynArray.InternalIntegerTo<TYPE>(value:Integer):<TYPE>;
begin
	{$Message Error 'Not implemented InternalIntegerTo<TYPE>'}
	// Result:= value;
end;

function T<TYPE>HelperDynArray.GetCount: Integer;
begin
  Result := Length(self);
end;

function T<TYPE>HelperDynArray.GetItem(Index: Integer): <TYPE>;
begin
  Result := Self[TArray.SurroundIndex<<TYPE>>(Index, self)];
end;

procedure T<TYPE>HelperDynArray.SetCount(const Value: Integer);
begin
  SetLength(self, Value);
end;

procedure T<TYPE>HelperDynArray.SetItem(Index: Integer; const Value: <TYPE>);
begin
  Self[TArray.SurroundIndex<<TYPE>>(Index, self)] := Value;
end;

function T<TYPE>HelperDynArray.Last: <TYPE>;
begin
  if Count = 0 then
    exit(DEFAULT_VALUE);
  Result := self[Count - 1];
end;

function T<TYPE>HelperDynArray.LastIndexOf(const Value: <TYPE>; EndPos: Integer): Integer;
begin
  Result := TArray.LastIndexOf<<TYPE>>(Value, self, EndPos);
end;

function T<TYPE>HelperDynArray.Load(FileName: string): boolean;
begin
  Result := False;
  if FileExists(FileName) then
  begin
    Assign(TFile.ReadAllLines(FileName));
    Result := True;
  end;
end;

function T<TYPE>HelperDynArray.PushBack: <TYPE>;
begin
  Result := TArray.PushBack<<TYPE>>(self, DEFAULT_VALUE);
end;

function T<TYPE>HelperDynArray.PushFront: <TYPE>;
begin
  Result := TArray.PushFront<<TYPE>>(self, DEFAULT_VALUE);
end;

procedure T<TYPE>HelperDynArray.Sort;
begin
  TArray.Sort<<TYPE>>(self);
end;

procedure T<TYPE>HelperDynArray.Add(Value: <TYPE>);
begin
  Insert(Count, Value);
end;

procedure T<TYPE>HelperDynArray.Add(Values: T<TYPE>DynArray);
var
  i: Integer;
begin
  if Values.count > 0 then
    for i := 0 to High(Values) do
      add(Values[i]);
end;

procedure T<TYPE>HelperDynArray.Assign(const Values: string; Separator: TStringDynArray);
begin
  Assign(Values.Split(Separator));
end;

procedure T<TYPE>HelperDynArray.Assign(const Values: TStringDynArray);
var
  buffer: T<TYPE>DynArray;
begin
  buffer.Clear;
  Values.ForEach(
    procedure(Item: string)
    begin
      buffer.Add(InternalStrTo<TYPE>(Item, DEFAULT_VALUE));
    end);
  Assign(buffer);
end;

procedure T<TYPE>HelperDynArray.Assign(const Values: string; Separator: array of char);
begin
  Assign(Values.Split(Separator));
end;

procedure T<TYPE>HelperDynArray.Assign(const Values: T<TYPE>DynArray);
begin
  Self := Values.Clone;
end;

procedure T<TYPE>HelperDynArray.Clear;
begin
  SetLength(self, 0);
end;

function T<TYPE>HelperDynArray.Clone: T<TYPE>DynArray;
begin
  Result.Count := Count;
  TArray.Copy<<TYPE>>(self, Result, Count);
end;

function T<TYPE>HelperDynArray.CountItems(Item: <TYPE>): Integer;
begin
  Result := TArray.CountItems<<TYPE>>(Item, Self);
end;

procedure T<TYPE>HelperDynArray.Delete(Index: Integer);
begin
  Delete(Index, 1);
end;

procedure T<TYPE>HelperDynArray.Delete(Index, Count: Integer);
begin
  TArray.Delete<<TYPE>>(Index, Count, self);
end;

function T<TYPE>HelperDynArray.Diference(const Values: T<TYPE>DynArray): T<TYPE>DynArray;
begin
  TArray.Diference<<TYPE>>(self, Values, Result);
end;

function T<TYPE>HelperDynArray.Every(func: TFunc<<TYPE>, Integer, Boolean>): Boolean;
begin
  Result := TArray.Every<<TYPE>>(func, self);
end;

function T<TYPE>HelperDynArray.Exclusion(const Values: T<TYPE>DynArray): T<TYPE>DynArray;
begin
  TArray.Exclusion<<TYPE>>(self, Values, Result);
end;

function T<TYPE>HelperDynArray.Every(func: TFunc<<TYPE>, Boolean>): Boolean;
begin
  Result := TArray.Every<<TYPE>>(func, self);
end;

procedure T<TYPE>HelperDynArray.Fill(const Value: <TYPE>; const StartIndex,
  Endindex: Integer);
begin
  TArray.Fill<<TYPE>>(Value, Self, StartIndex, Endindex);
end;

function T<TYPE>HelperDynArray.Filter(func: TFunc<<TYPE>, Integer, Boolean>):
  T<TYPE>DynArray;
begin
  TArray.Filter<<TYPE>>(func, Self, Result);
end;

function T<TYPE>HelperDynArray.Find(func: TFunc<<TYPE>, Boolean>): <TYPE>;
begin
  Result := DEFAULT_VALUE;
  TArray.Find<<TYPE>>(func, self, Result);
end;

function T<TYPE>HelperDynArray.First: <TYPE>;
begin
  if Count = 0 then
    exit(DEFAULT_VALUE);
  Result := self[0];
end;

function T<TYPE>HelperDynArray.Find(func: TFunc<<TYPE>, Integer, Boolean>): <TYPE>;
begin
  Result := DEFAULT_VALUE;
  TArray.Find<<TYPE>>(func, self, Result);
end;

function T<TYPE>HelperDynArray.Filter(func: TFunc<<TYPE>, Boolean>): T<TYPE>DynArray;
begin
  TArray.Filter<<TYPE>>(func, Self, Result);
end;

procedure T<TYPE>HelperDynArray.ForEach(proc: TProcVar<Integer, <TYPE>>);
begin
  TArray.ForEach<<TYPE>>(proc, Self);
end;

procedure T<TYPE>HelperDynArray.ForEach(proc: TProcVar<<TYPE>>);
begin
  TArray.ForEach<<TYPE>>(proc, Self);
end;

procedure T<TYPE>HelperDynArray.ForEach(proc: TProc<Integer, <TYPE>>);
begin
  TArray.ForEach<<TYPE>>(proc, Self);
end;

procedure T<TYPE>HelperDynArray.ForEach(proc: TProc<<TYPE>>);
begin
  TArray.ForEach<<TYPE>>(proc, Self);
end;

function T<TYPE>HelperDynArray.GetAsComa: string;
begin
  Result := join(',');
end;

function T<TYPE>HelperDynArray.IndexOf(const Value: <TYPE>; StartPos: Integer =
  0): Integer;
begin
  Result := TArray.IndexOf<<TYPE>>(Value, self, StartPos);
end;

procedure T<TYPE>HelperDynArray.Insert(Index: Integer; Values: T<TYPE>DynArray);
var
  i: Integer;
begin
  if Values.Count > 0 then
    for i := High(Values) downto 0 do
    begin
      Insert(Index, Values[i]);
    end;
end;

function T<TYPE>HelperDynArray.Interception(const Values: T<TYPE>DynArray):
  T<TYPE>DynArray;
begin
  TArray.Interception<<TYPE>>(self, Values, Result);
end;

function T<TYPE>HelperDynArray.Join(const Separator: string): string;
var
  buffer,sep: string;
begin
  buffer := '';
  Sep:= Separator;

  ForEach(
    procedure (Index:Integer;Item:<TYPE>)
    begin
       if Index > 0 then
          buffer:= buffer + sep;
       buffer:= buffer + Internal<TYPE>ToStr(Item);
    end);

  Result := buffer;
end;

procedure T<TYPE>HelperDynArray.Insert(Index: Integer; Value: <TYPE>);
begin
  TArray.Insert<<TYPE>>(Index, Value, Self);
end;

procedure T<TYPE>HelperDynArray.Remove(Item: <TYPE>);
begin
  TArray.Remove<<TYPE>>(Item, 1, self);
end;

procedure T<TYPE>HelperDynArray.Remove(Item: <TYPE>; count: Integer);
begin
  TArray.Remove<<TYPE>>(Item, count, self);
end;

function T<TYPE>HelperDynArray.RemoveDuplicate: Integer;
begin
  Result := TArray.RemoveDuplicate<<TYPE>>(self);
end;

procedure T<TYPE>HelperDynArray.Reverse;
begin
  TArray.Reverse<<TYPE>>(self);
end;

procedure T<TYPE>HelperDynArray.RSort;
begin
  Sort(
    function(const Left, Right: <TYPE>): Integer
    begin
      Result := Integer(Left < Right);
    end);
end;

function T<TYPE>HelperDynArray.Same(const Values: T<TYPE>DynArray): Boolean;
begin
  Result := TArray.Same<<TYPE>>(self, Values);
end;

function T<TYPE>HelperDynArray.SameData(const Values: T<TYPE>DynArray): Boolean;
begin
  Result := TArray.SameData<<TYPE>>(self, Values);
end;

function T<TYPE>HelperDynArray.Save(FileName: string): boolean;
begin
  TFile.WriteAllLines(FileName,InternalToStringDynArray(self));
  Result := True;
end;

procedure T<TYPE>HelperDynArray.SetAsComma(const Value: string);
begin
  Assign(Value.Split([',']));
end;

procedure T<TYPE>HelperDynArray.Shift(aCount: Integer = 1);
begin
  TArray.Shift<<TYPE>>(self);
end;

procedure T<TYPE>HelperDynArray.Shuffle;
begin
  TArray.Shuffle<<TYPE>>(self);
end;

function T<TYPE>HelperDynArray.Slice(StartPos: Integer): T<TYPE>DynArray;
begin
  TArray.Slice<<TYPE>>(StartPos, Self, Result);
end;

function T<TYPE>HelperDynArray.Has(const value: <TYPE>): Boolean;
begin
  Result := IndexOf(value) > -1;
end;

function T<TYPE>HelperDynArray.Head(EndPos: Integer): T<TYPE>DynArray;
begin
  Result := Slice(0, EndPos);
end;

function T<TYPE>HelperDynArray.Tail(StartPos: Integer): T<TYPE>DynArray;
begin
  Result := Slice(StartPos);
end;

function T<TYPE>HelperDynArray.Union(const Values: T<TYPE>DynArray): T<TYPE>DynArray;
begin
  TArray.Union<<TYPE>>(self, Values, Result);
end;

procedure T<TYPE>HelperDynArray.Unshift(aCount: Integer = 1);
begin
  TArray.Unshift<<TYPE>>(self);
end;

function T<TYPE>HelperDynArray.Slice(StartPos, EndPos: Integer): T<TYPE>DynArray;
begin
  TArray.Slice<<TYPE>>(StartPos, EndPos, Self, Result);
end;

procedure T<TYPE>HelperDynArray.Sort(const Comparison: TComparison<<TYPE>>;
  Index, Count: Integer);
begin
  TArray.Sort<<TYPE>>(self, TComparer<<TYPE>>.Construct(Comparison), Index, Count);
end;

procedure T<TYPE>HelperDynArray._Of(const Args: array of const);
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
          self[I] := InternalIntegerTo<TYPE>(VInteger);
        vtBoolean:
          self[I] := BOOL_TO_<TYPE>[VBoolean];
        vtChar:
          self[I] := InternalStrTo<TYPE>(VChar, DEFAULT_VALUE);
        vtExtended:
          self[I] := InternalFloatTo<TYPE>(VExtended^);
        vtString:
          self[I] := InternalStrTo<TYPE>(VString^, DEFAULT_VALUE);
        vtPChar:
          self[I] := InternalStrTo<TYPE>(VPChar, DEFAULT_VALUE);
        vtObject:
          self[I] := InternalIntegerTo<TYPE>(cardinal(VObject));
        vtClass:
          self[I] := InternalIntegerTo<TYPE>(cardinal(VClass));
        vtAnsiString:
          self[I] := InternalStrTo<TYPE>(string(VAnsiString), DEFAULT_VALUE);
        vtCurrency:
          self[I] := InternalFloatTo<TYPE>(VCurrency^);
        vtVariant:
          self[I] := <TYPE>(VVariant^);
        vtInt64:
          self[I] := InternalIntegerTo<TYPE>(Integer(VInt64^));
        vtUnicodeString:
          self[I] := InternalStrTo<TYPE>(string(VUnicodeString), DEFAULT_VALUE);
      end;
end;

procedure T<TYPE>HelperDynArray.Sort(const Comparison: TComparison<<TYPE>>);
begin
  TArray.Sort<<TYPE>>(self, TComparer<<TYPE>>.Construct(Comparison));
end;

End.