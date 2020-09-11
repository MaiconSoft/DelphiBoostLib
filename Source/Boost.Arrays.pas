unit Boost.Arrays;

interface

uses
  SysUtils, Classes, System.Generics.Collections, System.types,
  System.Generics.Defaults, Boost.Generics.Collection;

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
    class function Compare<T>(a, b: T): Integer; static;
    class function IndexOf<T>(const Value: T; const Values: TArray<T>; StartPos:
      Integer = 0): Integer; static;
    class function LastIndexOf<T>(const Value: T; var Values: TArray<T>; EndPos:
      Integer = MaxInt): Integer; static;
    class function CountItems<T>(const Value: T; const Values: TArray<T>):
      Integer; static;
    class procedure Remove<T>(Item: T; count: integer; var Values: TArray<T>);
      overload; static;
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
    class procedure Remove<T>(Func: TFunc<T, Boolean>; var Values: TArray<T>);
      overload; static;
    class procedure Remove<T>(Func: TFunc<T, Integer, Boolean>; var Values:
      TArray<T>); overload; static;
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
    class function Reduce<T, TAcum, TResult>(var a: TArray<T>; FuncIteration:
      TFunc<TAcum, T, TAcum>; FuncReturn: TFunc<TAcum, TResult>; Acum: TAcum):
      TResult; overload; static;
    class function Reduce<T, TAcum, TResult>(var a: TArray<T>; FuncIteration:
      TFunc<TAcum, T, Integer, TAcum>; FuncReturn: TFunc<TAcum, TResult>; Acum:
      TAcum): TResult; overload; static;
    class function Reduce<T, TResult>(var a: TArray<T>; FuncIteration: TFunc<
      TResult, T, TResult>; Acum: TResult): TResult; overload; static;
    class function Reduce<T, TResult>(var a: TArray<T>; FuncIteration: TFunc<
      TResult, T, Integer, TResult>; Acum: TResult): TResult; overload; static;
    class function Max<T>(a: TArray<T>): T; static;
    class function Min<T>(a: TArray<T>): T; static;
    class function Group<T>(a: TArray<T>): TDictionary<T, Integer>; static;
    class function ToString<T>(a: TArray<T>): string;overload; static;
    class function ToString<T>(a: T): string;overload; static;
  end;

implementation
  uses System.Rtti, System.TypInfo;

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

class function TArray.ToString<T>(a: T): string;
var
  ElementValue, Value: TValue;
  Data: PTypeData;
  I: Integer;
  AContext: TRttiContext;
  ARecord: TRttiRecordType;
  am: TRttiMethod;
begin
  TValue.Make(@a, System.TypeInfo(T), Value);

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


class function TArray.ToString<T>(a: TArray<T>): string;
var
  i: Integer;
begin
  Result := '[ ';
  for i := 0 to length(a) - 1 do
  begin
    if i > 0 then
      Result := Result + ', ';
    Result := Result + ToString<T>(a[i]);
  end;
  Result := Result + ']';
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

class function TArray.Group<T>(a: TArray<T>): TDictionary<T, Integer>;
var
  e: T;
begin
  Result.Init;
  for e in a do
    Result[e] := Result[e, 0] + 1;
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
    if Compare<T>(Value, Values[i]) = 0 then
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

class function TArray.Compare<T>(a, b: T): Integer;
begin
  Result := TComparer<T>.Default.Compare(a, b);
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
    if Compare<T>(Value, Values[i]) = 0 then
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
    if Compare<T>(Value, Values[i]) = 0 then
      Exit(i);
  end;
end;

class function TArray.Max<T>(a: TArray<T>): T;
var
  e: T;
begin
  if Length(a) = 0 then
    raise Exception.Create('Array empty, can''t get max value');
  Result := a[0];
  for e in a do
  begin
    if Compare<T>(e, result) > 0 then
      Result := e;
  end;
end;

class function TArray.Min<T>(a: TArray<T>): T;
var
  e: T;
begin
  if Length(a) = 0 then
    raise Exception.Create('Array empty, can''t get max value');
  Result := a[0];
  for e in a do
  begin
    if Compare<T>(e, result) < 0 then
      Result := e;
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
  SetLength(a, ALength - 1);
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

class function TArray.Reduce<T, TAcum, TResult>(var a: TArray<T>; FuncIteration:
  TFunc<TAcum, T, TAcum>; FuncReturn: TFunc<TAcum, TResult>; Acum: TAcum): TResult;
var
  aAcum: TAcum;
  i: Integer;
begin
  aAcum := Acum;
  if Assigned(FuncIteration) then
    for i := 0 to High(a) do
      aAcum := FuncIteration(aAcum, a[i]);

  if Assigned(FuncReturn) then
    Result := FuncReturn(aAcum)
  else
    raise EArgumentNilException.Create('FuncReturn must be assigned');
end;

class function TArray.Reduce<T, TAcum, TResult>(var a: TArray<T>; FuncIteration:
  TFunc<TAcum, T, Integer, TAcum>; FuncReturn: TFunc<TAcum, TResult>; Acum:
  TAcum): TResult;
var
  aAcum: TAcum;
  i: Integer;
begin
  aAcum := Acum;
  if Assigned(FuncIteration) then
    for i := 0 to High(a) do
      aAcum := FuncIteration(aAcum, a[i], i);

  if Assigned(FuncReturn) then
    Result := FuncReturn(aAcum)
  else
    raise EArgumentNilException.Create('FuncReturn must be assigned');
end;

class function TArray.Reduce<T, TResult>(var a: TArray<T>; FuncIteration: TFunc<
  TResult, T, Integer, TResult>; Acum: TResult): TResult;
var
  aAcum: TResult;
  i: Integer;
begin
  aAcum := Acum;
  if Assigned(FuncIteration) then
    for i := 0 to High(a) do
      aAcum := FuncIteration(aAcum, a[i], i);

  Result := aAcum;
end;

class function TArray.Reduce<T, TResult>(var a: TArray<T>; FuncIteration: TFunc<
  TResult, T, TResult>; Acum: TResult): TResult;
var
  aAcum: TResult;
  i: Integer;
begin
  aAcum := Acum;
  if Assigned(FuncIteration) then
    for i := 0 to High(a) do
      aAcum := FuncIteration(aAcum, a[i]);

  Result := aAcum;
end;

class procedure TArray.Remove<T>(Func: TFunc<T, Integer, Boolean>; var Values: TArray<T>);
var
  Alength: Integer;
  i: Integer;
begin
  Alength := Length(Values);
  if (not Assigned(Func)) then
    exit();

  for i := Alength - 1 downto 0 do
  begin
    if Func(Values[i], i) then
    begin
      TArray.Delete<T>(i, Values);
    end;
  end;
end;

class procedure TArray.Remove<T>(Func: TFunc<T, Boolean>; var Values: TArray<T>);
var
  Alength: Integer;
  i: Integer;
begin
  Alength := Length(Values);
  if (not Assigned(Func)) then
    exit();

  for i := Alength - 1 downto 0 do
  begin
    if Func(Values[i]) then
    begin
      TArray.Delete<T>(i, Values);
    end;
  end;
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

