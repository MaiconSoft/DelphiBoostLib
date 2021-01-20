unit Boost.Bitset;

interface

uses
  System.SysUtils;

type
  TBitOrder = (boLittleEndian, boBigEndian);

  TBitset = record
  private
    FBits: TArray<Boolean>;
    FBitOrder: TBitOrder;
    class function Min(a, b: Integer): Integer; static;
    class function Max(a, b: Integer): Integer; static;
    function GetSize: Integer;
    procedure SetSize(const Value: Integer);
    function GetBit(Index: Integer): Boolean;
    procedure _SetBit(Index: Integer; const Value: Boolean);
    procedure SetAsNumber(value: Int64);
    function GetAsNumber: Int64;
    function DoAnd(other: TBitset): TBitset;
    function DoOr(other: TBitset): TBitset;
    function DoXor(other: TBitset): TBitset;
    procedure DoLeftShift; overload;
    procedure DoRightShift; overload;
    procedure DoLeftShift(n: Integer); overload;
    procedure DoRightShift(n: Integer); overload;
  public
    constructor Create(aLength: Integer; aInitializer: TFunc<Integer, Boolean>); overload;
    constructor Create(aSize: Integer); overload;
    constructor CreateAsNumber(value: Int64; bitOrder: TBitOrder = boLittleEndian);
    procedure Assign(value: TBitset);
    class operator Implicit(a: TBitset): Int64;
    class operator Implicit(a: Int64): TBitset;
    class operator Implicit(a: TBitset): string;
    class operator LeftShift(a: TBitset; n: Integer): TBitset;
    class operator RightShift(a: TBitset; n: Integer): TBitset;
    class operator BitwiseAnd(a: TBitset; b: TBitset): TBitset;
    class operator BitwiseOr(a: TBitset; b: TBitset): TBitset;
    class operator BitwiseXor(a: TBitset; b: TBitset): TBitset;
    class operator Equal(a: TBitset; b: TBitset): Boolean;
    class operator NotEqual(a: TBitset; b: TBitset): Boolean;
    function AndNot(b: TBitset): TBitset;
    function Flip: TBitset; overload;
    function Flip(Index: Integer): TBitset; overload;
    function Flip(aFrom, aTo: Integer): TBitset; overload;
    function IsEmpty: boolean;
    function IsEqual(a: TBitset): boolean;
    function LastTrueIndex: Integer;
    function FirstTrueIndex: Integer;
    function NextTrueIndex(StartIndex: Integer = 0): Integer;
    function PreviousTrueIndex(StartIndex: Integer = 0): Integer;
    function NextFalseIndex(StartIndex: Integer = 0): Integer;
    function PreviousFalseIndex(StartIndex: Integer = 0): Integer;
    function NextBitIndex(StartIndex: Integer; LookFor: boolean): Integer;
    function PreviousBitIndex(StartIndex: Integer; LookFor: boolean): Integer;
    procedure SetBit(Index: Integer);
    procedure Clear(Index: Integer); overload;
    procedure Clear(aFrom, aTo: Integer); overload;
    procedure Clear(); overload;
    function ToString(Reverse: boolean = True): string;
    property BitOrder: TBitOrder read FBitOrder write FBitOrder;
    property AsNumber: Int64 read GetAsNumber write SetAsNumber;
    property Bits[Index: Integer]: Boolean read GetBit write _SetBit;
    property Size: Integer read GetSize write SetSize;
  end;

implementation

{ TBitset }

constructor TBitset.Create(aLength: Integer; aInitializer: TFunc<Integer, Boolean>);
var
  i: Integer;
begin
  Create(aLength);
  if not Assigned(aInitializer) then
    exit;

  for i := 0 to aLength - 1 do
    Bits[i] := aInitializer(i);
end;

function TBitset.AndNot(b: TBitset): TBitset;
begin
  Result := (self and b).Flip;
end;

procedure TBitset.Assign(value: TBitset);
begin
  Size := value.Size;
  FBits := copy(value.FBits, 0, size);
end;

class operator TBitset.BitwiseAnd(a, b: TBitset): TBitset;
begin
  result := a.DoAnd(b);
end;

class operator TBitset.BitwiseOr(a, b: TBitset): TBitset;
begin
  result := a.DoOr(b);
end;

class operator TBitset.BitwiseXor(a, b: TBitset): TBitset;
begin
  result := a.DoXor(b);
