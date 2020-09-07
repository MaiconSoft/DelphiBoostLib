
# ``TFraction`` 

The **TFraction** implement a record for easy manager [Rational Numbers](https://en.wikipedia.org/wiki/Rational_number).

## Features

 - Support most operatores ( +, -, *, /, inc, dec, mod, div);
 - Implicity conversion from/to integer, double and string;
 - Simplify fractions automatically.

## Methods

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

## Properties	
	property Numerator: Int64 read FNum;
	property Denominator: Int64 read FDenom;

 <hr width=”100%”>