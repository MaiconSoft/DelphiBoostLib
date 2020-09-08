
# ``TFraction`` 

The **TFraction** implement a record for easy manager [Rational Numbers](https://en.wikipedia.org/wiki/Rational_number).

## Features

 - Support most operatores ( +, -, *, /, inc, dec, mod, div);
 - Implicity conversion from/to integer, double and string;
 - Simplify fractions automatically.

## Methods
```pascal
 	constructor Create(aNum, aDenom: Int64); overload;
	constructor Create(aNum: Int64); overload;
	constructor Create(a: TFraction); overload;
	constructor Create(a: string); overload;
 ```

> Constructors for TFraction, support:
- **aNum, aDenom (Int64)**: Fraction splited in numerator and denominator;
- **aNum (Int64)**: Fraction with only numerator (denominator is 1 by default);
- **a (TFraction)**: Clone a fraction;
- **a (string)**: Parse a string in fration. Formats acepted: "[1/2]","1/2","1","0.5","0,5".

### Tools
> Functions for fast create a fraction:

- function Fraction(num, denom: Int64): TFraction; overload;
- function Fraction(num: Int64): TFraction; overload;
- function Fraction(value: Double): TFraction; overload;
- function Fraction(value: string): TFraction; overload;

*Example:*

``` pascal
procedure Main;
var 
	a: TFraction;
begin
	a := Fraction(1,2); 	// expected: 1/2
	a := Fraction(1);		// expected: 1
	a := Fraction(0.5);		// expected: 1/2
	a := Fraction('1');		// expected: 1
	a := Fraction('1/2');	// expected: 1/2
	a := Fraction('[1/2]');	// expected: 1/2
	a := Fraction('0.5');	// expected: 1/2
end;
```

<hr width=”100%”>

``` pascal
function Abs: TFraction;
```
> Return a absolute value from fraction

*Params:*
> - None

*Return:*
>  - Result(TFraction): Absolute value from fraction.

*Example:*

``` pascal
procedure Main;
var 
	a: TFraction;
begin
	a := Fraction(-2,3).Abs; // expected: 2/3
end;
```
<hr width=”100%”>

``` pascal
function Reciprocal: TFraction;
```
> Return fraction with numerator and denominator swaped;

*Params:*
> - None

*Return:*
>  - Result(TFraction): fraction with numerator and denominator swaped.

*Example:*

``` pascal
procedure Main;
var 
	a: TFraction;
begin
	a := Fraction(2,3).Reciprocal; // expected: 3/2
end;
```
<hr width=”100%”>

``` pascal
function ToString: string;
```
> Return a fraction formated in string;

*Params:*
> - None

*Return:*
>  - Result(string): a fraction formated in string;

*Example:*

``` pascal
procedure Main;
var 
	a: TFraction;
begin
	writeln(Fraction(2,3).ToString); 	// expected: "[ 2/ 3]"
	writeln(Fraction(0.5).ToString); 	// expected: "[ 1/ 2]"
	writeln(Fraction(6).ToString); 		// expected: "[6]"
	writeln(Fraction(6/9).ToString); 	// expected: "[ 2/ 3]"
end;
``` 
<hr width=”100%”>

### Operadores 

> The object TFraction suppert most operators comuns.

*Example:*

``` pascal
procedure Main;
var
  a, b, c, d: TFraction;
  stringValue: string;
  intValue: Integer;
begin
  a := fraction(1, 2) + 2;   // expected:  5/2
  a := -0.5;                 // expected: -1/2
  inc(a, 2);                 // expected:  3/2
  dec(a, 1);                 // expected:  1/2
  b := '3';                  // expected:  3
  c := a * b;                // expected:  3/2
  d := a / b;                // expected:  6
  d := a div b;              // expected:  6 (same of '/')
  ShowMessage(c);            // expected:  [ 3/ 2]
  ShowMessage(d);            // expected:  [6]

  a := '12/18';              // expected:  2/3/
  stringValue := a;          // expected:  [ 2/ 3]

  intValue := Trunc(a);      // expected:  0 (trunc)
  intValue := Round(a);      // expected:  1 (Round)

  a := fraction(2, 3);       // expected:  2/3
  b := fraction(1, 3);       // expected:  1/3

  Writeln(a = b);            // expected: false
  Writeln(a <> b);           // expected: true
  Writeln(a > b);            // expected: true
  Writeln(a >= b);           // expected: true
  Writeln(a < b);            // expected: false
  Writeln(a <= b);           // expected: false
end;
``` 

## Properties	
TFraction support acess Numerator and Denominator using the readonly properties:

> - property Numerator: Int64 read FNum;

> - property Denominator: Int64 read FDenom;
*Example:*

``` pascal
procedure Main;
var
  a: TFraction;
begin
	a := Fraction(3,5);
	writeln(a.Numerator); 			// expected: 3
	writeln(a.Denominator);			// expected: 5
end;
``` 
 <hr width=”100%”>