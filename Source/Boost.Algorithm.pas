unit Boost.Algorithm;

interface

uses
  System.SysUtils, System.Types, Boost.Arrays, Boost.Math, Boost.Int,
  Boost.Float;

function Primes(const Limit: Integer): TIntegerDynArray;

function Hailstone(n: Integer): TIntegerDynArray;

implementation

function Primes(const Limit: Integer): TIntegerDynArray;
var
  i: Integer;
begin
  if Limit < 2 then
    exit;

  Result.Add(2);

  i := 3;
  while i <= Limit do
  begin
    if TMath.IsPrime(i) then
      Result.Add(i);
    inc(i, 2);
  end;
end;

// https://www.rosettacode.org/wiki/Hailstone_sequence#Delphi
function Hailstone(n: Integer): TIntegerDynArray;
begin
  Result.Add(n);
  while n <> 1 do
  begin
    if Odd(n) then
      n := (3 * n) + 1
    else
      n := n div 2;
    Result.Add(n);
  end;
end;

end.

