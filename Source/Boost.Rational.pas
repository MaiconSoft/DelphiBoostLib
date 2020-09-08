unit Boost.Rational;

interface

uses
  System.SysUtils, Math;

type
  TFraction = record
  private
    FNum: Int64;
    FDenom: Int64;
    procedure CheckBounds;
    class function GCD(a, b: Int64): Int64; inline; static;
    class function LCM(a, b: Int64): Int64; inline; static;
    class function DecimalToFraction(value: Double; MaximumDenominator: Int64):
      TFraction; static;
    class function Parse(value: string): TFraction; static;
  public
    constructor Create(aNum, aDenom: Int64); overload;
    constructor Create(aNum: Int64); overload;
    constructor Create(a: TFraction); overload;
    constructor Create(a: string); overload;
    function Abs: TFraction;
    function Reciprocal: TFraction; inline;
    function ToString: string; inline;
    class operator Add(a, b: TFraction): TFraction;
    class operator Subtract(a, b: TFraction): TFraction;
    class operator Multiply(a, b: TFraction): TFraction;
    class operator Divide(a, b: TFraction): TFraction;
    class operator IntDivide(a, b: TFraction): TFraction;
    class operator Modulus(a, b: TFraction): TFraction;
    class operator Negative(a: TFraction): TFraction;
    class operator Positive(a: TFraction): TFraction;
    class operator Equal(a, b: TFraction): Boolean;
    class operator NotEqual(a, b: TFraction): Boolean;
    class operator GreaterThan(a, b: TFraction): Boolean;
    class operator GreaterThanOrEqual(a, b: TFraction): Boolean;
    class operator LessThan(a, b: TFraction): Boolean;
    class operator LessThanOrEqual(a, b: TFraction): Boolean;
    class operator Round(a: TFraction): Int64;
    class operator Trunc(a: TFraction): Int64;
    class operator Inc(a: TFraction): TFraction;
    class operator Dec(a: TFraction): TFraction;
    class operator Implicit(a: Int64): TFraction;
    class operator Implicit(a: Double): TFraction;
    class operator Implicit(a: string): TFraction;
    class operator Implicit(a: TFraction): string;
    property Numerator: Int64 read FNum;
    property Denominator: Int64 read FDenom;
  end;

function Fraction(num, denom: Int64): TFraction; overload;

function Fraction(num: Int64): TFraction; overload;

function Fraction(value: Double): TFraction; overload;

function Fraction(value: string): TFraction; overload;

var
  MaximumDenominator: Int64 = 65536;

implementation

function Floor(const X: Double): Int64;
begin
  Result := Trunc(X);
  if Frac(X) < 0 then
    Dec(Result);
end;

function Fraction(num, denom: Int64): TFraction; overload;
begin
  Result := TFraction.Create(num, denom);
end;

function Fraction(num: Int64): TFraction; overload;
begin
  Result := TFraction.Create(num);
end;

function Fraction(value: Double): TFraction; overload;
begin
  Result := TFraction.Create(value);
end;

function Fraction(value: string): TFraction; overload;
begin
  Result := TFraction.Create(value);
end;

{ TFraction }

function TFraction.Abs: TFraction;
begin
  CheckBounds;
  Result := TFraction.Create(System.Abs(fnum), FDenom);
end;

class operator TFraction.Add(a, b: TFraction): TFraction;
var
  m, na, nb: Int64;
begin
  m := Lcm(a.Denominator, b.Denominator);
  na := (a.Numerator * m) div a.Denominator;
  nb := (b.Numerator * m) div b.Denominator;
  Result := TFraction.Create(na + nb, m);
end;

procedure TFraction.CheckBounds;
var
  d: Int64;
begin
  if FNum = 0 then
    FDenom := 1;
  if FDenom = 0 then
    raise Exception.Create('Denominator may not be zero');
  if FDenom < 0 then
  begin
    FNum := -FNum;
    FDenom := -FDenom;
  end;

  d := System.abs(GCD(FNum, FDenom));
  FNum := FNum div d;
  FDenom := FDenom div d;
end;

constructor TFraction.Create(a: string);
begin
  Create(Parse(a));
end;

constructor TFraction.Create(aNum, aDenom: Int64);
begin
  FNum := aNum;
  FDenom := aDenom;
  CheckBounds;
end;

constructor TFraction.Create(aNum: Int64);
begin
  FNum := aNum;
  FDenom := 1;
  CheckBounds;
end;

class operator TFraction.Dec(a: TFraction): TFraction;
begin
  Result := a - 1;
end;

class function TFraction.DecimalToFraction(value: Double; MaximumDenominator:
  Int64): TFraction;
var
  a, x, d, n, num, denom, v: Int64;
  i: Integer;
  h, k: array of int64;
  neg: Boolean;
begin
  h := [0, 1, 0];
  k := [1, 0, 0];
  n := 1;
  neg := False;

  if MaximumDenominator <= 1 then
    exit(TFraction.Create(Trunc(value)));

  if value < 0 then
  begin
    neg := True;
    value := -value;
  end;

  i := 0;
  while (value <> Floor(value)) and (i < 64) do
  begin
    n := n shl 1;
    value := value * 2;
    v := Floor(value);
    inc(i);
  end;
  d := Trunc(value);

  i := 0;
  while i < 64 do
  begin
    if (n <> 0) then
      a := d div n
    else
      a := 0;

    if (i <> 0) and (a = 0) then
      Break;

    x := d;
    d := n;
    n := x mod n;
    x := a;

    if (k[1] * a + k[0]) >= MaximumDenominator then
    begin
      x := (MaximumDenominator - k[0]) div k[1];
      if ((x * 2) >= a) or (k[1] >= MaximumDenominator) then
        i := 65
      else
        break;
    end;

    h[2] := x * h[1] + h[0];
    h[0] := h[1];
    h[1] := h[2];
    k[2] := x * k[1] + k[0];
    k[0] := k[1];
    k[1] := k[2];
    inc(i);
  end;

  denom := k[1];
  num := h[1];
  if neg then
    num := -num;

  Result := TFraction.Create(num, denom);
