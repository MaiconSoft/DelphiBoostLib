## ``TBitset`` 
The TBitset is a library to manipulate bits individually.  

### Methods

<hr width=”100%”>

```pascal
 constructor Create(aSize: Integer); overload;
 ```

> Create a object with *aSize* spaces of bits.

*Params:*
> - aSize(Integer) = Length of array of bits.

*Example:*

``` pascal
procedure Main;
var 
	b: TBitset;
begin
	b.Create(8); // 8  bits = 1 byte

	ShowMessage(b.toString());
	// Expected: "[0 0 0 0 0 0 0 0]"
end;
```

<hr width=”100%”>

```pascal
 constructor Create(aLength: Integer; aInitializer: TFunc<Integer, Boolean>); overload;
 ```

> Create a object with *aLength* spaces of bits, and fill using a *aInitializer* function.

*Params:*
> - aLength(Integer) = Length of array of bits.
> - aInitializer(TFunc<Integer, Boolean>)) = Initializer function for fill bitset, using range of 0 to (*aLength*-1).

*Example:*

``` pascal
procedure Main;
var 
	b: TBitset;
begin
	b.Create(8, function(Index:Integer):Boolean
				begin
					Result:= odd(Index); // set all odd bits
				end); // 8  bits = 1 byte

	ShowMessage(b.toString());
	// Expected: "[1 0 1 0 1 0 1 0]"
end;
```

<hr width=”100%”>

```pascal
 constructor CreateAsNumber(value: Int64; bitOrder: TBitOrder = boLittleEndian);
 ```

> Create a object with 64 spaces of bits, dispousing the bits in order defined by bitOrder.

