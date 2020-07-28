unit Boost.Math;

interface

uses
  System.SysUtils, Math;

type
  TMath = record
    class function IsPrime(const a: UInt64): Boolean; static;
    class function Clamp(const Val, lo, hi: Integer): Integer; overload; static;
    class function Clamp(const Val, lo, hi: UInt64): UInt64; overload; static;
    class function Clamp(const Val, lo, hi: Int64): Int64; overload; static;
    class function Clamp(const Val, lo, hi: Double): Double; overload; static;
    class function Clamp(const Val, lo, hi: Extended): Extended; overload; static;
    class function Map(x, in_min, in_max, out_min, out_max: Integer): Integer;
      overload; static;
    class function Map(x, in_min, in_max, out_min, out_max: Int64): Int64;
      overload; static;
    class function Map(x, in_min, in_max, out_min, out_max: UInt64): UInt64;
      overload; static;
    class function Map(x, in_min, in_max, out_min, out_max: Double): Double;
      overload; static;
    class function Map(x, in_min, in_max, out_min, out_max: Extended): Extended;
      overload; static;
  end;

implementation


{ TMath }

class function TMath.Clamp(const Val, lo, hi: Integer): Integer;
begin
  Result := max(min(Val, hi), lo);
end;

class function TMath.Clamp(const Val, lo, hi: UInt64): UInt64;
begin
  Result := max(min(Val, hi), lo);
end;

class function TMath.Clamp(const Val, lo, hi: Double): Double;
begin
  Result := max(min(Val, hi), lo);
end;

class function TMath.Clamp(const Val, lo, hi: Extended): Extended;
begin
  Result := max(min(Val, hi), lo);
end;

class function TMath.Clamp(const Val, lo, hi: Int64): Int64;
begin
  Result := max(min(Val, hi), lo);
end;

class function TMath.IsPrime(const a: UInt64): Boolean;
var
  d: UInt64;
begin
  if (a < 2) then
    exit(False);

  if (a mod 2) = 0 then
    exit(a = 2);

  if (a mod 3) = 0 then
    exit(a = 3);

  d := 5;

  while (d * d <= a) do
  begin
    if (a mod d = 0) then
      Exit(false);
    inc(d, 2);

    if (a mod d = 0) then
      Exit(false);
    inc(d, 4);
  end;

  Result := True;
end;

class function TMath.Map(x, in_min, in_max, out_min, out_max: Integer): Integer;
begin
  Result := round((x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min);
end;

class function TMath.Map(x, in_min, in_max, out_min, out_max: Int64): Int64;
begin
  Result := round((x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min);
end;

class function TMath.Map(x, in_min, in_max, out_min, out_max: UInt64): UInt64;
begin
  Result := round((x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min);
end;

class function TMath.Map(x, in_min, in_max, out_min, out_max: Double): Double;
begin
  Result := (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
end;

class function TMath.Map(x, in_min, in_max, out_min, out_max: Extended): Extended;
begin
  Result := (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
end;

end.

