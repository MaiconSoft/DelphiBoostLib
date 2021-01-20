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