*Params:*
> - value(Int64) = Integer source of bits to store on TBitset.
> - bitOrder(TBitOrder) = define the order for store bits, can be boLittleEndian or boBigEndian .**Default**: boLittleEndian. See [https://en.wikipedia.org/wiki/Endianness].

*Example:*

``` pascal
procedure Main;
var 
	b: TBitset;
begin
	b.CreateAsNumber(5); // using order default (boLittleEndian)

	ShowMessage(data.toString());
	// Expected: "[0...0 0 0 0 0 1 0 1]" (64 bits size)

	b.CreateAsNumber(5,boBigEndian); // using order boBigEndian

	ShowMessage(b.toString());
	// Expected: "[1 0 1 0 0 0 0 ... 0]" (64 bits size)
end;
```

<hr width=”100%”>

```pascal
 procedure Assign(value: TBitset);
 ```

> Deep copy all bits from another TBitset (*value*).

*Params:*
> - value(TBitset) = Another TBitset, source of copy.

*Example:*

``` pascal
procedure Main;
var 
	b: TBitset;
begin
	b.Create(8);  // 8 bits size all clear

	ShowMessage(b.toString());
	// Expected: "[1 0 1 0 1 0 1 0]"
end;
```

<hr width=”100%”>

```pascal
 class operator Implicit(a: TBitset): Int64;
 ```

> Operator to convert automatically a TBitset to Int64.

*Example:*

``` pascal
procedure Main;
var 
	b: TBitset;
	data_byte: byte;
begin
	b.CreateAsNumber(10);
	
	ShowMessage(b.toString());
	// Expected: "[0 ... 0 0 0 1 0 1 0]"

	data_byte := b; // Implicit convert TBitset to Int64 and Int64 to byte
	ShowMessage(data_byte.toString());
	// Expected: "10"
end;
```

<hr width=”100%”>

```pascal
 class operator Implicit(a: Int64): TBitset;
 ```

> Operator to convert automatically a Int64 to TBitset.

*Example:*

``` pascal
procedure Main;
var 
	b: TBitset;
	data_byte: byte;
begin
	data_byte := 15;
	
	ShowMessage(data_byte.toString());
	// Expected: "15"

	b := data_byte // Implicit convert byte to Int64 and Int64 to TBitset
	ShowMessage(b.toString());
	// Expected: "[0 ... 0 0 0 1 1 1 1]"	
end;
```

<hr width=”100%”>

```pascal
 class operator Implicit(a: TBitset): string;
 ```

> Operator to convert automatically a TBitset to string.

*Example:*

``` pascal
procedure Main;
var 
	b: TBitset;
	data_byte: byte;
begin
	b.CreateAsNumber(6);

	ShowMessage(b);
	// Expected: "[0 ... 0 0 0 0 1 1 0]"	
end;
```

<hr width=”100%”>

```pascal
class operator LeftShift(a: TBitset; n: Integer): TBitset;
 ```

> Operator to shift bits to left, by *n* times (symbol *shl*).

*Example:*

``` pascal
procedure Main;
var 
	b:,c TBitset;
begin
	b.CreateAsNumber(1);

	ShowMessage(b);
	// Expected: "[0 ... 0 0 0 0 0 0 1]"	
	
	c :=  b shl 2;
	
	ShowMessage(c);
	// Expected: "[0 ... 0 0 0 0 1 0 0]"	
end;
```

<hr width=”100%”>

```pascal
class operator RightShift(a: TBitset; n: Integer): TBitset;
 ```

> Operator to shift bits to right, by *n* times (symbol *shr*).

*Example:*

``` pascal
procedure Main;
var 
	b:,c TBitset;
begin
	b.CreateAsNumber(16);

	ShowMessage(b);
	// Expected: "[0 ... 0 0 1 0 0 0 0]"	
	
	c :=  b shr 2;
	
	ShowMessage(c);
	// Expected: "[0 ... 0 0 0 0 1 0 0]"	
end;
```

<hr width=”100%”>

```pascal
class operator BitwiseAnd(a: TBitset; b: TBitset): TBitset;
 ```

> Operator to applay AND function in every bit (symbol *and*). If the Tbitset elements (*a* and *b*)  has different sizes, the output size will be same of smallest element.

*Example:*

``` pascal
procedure Main;
var 
	a,b,c: TBitset;
begin
	a.CreateAsNumber(3);
	b.CreateAsNumber(6);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 0 0 0 1 1]"	
	
	ShowMessage(b);
	// Expected: "[0 ... 0 0 0 0 1 1 0]"	
	
	c :=  a and b;
	
	ShowMessage(c);
	// Expected: "[0 ... 0 0 0 0 0 1 0]"	
end;
```

<hr width=”100%”>

```pascal
class operator BitwiseOr(a: TBitset; b: TBitset): TBitset;
 ```

> Operator to applay OR function in every bit (symbol *or*). If the Tbitset elements (*a* and *b*)  has different sizes, the output size will be same of largest element.

*Example:*

``` pascal
procedure Main;
var 
	a,b,c: TBitset;
begin
	a.CreateAsNumber(3);
	b.CreateAsNumber(6);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 0 0 0 1 1]"	
	
	ShowMessage(b);
	// Expected: "[0 ... 0 0 0 0 1 1 0]"	
	
	c :=  a or b;
	
	ShowMessage(c);
	// Expected: "[0 ... 0 0 0 0 1 1 1]"	
end;
```

<hr width=”100%”>

```pascal
class operator BitwiseXor(a: TBitset; b: TBitset): TBitset;
 ```

> Operator to applay XOR function in every bit (symbol *xor*). If the Tbitset elements (*a* and *b*)  has different sizes, the output size will be same of largest element.

*Example:*

``` pascal
procedure Main;
var 
	a,b,c: TBitset;
begin
	a.CreateAsNumber(3);
	b.CreateAsNumber(6);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 0 0 0 1 1]"	
	
	ShowMessage(b);
	// Expected: "[0 ... 0 0 0 0 1 1 0]"	
	
	c :=  a xor b;
	
	ShowMessage(c);
	// Expected: "[0 ... 0 0 0 0 1 0 1]"	
end;
```

<hr width=”100%”>

```pascal
class operator Equal(a: TBitset; b: TBitset): Boolean;
 ```

> Operator to test elements *a* and *b* has the same content (symbol *=*).

*Example:*

``` pascal
procedure Main;
var 
	a,b: TBitset;
	c: Boolean;
begin
	a.CreateAsNumber(3);
	b.CreateAsNumber(6);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 0 0 0 1 1]"	
	
	ShowMessage(b);
	// Expected: "[0 ... 0 0 0 0 1 1 0]"	
	
	c :=  a = b;
	
	ShowMessage(c);
	// Expected: "False"	
end;
```

<hr width=”100%”>

```pascal
class operator NotEqual(a: TBitset; b: TBitset): Boolean;
 ```

> Operator to test elements *a* and *b* hasn't the same content (symbol *<>*).

*Example:*

``` pascal
procedure Main;
var 
	a,b: TBitset;
	c: Boolean;
begin
	a.CreateAsNumber(3);
	b.CreateAsNumber(6);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 0 0 0 1 1]"	
	
	ShowMessage(b);
	// Expected: "[0 ... 0 0 0 0 1 1 0]"	
	
	c :=  a <> b;
	
	ShowMessage(c);
	// Expected: "True"	
end;
```

<hr width=”100%”>

```pascal
function AndNot(b: TBitset): TBitset;
 ```

> This function apply the *and* and *not* (flip) operatores at same time, between *b* bitset and it self.

*Params:*
> - b(TBitset) = Another TBitset to combine with self.

*Return:*
> - Result(TBitset) = the combination of two elements.
*Example:*

``` pascal
procedure Main;
var 
	a,b,c: TBitset;
begin
	a.CreateAsNumber(3);
	b.CreateAsNumber(6);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 0 0 0 1 1]"	
	
	ShowMessage(b);
	// Expected: "[0 ... 0 0 0 0 1 1 0]"	
	
	c :=  a.AndNot(b);
	
	ShowMessage(c);
	// Expected: "[1 ... 1 1 1 1 1 0 1]"
end;
```

<hr width=”100%”>

```pascal
function Flip: TBitset; overload;
 ```

> Invert all bits of it self, then return the result of this operation.

*Return:*
> - Result(TBitset) = new TBitset with all bits inverted.
*Example:*

``` pascal
procedure Main;
var 
	a,b: TBitset;
begin
	a.CreateAsNumber(3);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 0 0 0 1 1]"	
	
	b :=  a.flip;
	
	ShowMessage(b);
	// Expected: "[1 ... 1 1 1 1 1 0 0]"
end;
```

<hr width=”100%”>

```pascal
function Flip(Index: Integer): TBitset; overload;
 ```

> Invert the bit in postion *Index* of it self, then return the result of this operation.
*Params:*
> - Index(Index): Position of bit to invert (zero is is fist position).

*Return:*
> - Result(TBitset) = new TBitset with all bits inverted.
*Example:*

``` pascal
procedure Main;
var 
	a,b: TBitset;
begin
	a.CreateAsNumber(3);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 0 0 0 1 1]"	
	
	b :=  a.flip(2);
	
	ShowMessage(b);
	// Expected: "[0 ... 0 0 0 0 1 1 1]"
end;
```

<hr width=”100%”>

```pascal
function Flip(aFrom, aTo: Integer): TBitset; overload;
 ```

> Invert the bit postions  between *aFrom* and *aTo* (inclusive) of it self, then return the result of this operation.
*Params:*
> - aFrom(Index): Start position of bit to invert (zero is is fist position).
> - aTo(Index): End position of bit to invert (zero is is fist position).

*Return:*
> - Result(TBitset) = new TBitset with all bits inverted.
*Example:*

``` pascal
procedure Main;
var 
	a,b: TBitset;
begin
	a.CreateAsNumber(3);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 0 0 0 1 1]"	
	
	b :=  a.flip(1,4);
	
	ShowMessage(b);
	// Expected: "[0 ... 0 0 1 1 1 0 1]"
end;
```

<hr width=”100%”>

```pascal
function IsEmpty: Boolean;
 ```

> Test if has zero size of bits.
*Params:*
> - None.

*Return:*
> - Result(Boolean) = TRUE if size is zero.
*Example:*

``` pascal
procedure Main;
var 
	a: TBitset;
begin
	a.CreateAsNumber(3);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 0 0 0 1 1]"		

	ShowMessage(a.IsEmpty());
	// Expected: "FALSE"

	a.Create(0);

	ShowMessage(a.IsEmpty());
	// Expected: "TRUE"
end;
```

<hr width=”100%”>

```pascal
function LastTrueIndex: Integer;
 ```

> Return a position of last bit set (TRUE) of bitset.
*Params:*
> - None.

*Return:*
> - Result(Integer) = Index of last bit TRUE, or -1 if not found.
*Example:*

``` pascal
procedure Main;
var 
	a: TBitset;
begin
	a.CreateAsNumber(3);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 0 0 0 1 1]"		

	ShowMessage(a.LastTrueIndex());
	// Expected: "1"
end;
```

<hr width=”100%”>

```pascal
function FirstTrueIndex: Integer;
 ```

> Return a position of first bit set (TRUE) of bitset.
*Params:*
> - None.

*Return:*
> - Result(Integer) = Index of first bit TRUE, or -1 if not found.
*Example:*

``` pascal
procedure Main;
var 
	a: TBitset;
begin
	a.CreateAsNumber(3);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 0 0 0 1 1]"		

	ShowMessage(a.FirstTrueIndex());
	// Expected: "0"
end;
```

<hr width=”100%”>

```pascal
function NextTrueIndex(StartIndex: Integer = 0): Integer;
 ```

> Return a position of first bit set (TRUE) of bitset after *StartIndex* postion (inclusive).
*Params:*
> - None.

*Return:*
> - Result(Integer) = Index of bit TRUE, or -1 if not found.
*Example:*

``` pascal
procedure Main;
var 
	a: TBitset;
begin
	a.CreateAsNumber(19);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 1 0 0 1 1]"		

	ShowMessage(a.NextTrueIndex(2));
	// Expected: "4"
end;
```

<hr width=”100%”>

```pascal
function NextTrueIndex(StartIndex: Integer = 0): Integer;
 ```

> Return a position of first bit set (TRUE) of bitset after *StartIndex* postion (inclusive).
*Params:*
> - None.

*Return:*
> - Result(Integer) = Index of bit TRUE, or -1 if not found.
*Example:*

``` pascal
procedure Main;
var 
	a: TBitset;
begin
	a.CreateAsNumber(19);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 1 0 0 1 1]"		

	ShowMessage(a.NextTrueIndex(2));
	// Expected: "4"
end;
```

<hr width=”100%”>

```pascal
function PreviousTrueIndex(StartIndex: Integer = 0): Integer;
 ```

> Return a position of first bit set (TRUE) of bitset before *StartIndex* position (inclusive).
*Params:*
> - None.

*Return:*
> - Result(Integer) = Index of bit TRUE, or -1 if not found.

*Example:*

``` pascal
procedure Main;
var 
	a: TBitset;
begin
	a.CreateAsNumber(19);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 1 0 0 1 1]"		

	ShowMessage(a.PreviousTrueIndex(3));
	// Expected: "1"
end;
```

<hr width=”100%”>

```pascal
function NextFalseIndex(StartIndex: Integer = 0): Integer;
 ```

> Return a position of first bit clear (FALSE) of bitset after *StartIndex* position (inclusive).
*Params:*
> - None.

*Return:*
> - Result(Integer) = Index of bit FALSE, or -1 if not found.

*Example:*

``` pascal
procedure Main;
var 
	a: TBitset;
begin
	a.CreateAsNumber(19);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 1 0 0 1 1]"		

	ShowMessage(a.NextFalseIndex(0));
	// Expected: "2"
end;
```

<hr width=”100%”>

```pascal
function PreviousFalseIndex(StartIndex: Integer = 0): Integer;
 ```

> Return a position of first bit clear (FALSE) of bitset before *StartIndex* position (inclusive).
*Params:*
> - None.

*Return:*
> - Result(Integer) = Index of bit FALSE, or -1 if not found.

*Example:*

``` pascal
procedure Main;
var 
	a: TBitset;
begin
	a.CreateAsNumber(19);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 1 0 0 1 1]"		

	ShowMessage(a.PreviousFalseIndex(4));
	// Expected: "3"
end;
```

<hr width=”100%”>

```pascal
function NextBitIndex(StartIndex: Integer; LookFor: boolean): Integer;
 ```

> Return a position of first bit with state of *LookFor* of bitset after *StartIndex* position (inclusive).
*Params:*
> - None.

*Return:*
> - Result(Integer) = Index of bit with state of *LookFor*, or -1 if not found.

*Example:*

``` pascal
procedure Main;
var 
	a: TBitset;
begin
	a.CreateAsNumber(19);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 1 0 0 1 1]"		

	ShowMessage(a.NextBitIndex(2,True));
	// Expected: "4"
end;
```

<hr width=”100%”>

```pascal
function PreviousBitIndex(StartIndex: Integer; LookFor: boolean): Integer;
 ```

> Return a position of first bit with state of *LookFor* of bitset before *StartIndex* position (inclusive).
*Params:*
> - None.

*Return:*
> - Result(Integer) = Index of bit with state of *LookFor*, or -1 if not found.

*Example:*

``` pascal
procedure Main;
var 
	a: TBitset;
begin
	a.CreateAsNumber(19);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 1 0 0 1 1]"		

	ShowMessage(a.PreviousBitIndex(4,False));
	// Expected: "3"
end;
```

<hr width=”100%”>

```pascal
procedure SetBit(Index: Integer);
 ```

> Set the state of bit at position *Index*, to TRUE.

*Params:*
> - Index(Integer): Position of bit to set.

*Return:*
> - None.

*Example:*

``` pascal
procedure Main;
var 
	a: TBitset;
begin
	a.CreateAsNumber(19);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 1 0 0 1 1]"		

	a.SetBit(2);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 1 0 1 1 1]"	
end;
```

<hr width=”100%”>

```pascal
procedure Clear(Index: Integer); overload;
 ```

> Set the state of bit at position *Index*, to FALSE.

*Params:*
> - Index(Integer): Position of bit to clear.

*Return:*
> - None.

*Example:*

``` pascal
procedure Main;
var 
	a: TBitset;
begin
	a.CreateAsNumber(19);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 1 0 0 1 1]"		

	a.Clear(0);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 1 0 0 1 0]"	
end;
```

<hr width=”100%”>

```pascal
procedure Clear(aFrom, aTo: Integer); overload;
 ```

> Set the state of bits from position *aFrom* to *aTo*, to FALSE.

*Params:*
> - Index(Integer): Position of bit to clear.

*Return:*
> - None.

*Example:*

``` pascal
procedure Main;
var 
	a: TBitset;
begin
	a.CreateAsNumber(19);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 1 0 0 1 1]"		

	a.Clear(0,2); // clear 0,1,2 bits

	ShowMessage(a);
	// Expected: "[0 ... 0 0 1 0 0 0 0]"	
end;
```

<hr width=”100%”>

```pascal
procedure Clear(); overload;
 ```

> Set the state of all bits to FALSE.

*Params:*
> - None.

*Return:*
> - None.

*Example:*

``` pascal
procedure Main;
var 
	a: TBitset;
begin
	a.CreateAsNumber(19);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 1 0 0 1 1]"		

	a.Clear;

	ShowMessage(a);
	// Expected: "[0 ... 0 0 0 0 0 0 0]"	
end;
```

<hr width=”100%”>

```pascal
function ToString(Reverse: boolean = True): string;
 ```

> Format the bits array in string.

*Params:*
> - Reverse(Boolean): If TRUE the first bit (index=0) will be in right. *Default* TRUE.

*Return:*
> - Result(String): String formated.

*Example:*

``` pascal
procedure Main;
var 
	a: TBitset;
begin
	a.CreateAsNumber(19);

	ShowMessage(a.ToString());
	// Expected: "[0 ... 0 0 1 0 0 1 1]"		

	ShowMessage(a.ToString(False));
	// Expected: "[1 1 0 0 1 0 0 ... 0]"		
end;
```

<hr width=”100%”>

```pascal
property BitOrder: TBitOrder read FBitOrder write FBitOrder;
 ```

> Define the order for store bits. This not change order of bits previus stored, just next assigned values.

*Options:*
> - boLittleEndian: The LSB (Less Significant Bit) will be stored in lower position (index = 0) and MSB (Most Significant Bit) in the last position of array. This is the default.
> - boBigEndian: The MSB (Most Significant Bit) will be stored in lower position (index = 0) and LSB (Less Significant Bit) in the last position of array.

*Example:*

``` pascal
procedure Main;
var 
	a: TBitset;
begin
	a.Create;
	a.BitOrder := boBigEndian; 
	a := 5;
	
	ShowMessage(a);
	// Expected: "[1 0 1 0 0 0 0 ... 0]"		
end;
```

<hr width=”100%”>

```pascal
property AsNumber: Int64 read GetAsNumber write SetAsNumber;
 ```

> Read or Write a Int64 value in bitset. Values Integers based (byte, word, integer, cardinal etc.) will be implicitty converted in int64, warning for possible error in conversion.

*Example:*

``` pascal
procedure Main;
var 
	a: TBitset;
begin
	a.Create;
	a.AsNumber := 19;

	a.SetBit(2);

	ShowMessage(a);
	// Expected: "[0 ... 0 0 1 0 1 1 1]"		

	ShowMessage(a.AsNumber);
	// Expected: "23"	
end;
```

<hr width=”100%”>

```pascal
property Bits[Index: Integer]: Boolean read GetBit write _SetBit;
 ```

> Read or Write a bit in bitset directilly at *Index* position as Boolean.

*Example:*

``` pascal
procedure Main;
var 
	a: TBitset;
	value:Integer;
begin
	a.Create;
	a.AsNumber := 5;

	a.Bits[0] := False;

	ShowMessage(a);
	// Expected: "[0 ... 0 0 0 0 1 0 0]" 

	value:= a; // (decimal number 4)

	if a.Bits[0] then
		ShowMessage('"a" value is ' + value.toString + 'and it is odd')
	else
		ShowMessage('"a" value is ' + value.toString + 'and it is even')
	// Expected: ""a" value is 4 and it is even"	
end;
```

<hr width=”100%”>

```pascal
property Size: Integer read GetSize write SetSize;
 ```

> Read or Write of size of array for store bits. The size can be changed automatically if need. Values of size bellow zero will be ignored.

*Return:*
> - None.

*Example:*

``` pascal
procedure Main;
var 
	a,b: TBitset;
	c: byte;
begin
	a.Create; // size 0 if default
	a.size := 8;

	c := 5;

	a:= c; // size will be changed to 64 

	b.Create(128);

	b:= c; // size will be stay in 128 
end;
```

<hr width=”100%”>