end;

class operator TFraction.Divide(a, b: TFraction): TFraction;
begin
  Result := a * b.Reciprocal;
end;

class operator TFraction.Equal(a, b: TFraction): Boolean;
begin
  Result := (a.Numerator = b.Numerator) and (a.Denominator = b.Denominator);
end;

class function TFraction.GCD(a, b: Int64): Int64;
begin
  if (b = 0) then
    Result := a
  else
    Result := GCD(b, a mod b);
end;

class operator TFraction.GreaterThan(a, b: TFraction): Boolean;
begin
  Result := (a.Numerator * b.Denominator) > (b.Numerator * a.Denominator);
end;

class operator TFraction.GreaterThanOrEqual(a, b: TFraction): Boolean;
begin
  Result := not (a < b);
end;

class operator TFraction.Implicit(a: Int64): TFraction;
begin
  Result := TFraction.Create(a);
end;

class operator TFraction.Implicit(a: TFraction): string;
begin
  Result := a.ToString;
end;

class operator TFraction.Implicit(a: string): TFraction;
begin
  Result := parse(a);
end;

class operator TFraction.Implicit(a: Double): TFraction;
begin
  Result := DecimalToFraction(a, MaximumDenominator);
end;

class operator TFraction.Inc(a: TFraction): TFraction;
begin
  Result := a + 1;
end;

class operator TFraction.IntDivide(a, b: TFraction): TFraction;
begin
  Result := a / b;
end;

class function TFraction.LCM(a, b: Int64): Int64;
begin
  Result := a div (GCD(a, b) * b);
end;

class operator TFraction.LessThan(a, b: TFraction): Boolean;
begin
  Result := (a.Numerator * b.Denominator) < (b.Numerator * a.Denominator);
end;

class operator TFraction.LessThanOrEqual(a, b: TFraction): Boolean;
begin
  Result := not (a > b);
end;

class operator TFraction.Modulus(a, b: TFraction): TFraction;
var
  l, r, n: Int64;
begin
  l := a.Numerator * b.Denominator;
  r := a.Denominator * b.Numerator;
  n := l div r;
  Result := TFraction.Create(l - n * r, a.Denominator * b.Denominator);
end;

class operator TFraction.Multiply(a, b: TFraction): TFraction;
begin
  Result := TFraction.Create(a.Numerator * b.Numerator, a.Denominator * b.Denominator);
end;

class operator TFraction.Negative(a: TFraction): TFraction;
begin
  Result := TFraction.Create(-a.Numerator, a.Denominator);
end;

class operator TFraction.NotEqual(a, b: TFraction): Boolean;
begin
  Result := (a.Numerator <> b.Numerator) or (a.Denominator <> b.Denominator);
end;

class function TFraction.Parse(value: string): TFraction;
var
  parts: TArray<string>;
  num, denom: Int64;
  fval: Double;
begin
  if value.IsEmpty then
    raise Exception.Create('Try parse a empty string');
  value := value.Replace('[', '');
  value := value.Replace(']', '').Trim;
  value := value.Replace(',', FormatSettings.DecimalSeparator);
  value := value.Replace('.', FormatSettings.DecimalSeparator);

  parts := value.Split(['/']);

  if length(parts) = 2 then
  begin
    if not TryStrToInt64(parts[0], num) or not (TryStrToInt64(parts[1], denom)) then
      raise Exception.Create('Try parse a invalid fraction string: "' + value + '"');
    exit(TFraction.Create(num, denom));
  end
  else if length(parts) = 1 then
  begin
    if TryStrToInt64(parts[0], num) then
      exit(TFraction.Create(num));

    if TryStrToFloat(parts[0], fval) then
      exit(DecimalToFraction(fval, MaximumDenominator));

    raise Exception.Create('Try parse a string, but is not a valid number');
  end
  else
    raise Exception.Create('Try parse a string with mutiples "/" chars');
end;

class operator TFraction.Positive(a: TFraction): TFraction;
begin
  Result := TFraction.Create(a);
end;

function TFraction.Reciprocal: TFraction;
begin
  Result := TFraction.Create(FDenom, FNum);
end;

class operator TFraction.Round(a: TFraction): Int64;
begin
  Result := round(a.Numerator / a.Denominator);
end;

class operator TFraction.Subtract(a, b: TFraction): TFraction;
begin
  Result := a + (-b);
end;

function TFraction.ToString: string;
begin
  if FDenom <> 1 then
    Result := Format('[%d / %d]', [FNum, FDenom])
  else
    Result := Format('[%d]', [FNum])
end;

class operator TFraction.Trunc(a: TFraction): Int64;
begin
  Result := Trunc(a.Numerator / a.Denominator);
end;

constructor TFraction.Create(a: TFraction);
begin
  Create(a.Numerator, a.Denominator);
end;

end.