end;

procedure TBitset.Clear(Index: Integer);
begin
  Bits[Index] := false;
end;

procedure TBitset.Clear;
var
  i, len: Integer;
begin
  len := size;
  if len > 0 then
    for i := 0 to len - 1 do
      Bits[i] := false;
end;

procedure TBitset.Clear(aFrom, aTo: Integer);
var
  i, len: Integer;
begin
  len := size;
  if len = 0 then
    exit;
  aTo := min(aTo, len - 1);

  if aFrom > aTo then
    exit;

  for i := aFrom to aTo do
    Bits[i] := false;
end;

constructor TBitset.Create(aSize: Integer);
begin
  SetLength(FBits, aSize);
  BitOrder := boLittleEndian;
end;

constructor TBitset.CreateAsNumber(value: Int64; bitOrder: TBitOrder = boLittleEndian);
begin
  self.bitOrder := bitOrder;
  SetAsNumber(value);
end;

function TBitset.DoAnd(other: TBitset): TBitset;
var
  len: Integer;
  i: Integer;
begin
  len := min(other.Size, size);
  Result.Size := len;
  for i := 0 to len - 1 do
    Result.Bits[i] := self.Bits[i] and other.Bits[i];
end;

procedure TBitset.DoLeftShift;
var
  i, len: Integer;
begin
  len := size;
  for i := len - 1 downto 1 do
    Bits[i] := Bits[i - 1];
  Clear(0);
end;

procedure TBitset.DoLeftShift(n: Integer);
var
  i: Integer;
begin
  if n > 0 then
    for i := 1 to n do
      DoLeftShift;
end;

function TBitset.DoOr(other: TBitset): TBitset;
var
  len: Integer;
  i: Integer;
begin
  len := min(other.Size, size);
  Result.Size := max(other.Size, size);
  for i := 0 to len - 1 do
    Result.Bits[i] := self.Bits[i] or other.Bits[i];

  if len > Size then
    for i := len to Size - 1 do
      Result.Bits[i] := self.Bits[i];

  if len > other.Size then
    for i := len to other.size - 1 do
      Result.Bits[i] := other.Bits[i];
end;

procedure TBitset.DoRightShift;
var
  i, len: Integer;
begin
  len := size;
  for i := 0 to len - 2 do
    Bits[i] := Bits[i + 1];
  Clear(len - 1);
end;

procedure TBitset.DoRightShift(n: Integer);
var
  i: Integer;
begin
  if n > 0 then
    for i := 1 to n do
      DoRightShift;
end;

function TBitset.DoXor(other: TBitset): TBitset;
var
  len: Integer;
  i: Integer;
begin
  len := min(other.Size, size);
  Result.Size := max(other.Size, size);
  for i := 0 to len - 1 do
    Result.Bits[i] := self.Bits[i] xor other.Bits[i];

  if len > Size then
    for i := len to Size - 1 do
      Result.Bits[i] := self.Bits[i];

  if len > other.Size then
    for i := len to other.size - 1 do
      Result.Bits[i] := other.Bits[i];
end;

class operator TBitset.Equal(a, b: TBitset): Boolean;
begin
  Result := a.IsEqual(b);
end;

function TBitset.FirstTrueIndex: Integer;
begin
  Result := NextTrueIndex;
end;

function TBitset.Flip(aFrom, aTo: Integer): TBitset;
var
  i, len: Integer;
begin
  Result.Assign(self);
  len := size;
  if len = 0 then
    exit;
  aTo := min(aTo, len - 1);

  if aFrom > aTo then
    exit;

  for i := aFrom to aTo do
    Result.Bits[i] := not Bits[i];
end;

function TBitset.Flip(Index: Integer): TBitset;
begin
  Result.Assign(self);
  Result.Bits[Index] := not Bits[Index];
end;

function TBitset.Flip: TBitset;
var
  i, len: Integer;
begin
  Result.Size := Size;
  len := size;

  for i := 0 to len - 1 do
    Result.Bits[i] := not Bits[i];
end;

function TBitset.GetAsNumber: Int64;
var
  i, len: Integer;
begin
  len := size;
  Result := 0;
  for i := 0 to len - 1 do
  begin
    if bitOrder = boLittleEndian then
      Result := Result + (ord(Bits[i]) shl i)
    else
      Result := (Result shl 1) + ord(Bits[i]);
  end;
