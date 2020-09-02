unit Boost.Strings;

interface

uses
  SysUtils, Classes, System.Generics.Collections, System.types,
  System.Generics.Defaults, logutils, Boost.Arrays;

type
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
    function Quoted(Quote: string; Skip: string): TStringDynArray; overload;
    function Quoted(Quote: Char): TStringDynArray; overload;
    function Quoted(): TStringDynArray; overload;
    function Reduce(funcInteration: TFunc<string, string, string>): string; overload;
    function Reduce(funcInteration: TFunc<string, string, Integer, string>):
      string; overload;
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
  Result := TArray.PushBack<string>(self, '');
end;

function TStringHelperDynArray.PushFront: string;
begin
  Result := TArray.PushFront<string>(self, '');
end;

function TStringHelperDynArray.Quoted: TStringDynArray;
var
  Item: string;
begin
  Result.Clear;
  for Item in Self do
    Result.add(Item.QuotedString);
end;

function TStringHelperDynArray.Quoted(Quote: Char): TStringDynArray;
var
  Item: string;
  _Quote: char;
begin
  _Quote := Quote;
  Result.Clear;
  for Item in Self do
    Result.add(Item.QuotedString(_Quote));
end;

function TStringHelperDynArray.Quoted(Quote: string; Skip: string): TStringDynArray;
var
  Item, ItemSkiped: string;
begin
  Result.Clear;
  for Item in Self do
  begin
    ItemSkiped := Item.Replace(Quote, Skip + Quote, [rfReplaceAll]);
    Result.add(Quote + ItemSkiped + Quote);
  end;
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

function TStringHelperDynArray.Reduce(funcInteration: TFunc<string, string,
  Integer, string>): string;
begin
  Result := TArray.Reduce<string, string>(self, funcInteration, '');
end;

function TStringHelperDynArray.Reduce(funcInteration: TFunc<string, string,
  string>): string;
begin
  Result := TArray.Reduce<string, string>(self, funcInteration, '');
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
        vtChar, vtWideChar:
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

end.