end;

function TBitset.GetBit(Index: Integer): Boolean;
begin
  Result := FBits[Index];
end;

function TBitset.GetSize: Integer;
begin
  Result := Length(FBits);
end;

class operator TBitset.Implicit(a: Int64): TBitset;
begin
  Result := TBitset.CreateAsNumber(a);
end;

class operator TBitset.Implicit(a: TBitset): Int64;
begin
  Result := a.AsNumber;
end;

function TBitset.IsEmpty: boolean;
begin
  Result := Size = 0;
end;

function TBitset.IsEqual(a: TBitset): boolean;
var
  Len, i: Integer;
begin
  if Size <> a.Size then
    exit(false);

  Len := Size;
  for i := 0 to Len - 1 do
    if Bits[i] xor a.Bits[i] then
      exit(false);
  Result := true;
end;

function TBitset.LastTrueIndex: Integer;
begin
  Result := PreviousTrueIndex(Size - 1);
end;

class operator TBitset.LeftShift(a: TBitset; n: Integer): TBitset;
begin
  Result.Assign(a);
  Result.DoLeftShift(n);
end;

class function TBitset.Max(a, b: Integer): Integer;
begin
  Result := a;
  if b > a then
    Result := b;
end;

class function TBitset.Min(a, b: Integer): Integer;
begin
  Result := a;
  if b < a then
    Result := b;
end;

function TBitset.NextBitIndex(StartIndex: Integer; LookFor: boolean): Integer;
var
  i, len: Integer;
begin
  Result := -1;
  len := Size;

  if (len > 0) and (StartIndex < len) then
    for i := StartIndex to len - 1 do
      if not (Bits[i] xor LookFor) then
        exit(i);
end;

function TBitset.NextFalseIndex(StartIndex: Integer): Integer;
begin
  Result := NextBitIndex(StartIndex, false);
end;

function TBitset.NextTrueIndex(StartIndex: Integer): Integer;
begin
  Result := NextBitIndex(StartIndex, True)
end;

class operator TBitset.NotEqual(a, b: TBitset): Boolean;
begin
  Result := not a.IsEqual(b);
end;

function TBitset.PreviousBitIndex(StartIndex: Integer; LookFor: boolean): Integer;
var
  i, len: Integer;
begin
  Result := -1;
  len := Size;
  if (len > 0) and (StartIndex < len) then
    for i := StartIndex downto 0 do
      if not (Bits[i] xor LookFor) then
        exit(i);
end;

function TBitset.PreviousFalseIndex(StartIndex: Integer): Integer;
begin
  Result := PreviousBitIndex(StartIndex, false);
end;

function TBitset.PreviousTrueIndex(StartIndex: Integer): Integer;
begin
  Result := PreviousBitIndex(StartIndex, True);
end;

class operator TBitset.RightShift(a: TBitset; n: Integer): TBitset;
begin
  Result.Assign(a);
  Result.DoRightShift(n);
end;

procedure TBitset.SetAsNumber(value: Int64);
var
  i, len: Integer;
  val: Boolean;
begin
  size := max(SizeOf(Int64) * 8, size);
  len := size;

  for i := 0 to len - 1 do
  begin
    val := ((value shr i) and $01) = 1;
    if boLittleEndian = bitOrder then
      Bits[i] := val
    else
      Bits[len - 1 - i] := val;
  end;
end;

procedure TBitset.SetBit(Index: Integer);
begin
  Bits[Index] := True;
end;

procedure TBitset._SetBit(Index: Integer; const Value: Boolean);
begin
  FBits[Index] := Value;
end;

procedure TBitset.SetSize(const Value: Integer);
begin
  SetLength(FBits, max(0, Value));
end;

function TBitset.ToString(Reverse: boolean = True): string;
var
  i, len: Integer;
begin
  Result := '[';
  len := Size;

  if Reverse then
    for i := len - 1 downto 0 do
    begin
      Result := Result + ord(Bits[i]).ToString;
      if i > 0 then
        Result := Result + ', ';
    end
  else
    for i := 0 to len - 1 do
    begin
      Result := Result + ord(Bits[i]).ToString;
      if i < len - 1 then
        Result := Result + ', ';
    end;
  Result := Result + ']';
end;

class operator TBitset.Implicit(a: TBitset): string;
begin
  Result := a.ToString();
end;

end.

