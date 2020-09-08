## ``TArray <<TYPE>>`` 
**Aka:** Array of <TYPE>, T<TYPE>DynArray

### Methods

#### Notes:
<div id="SURROUND_INDEX"/>

 Surround index: The index can be above length of array or bellow zero.

> Above values will be coverted in first mutiple of length.

> Bellow zero values will be converted in reverse order:

> Examples: [a, b, c, d]:

> - Index(0) = a
> - Index(3) = d
> - Index(4) = a
> - Index(8) = a
> - Index(-1) = d
> - Index(-2) = c
> - Index(-5) = d


<hr width=”100%”>

```pascal
 function Join(const Separator: string = ' '): string
 ```

> Combine all elements from array into a string, delimited by 'Separator' param.

*Params:*
> - Separator(string) = string to conect the elements. **Default**: single space (" ").

*Return:*
>  - Result(string) = Joined elements.

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];

	ShowMessage(data.join());
	// Expected: "<EX1> <EX2> <EX3>"

	ShowMessage(data.join(', '));
	// Expected: "<EX1>, <EX2>, <EX3>"

	ShowMessage(data.join(' - '));
	// Expected: "<EX1> - <EX2> - <EX3>"
end;
```

<hr width=”100%”>

```pascal
 procedure Sort; overload;
 ```

> Sorts all elements of the array in ascending order.

*Params:*
> - None

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX2'>,<EX3'>,<EX1'>];

	data.sort();

	ShowMessage(data.join());
	// Expected: "<EX1> <EX2> <EX3>"
end;
```
<hr width=”100%”>

```pascal
 procedure Sort(const Comparison: TComparison<<TYPE>>); overload;
 ```

> Sorts all elements of the array in using the 'Comparison' function, the order is custom.

*Params:*
> - ``Comparison(TComparison<<TYPE>>)``: Custom function to compare elements.

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX2'>,<EX3'>,<EX1'>];

	data.sort();

	ShowMessage(data.join());
	// Expected: "<EX1> <EX2> <EX3>"
end;
```

<hr width=”100%”>

```pascal
 procedure Sort(const Comparison: TComparison<<TYPE>>; Index, Count: integer);
      overload;
 ```

> Same of custom Sort, but with limits.

*Params:*
> - ``Comparison(TComparison<<TYPE>>)``: Custom function to compare elements;
> - Index(Integer): Start index;
> - Count(Integer): Length of range.

*Return:*
>  - None

<hr width=”100%”>

```pascal
 procedure RSort;
 ```

> Sorts all elements of the array in descending order.

*Params:*
> - None

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];

	data.rsort();

	ShowMessage(data.join());
	// Expected: "<EX3> <EX2> <EX1>"
end;
```

<hr width=”100%”>

```pascal
 procedure Shuffle;
 ```

> Shuffle all elements of the array in random order.

*Params:*
> - None

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX3'>,<EX2'>];

	data.Shuffle();

	ShowMessage(data.join());
	// Expected: random order every time
	// Example: "<EX2> <EX3> <EX1>"
end;
```

<hr width=”100%”>

```pascal
 procedure Reverse;
 ```

> Invert the order of all elements.

*Params:*
> - None

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];

	data.Reverse();

	ShowMessage(data.join());
	// Expected: "<EX3> <EX2> <EX1>"
end;
```

<hr width=”100%”>

```pascal
 function IndexOf(const Value: <TYPE>; StartPos: Integer = 0): Integer;
 ```

> Get index of a element in array.

*Params:*
> - Value(<TYPE>): Search element;
> - StartPos(Integer): Position to start search. **Default** 0.

*Return:*
>  - Result(Integer):
>  	- If item is found: return index of value in array (zero based);
>  	- Else: return -1.

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
	index: Integer;
begin
	data = [<EX1'>,<EX2'>,<EX1'> <EX3'>];

	index = data.IndexOf(<EX1'>);
	// Expected: 0

	index = data.IndexOf(<EX2'>);
	// Expected: 1

	index = data.IndexOf(<EX4'>);
	// Expected: -1	

	index = data.IndexOf(<EX1'>,1);
	// Expected: 2

	index = data.IndexOf(<EX2'>,2);
	// Expected: -1

end;
```

<hr width=”100%”>

```pascal
 function LastIndexOf(const Value: string; EndPos: Integer = MaxInt): Integer;
 ```

> The same of IndexOf, but search backward.

*Params:*
> - Value(string): Search element;
> - EndPos(Integer): Position to start search, values above length will be truncate **Default** MaxInt.

*Return:*
>  - Result(Integer):
>  	- If item is found: return index of value in array (zero based);
>  	- Else: return -1.

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
	index: Integer;
begin
	data = [<EX1'>,<EX2'>,<EX1'>, <EX3'>];

	index = data.LastIndexOf(<EX1'>);
	// Expected: 2

	index = data.LastIndexOf(<EX2'>);
	// Expected: 1

	index = data.LastIndexOf(<EX4'>);
	// Expected: -1	

	index = data.LastIndexOf(<EX1'>,1);
	// Expected: 0

	index = data.LastIndexOf(<EX3'>,2);
	// Expected: -1

end;
```

<hr width=”100%”>

```pascal
 procedure Delete(Index: Integer); overload;
 ```

> Delete the element at index. Ignore if length of array is zero.

*Params:*
> - Index(Integer): Index of element in array. See [Surround Index](#SURROUND_INDEX).

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];
	data.Delete(0);
	ShowMessage(data.join());	
	// Expected: "<EX3> <EX2>"

	data = [<EX1'>,<EX2'>,<EX3'>];
	data.Delete(-1);
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX3>"

	data = [<EX1'>,<EX2'>,<EX3'>];
	data.Delete(-2);
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX2>"

	data = [<EX1'>,<EX2'>,<EX3'>];
	data.Delete(-3);
	ShowMessage(data.join());	
	// Expected: "<EX3> <EX2>"
end;
```

<hr width=”100%”>

```pascal
procedure Delete(Index, Count: Integer); overload;
 ```

> Delete a range of elements at index. Ignore if length of array is zero ou 'Count' <= 0. 

*Params:*
> - Index(Integer): Index of element in array. See [Surround Index](#SURROUND_INDEX).
> - Count(Integer): Length of range to delete. Values of 'Count' out of range will be truncate.

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin	
	data = [<EX1'>,<EX2'>,<EX3'>];
	data.Delete(0,0);
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX2> <EX3>"

	data = [<EX1'>,<EX2'>,<EX3'>];
	data.Delete(0,2);
	ShowMessage(data.join());	
	// Expected: "<EX3>"

	data = [<EX1'>,<EX2'>,<EX3'>];
	data.Delete(-1,2);
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX2>"

	data = [<EX1'>,<EX2'>,<EX3'>];
	data.Delete(1,5);
	ShowMessage(data.join());	
	// Expected: "<EX1>"
end;
```

<hr width=”100%”>

```pascal
procedure Insert(Index: Integer; Value: string); overload;
 ```

> Inset a value into array at position index; 

*Params:*
> - Index(Integer): Position to insert in array. See [Surround Index](#SURROUND_INDEX).
> - Value(String): Value to insert.

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];	
	data.Insert(0,<EX4'>);
	ShowMessage(data.join());	
	// Expected: "<EX4> <EX1> <EX2> <EX3>"
	
	data = [<EX1'>,<EX2'>,<EX3'>];
	data.Insert(-1,<EX4'>);
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX2> <EX4> <EX3>"

	data = [<EX1'>,<EX2'>,<EX3'>];
	data.Insert(4,<EX4'>);
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX4> <EX2> <EX3>"
end;
```

<hr width=”100%”>

```pascal
procedure Insert(Index: Integer; Values: T<TYPE>DynArray); overload;
 ```

> Inset a range of value into array at position index; 

*Params:*
> - Index(Integer): Position to insert in array. See [Surround Index](#SURROUND_INDEX).
> - Values(T<TYPE>DynArray): Values to insert.

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];	
	data.Insert(0,[<EX4'>,<EX5'>,<EX6'>]);
	ShowMessage(data.join());	
	// Expected: "<EX4> <EX5> <EX6> <EX1> <EX2> <EX3>"

	data = [<EX1'>,<EX2'>,<EX3'>];
	data.Insert(-1,[<EX4'>,<EX5'>,<EX6'>]);
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX2> <EX4> <EX5> <EX6> <EX3>"
	
	data = [<EX1'>,<EX2'>,<EX3'>];
	data.Insert(4,[<EX4'>,<EX5'>,<EX6'>]);
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX4> <EX5> <EX6> <EX2> <EX3>"
end;
```

<hr width=”100%”>

```pascal
procedure Add(Value: <TYPE>); overload;
 ```

> Append value in array; 

*Params:*
> - Value(<TYPE>): Value to append

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];
	
	data.Add(<EX4'>);
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX2> <EX3> <EX4>"
end;
```

<hr width=”100%”>

```pascal
procedure Add(Values: T<TYPE>DynArray); overload;
 ```

> Append a range of values in array; 

*Params:*
> - Values(T<TYPE>DynArray): Range of values to append

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];
	
	data.Add([<EX4'>,<EX5'>,<EX6'>]);
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX2> <EX3> <EX4> <EX5> <EX6>"
end;
```

<hr width=”100%”>

```pascal
function CountItems(Item: <TYPE>): Integer;
```

> Count how many times the item exist in array; 

*Params:*
> - Item(<TYPE>): Item for search for.

*Return:*
>  - Result(Integer): Number of Itens found (0 if not found).

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
	count:Integer;
begin
	data = [<EX1'>,<EX2'>,<EX1'>,<EX3'>,<EX1'>,<EX3'>];
	
	count:= data.CountItems(<EX1'>);	
	// Expected: 3

	count:= data.CountItems(<EX2'>);	
	// Expected: 1

	count:= data.CountItems(<EX3'>);	
	// Expected: 2

	count:= data.CountItems(<EX6'>);	
	// Expected: 0
end;
```

<hr width=”100%”>

```pascal
procedure Remove(Item: <TYPE>); overload;
 ```

> Removes the first occurrence of the Item in array by value.  

*Params:*
> - Item(<TYPE>): Item for search for.

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX1'>,<EX3'>];
	
	data.Remove(<EX2'>);
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX1> <EX3>"

	data = [<EX1'>,<EX2'>,<EX1'>,<EX3'>];
	data.Remove(<EX1'>);
	ShowMessage(data.join());	
	// Expected: "<EX2> <EX1> <EX3>"
	
	data = [<EX1'>,<EX2'>,<EX1'>,<EX3'>];
	data.Remove(<EX5'>);
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX2> <EX1> <EX3>"

end;
```

<hr width=”100%”>

```pascal
procedure Remove(Item: <TYPE>; count: integer); overload;
 ```

> Removes the 'Count' occurrences of the Item in array.  

*Params:*
> - Item(<TYPE>): Item for search for.
> - Count(Integer): Number of repetitions of item to be removed.

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX1'>,<EX3'>];
	
	data.Remove(<EX2'>,0);
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX2> <EX1> <EX3>"

	data = [<EX1'>,<EX2'>,<EX1'>,<EX3'>];
	data.Remove(<EX1'>,2);
	ShowMessage(data.join());	
	// Expected: "<EX2> <EX3>"
	
	data = [<EX1'>,<EX2'>,<EX1'>,<EX3'>];
	data.Remove(<EX5'>,3);
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX2> <EX1> <EX3>"

end;
```

<hr width=”100%”>

```pascal
procedure Clear();
 ```

> Removes all elements in array and set length to zero;  

*Params:*
>  - None

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];
	
	data.Clear();
	ShowMessage(data.join());	
	// Expected: ""
	ShowMessage(IntToStr(data.length);	
	// Expected: 0
end;
```

<hr width=”100%”>

```pascal
function Slice(StartPos, EndPos: integer): T<TYPE>DynArray; overload;
 ```

> Extract a piece of array between 'StartPos' and 'EndPos' (incluse)

*Params:*
>  - StartPos(Integer): Initial position to cut;
>  - EndPos(Integer): Final position to cut;

*Return:*
>  - Result(T<TYPE>DynArray): Array extracted;

*Example:*

``` pascal
procedure Main;
var 
	data,piece: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];
	
	piece = data.slice(0,1);
	ShowMessage(piece.join());	
	// Expected: "<EX1> <EX2>"
	
	piece = data.slice(-1,1);
	ShowMessage(piece.join());	
	// Expected: "<EX3> <EX1>"
	
	piece = data.slice(4,1);
	ShowMessage(piece.join());	
	// Expected: "<EX2>"
end;
```

<hr width=”100%”>

```pascal
function Slice(StartPos: integer): T<TYPE>DynArray; overload;
 ```

> Extract a piece of array between 'StartPos' and length of array

*Params:*
>  - StartPos(Integer): Initial position to cut;

*Return:*
>  - Result(T<TYPE>DynArray): Array extracted;

*Example:*

``` pascal
procedure Main;
var 
	data,piece: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];
	
	piece = data.slice(0);
	ShowMessage(piece.join());	
	// Expected: "<EX1> <EX2> <EX3>"
	
	piece = data.slice(-1);
	ShowMessage(piece.join());	
	// Expected: "<EX3>"
	
	piece = data.slice(4);
	ShowMessage(piece.join());	
	// Expected: "<EX2>"
end;
```

<hr width=”100%”>

```pascal
function Head(EndPos: integer): T<TYPE>DynArray;
 ```

> Extract a piece of array between position 0 and 'EndPos';

*Params:*
>  - EndPos(Integer): Final position to cut;

*Return:*
>  - Result(T<TYPE>DynArray): Array extracted;

*Example:*

``` pascal
procedure Main;
var 
	data,piece: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];
	
	piece = data.Head(0);
	ShowMessage(piece.join());	
	// Expected: "<EX1>"
	
	piece = data.Head(-1);
	ShowMessage(piece.join());	
	// Expected: "<EX1> <EX2> <EX3>"
	
	piece = data.Head(4);
	ShowMessage(piece.join());	
	// Expected: "<EX1> <EX2>"
end;
```

<hr width=”100%”>

```pascal
function Tail(StartPos: integer): T<TYPE>DynArray;
 ```

> Extract a piece of array between position 'StartPos' and length of array;

*Params:*
>  - StartPos(Integer): Initial position to cut;

*Return:*
>  - Result(T<TYPE>DynArray): Array extracted;

*Example:*

``` pascal
procedure Main;
var 
	data,piece: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];
	
	piece = data.Tail(0);
	ShowMessage(piece.join());	
	// Expected: "<EX1> <EX2> <EX3>"
	
	piece = data.Tail(-1);
	ShowMessage(piece.join());	
	// Expected: "<EX3>"
	
	piece = data.Tail(4);
	ShowMessage(piece.join());	
	// Expected: "<EX2> <EX3>"
end;
```

<hr width=”100%”>

```pascal
function Save(FileName: string): boolean;
 ```

> Save the elements from array to file in disk;

*Params:*
>  - FileName(String): Name of file to save. Files existing will be override;

*Return:*
>  - Result(Boolean): Return **TRUE** if sucessfull save.

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];
	
	data.Save('c:\data.txt');	
end;
```

<hr width=”100%”>

```pascal
function Load(FileName: string): boolean;
 ```

> Save the elements from array to file in disk;

*Params:*
>  - FileName(String): Name of file to load. If file name not exist, this function is will be ignored;

*Return:*
>  - Result(Boolean): Return **TRUE** if sucessfull load. Return **FALSE** if file not exist ou can't be load.

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];
	data.Save('c:\data.txt');
	data.Clear();	
	ShowMessage(data.join());	
	// Expected: ""

	data.load('c:\data.txt');
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX2> <EX3>"	
end;
```


<hr width=”100%”>

```pascal
function Clone: T<TYPE>DynArray;
 ```

> Create a full copy of array

*Params:*
>  - None

*Return:*
>  - Result(T<TYPE>DynArray): Copy of array.

*Example:*

``` pascal
procedure Main;
var 
	data,data2: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];

	data2 = data.Clone();
	ShowMessage(data2.join());	
	// Expected: "<EX1> <EX2> <EX3>"
end;
```

<hr width=”100%”>

```pascal
procedure Assign(const Values: T<TYPE>DynArray); overload;
 ```

> Copy all elements in 'Values' to self array;

*Params:*
>  - Values(T<TYPE>DynArray): Source array to be copy;

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data,data2: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];

	data2.Assign(data);
	ShowMessage(data2.join());	
	// Expected: "<EX1> <EX2> <EX3>"
end;
```

<hr width=”100%”>

```pascal
procedure Assign(const Values: string; Separator: array of char); overload;
 ```

> Split a string by any char in 'Separator', then copy all piaces to self array;

*Params:*
>  - Values(string): string to be split;
>  - Separator(array of char): list of separator chars;
*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data.Assign('<EX1>, <EX2>, <EX3>',[',']);
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX2> <EX3>"

	data.Assign('<EX1> <EX2> <EX3>',[' ']);
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX2> <EX3>"
end;
```

<hr width=”100%”>

```pascal
procedure Assign(const Values: string; Separator: T<TYPE>DynArray); overload;
 ```

> Split a string by any string in 'Separator', then copy all piaces to self array;

*Params:*
>  - Values(string): string to be split;
>  - Separator(T<TYPE>DynArray): list of separator string;

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data.Assign('<EX1> \t <EX3> \t <EX2>',['\t']);
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX3> <EX2>"

	data.Assign('<EX1> \t <EX3> \n <EX2>',['\t','\n']);
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX3> <EX2>"
end;
```

<hr width=”100%”>

```pascal
procedure Fill(const Value: <TYPE>; const StartIndex: integer = 0; const
      Endindex: integer = -1);
 ```

> Fill all elements of array with 'Value', started by 'StartIndex'

*Params:*
>  - Value(<TYPE>): Value to fill array;
>  - StartIndex(Integer): Initial index to fill. If 'StartIndex' is above length of array or length of array is zero, this functions will be igorened.

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];
	data.fill(<EX6'>);
	ShowMessage(data.join());	
	// Expected: "<EX6> <EX6> <EX6>"

	data.Clear();
	data.fill(<EX4'>);
	ShowMessage(data.join());	
	// Expected: ""

	data.Count = 4;
	data.fill(<EX5'>);
	ShowMessage(data.join());	
	// Expected: "<EX5> <EX5> <EX5> <EX5>"

	data.fill(<EX4'>,2);
	ShowMessage(data.join());	
	// Expected: "<EX5> <EX5> <EX4> <EX4>"
end;
```


<hr width=”100%”>

```pascal
property Comma: string read GetAsComa write SetAsComma;
 ```

> This property is used to convert strings separed by comma in array and convert back;

*SET(string):*
>  - Convert strings separed by comma in elements array

*GET(string):*
>  - Return a strings separed by comma using elements array

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data.Comma = '<EX1>, <EX3>, <EX2>';
	ShowMessage(data.join());	
	// Expected: "<EX1> <EX3> <EX2>"
	
	data.Add(<EX6'>);
	ShowMessage(data.Comma);	
	// Expected: "<EX1>, <EX3>, <EX2>, <EX6>"
end;
```

<hr width=”100%”>

```pascal
property Items[Index: Integer]: <TYPE> read GetItem write SetItem;
 ```

> This property is used to acesss and manipulate elements of array using [Surround Index](#SURROUND_INDEX).

*SET(<TYPE>):*
>  - Store a <TYPE> in array at position Index;

*GET(<TYPE>):*
>  - Return a <TYPE> stored in array at position Index;

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];
	ShowMessage(data.Items[0]);	
	// Expected: "<EX1>"
	
	ShowMessage(data.Items[-1]);	
	// Expected: "<EX3>"

	ShowMessage(data.Item[4]);	
	// Expected: "<EX2>"

	data.Items[4] = <EX5'>;
	ShowMessage(data.Join());	
	// Expected: "<EX1> <EX5> <EX3>"
end;
```

<hr width=”100%”>

```pascal
property Count: Integer read GetCount write SetCount;
 ```

> This property is used to manipulate de length of array.

*SET(Integer):*
>  - Define a length of array, if need expand, it will be fill with default value <DEF_VAL>;

*GET(Integer):*
>  - Return a length of array;

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];
	ShowMessage(StrToInt(data.Count));	
	// Expected: 3
	
	data.Count = 4;
	data.Items[3] = <EX5'>;
	ShowMessage(data.Join());
	// Expected: "<EX1> <EX2> <EX3> <EX5>"

	data.Count = 2;
	ShowMessage(data.Join());
	// Expected: "<EX1> <EX2>"
end;
```

<hr width=”100%”>

```pascal
procedure ForEach(proc: TProcVar<Integer, <TYPE>>); overload;
 ```

> Apply a procedure ('proc') at all elements in array. 

*Params:*
>  - proc(``TProcVar<Integer, <TYPE>>``): This procedure must be theses params:
> 		- Index(Integer): Index of element in array;
> 		- var Item(<TYPE>): Value of element in array, changes in this variable will be apply in array.

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];
	data.ForEach(Procedure (Index:Integer;var Item:<TYPE>)
				 begin
					<MANUAL_CHANGE>			 
				 	Item = Index.ToString()+':'+Item;
				 end);

	ShowMessage(data.Join());
	// Expected: "0:<EX1> 1:<EX2> 2:<EX3>"		
end;
```

<hr width=”100%”>

```pascal
procedure ForEach(proc: TProcVar<<TYPE>>); overload;
 ```

> Apply a procedure ('proc') at all elements in array. 

*Params:*
>  - proc(``TProcVar<<TYPE>>``): This procedure must be this param:
> 		- var Item(<TYPE>): Value of element in array, changes in this variable will be apply in array.

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];
	data.ForEach(Procedure (var Item:<TYPE>)
				 begin
				   <MANUAL_CHANGE>
				 	Item = 'Fruit '+Item;
				 end);

	ShowMessage(data.Join());
	// Expected: "Fruit <EX1> Fruit <EX2> Fruit <EX3>"		
end;
```

<hr width=”100%”>

```pascal
procedure ForEach(proc: TProc<Integer, <TYPE>>); overload;
 ```

> Apply a procedure ('proc') at all elements in array. 

*Params:*
>  - proc(``TProc<Integer, <TYPE>>``): This procedure must be theses params:
> 		- Index(Integer): Index of element in array;
> 		- Item(<TYPE>): Value of element in array, changes in this variable will **NOT** be apply in array.

*Return:*
>  - None

*Example:*

```pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];
	data.ForEach(Procedure (Index:Integer;Item:<TYPE>)
				 begin
				    <MANUAL_CHANGE>
				 	ShowMessage(format('The Item at Index %d is %s',[Index,Item]));
				 end);
	Expected:
		"The Item at Index 0 is <EX1>"
		"The Item at Index 1 is <EX2>"
		"The Item at Index 2 is <EX3>"
end;
```

<hr width=”100%”>

```pascal
procedure ForEach(proc: TProc<<TYPE>>); overload;
```

> Apply a procedure ('proc') at all elements in array. 

*Params:*
>  - proc(``TProcVar<Integer, <TYPE>>``): This procedure must be this param:
> 		- Item(<TYPE>): Value of element in array, changes in this variable will **NOT** be apply in array.

*Return:*
>  - None

*Example:*

```pascal

procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];
	data.ForEach(Procedure (Item:<TYPE>)
				 begin
				    <MANUAL_CHANGE>
				 	ShowMessage(format('The Item is %s',[Item]));
				 end);
	Expected:
		"The Item is <EX1>"
		"The Item is <EX2>"
		"The Item is <EX3>"
end;

```

<hr width=”100%”>

```pascal
procedure _Of(const Args: array of const);
 ```

> Convert diferents types of elements in <TYPE>, then store in array

*Params:*
>  - Args(array of const): list of elements to be converted to array

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data._Of([True, 10, 'words', 'A','z', 3.1416]);
	<MANUAL_CHANGE>
	ShowMessage(data.Join());
	// Expected: "true 10 words A z 3.1416"
end;
```

<hr width=”100%”>

```pascal
function Every(func: TFunc<<TYPE>, Boolean>): Boolean; overload;
 ```

> Check if all elements in array follow the user 'func'

*Params:*
>  - func(``TFunc<<TYPE>, Boolean>``): This function must be this param:
> 		- Item(<TYPE>): Value of element in array;
> 		- Result(Boolean): The function must return a boolean value for the test, values **FALSE** will terminate a function and fail in test.


*Return:*
>  - Result(Boolean): Return **TRUE** if all elements in array pass in test. Otherwise return **FALSE**.

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];
	data.Every(Function (Item:<TYPE>):boolean
				 begin
				    <MANUAL_CHANGE>
				 	Result:= Item.length > 4
				 end);
	Expected:
		True

	data.Every(Function (Item:<TYPE>):boolean
				 begin
					If (Item.length > 0)then
				 		Result := Item[1] in ['a'..'f'];
				 	else
				 		Result := False;
				 end);
	Expected:
		False
end;
```

<hr width=”100%”>

```pascal
function Every(func: TFunc<<TYPE>, Integer, Boolean>): Boolean; overload;
 ```

> Check if all elements in array follow the user 'func'

*Params:*
>  - func(``TFunc<<TYPE>, Boolean>``): This function must be this param:
> 		- Item(<TYPE>): Value of element in array;
> 		- Index(Integer): Index of element in array;
> 		- Result(Boolean): The function must return a boolean value for the test, values **FALSE** will terminate a function and fail in test.

*Return:*
>  - Result(Boolean): Return **TRUE** if all elements in array pass in test. Otherwise return **FALSE**.

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>];
	data.Every(Function (Index:integer; Item:<TYPE>):boolean
				 begin
					If (Index = 0) then
						<MANUAL_CHANGE>
				 		Result:= Item.length = 5
				 	else:
				 		Result:= Item.length = 6
				 end);
	Expected:
		True

	data.Every(Function (Index:integer; Item:<TYPE>):boolean
				 begin
					If (Index > 1) then
					  Exit(True);

					Result:= Item = <EX1'>;				 	
				 end);
	Expected:
		False
end;
```

<hr width=”100%”>

```pascal
function Filter(func: TFunc<<TYPE>, Boolean>): T<TYPE>DynArray; overload;
 ```

> Create a new array with all elements pass in test of function 'func'.

*Params:*
>  - func(``TFunc<<TYPE>, Boolean>``): This function must be this param:
> 		- Item(<TYPE>): Value of element in array;
> 		- Result(Boolean): The function must return a boolean value for the test, values **FALSE** exclude a item in new array.

*Return:*
>  - Result(T<TYPE>DynArray): Return a new array. If none elements pass in test or 'func' is not assigned, will return a empty array.

*Example:*

``` pascal
procedure Main;
var 
	data,data2: T<TYPE>DynArray;
begin
	data = [<EX5'>,<EX1'>,<EX2'>,<EX3'>];
	data2 = data.Filter(Function (Item:<TYPE>):boolean
				 		begin	
				 			<MANUAL_CHANGE>		 		
				 			If (Item.length > 0)
				 				Result:= Item[1] in ['a'..'g']
				 			else
				 				Result:= False;
				 		end);
	ShowMessage(data2.Join());
	Expected: "<EX5> <EX1> <EX2>"
end;
```

<hr width=”100%”>

```pascal
function Filter(func: TFunc<<TYPE>, Integer, Boolean>): T<TYPE>DynArray; overload;
 ```

> Create a new array with all elements pass in test of function 'func'.

*Params:*
>  - func(``TFunc<<TYPE>, Integer, Boolean>``): This function must be this param:
> 		- Item(<TYPE>): Value of element in array;
> 		- Index(Integer): Index of element in array;
> 		- Result(Boolean): The function must return a boolean value for the test, values **FALSE** exclude a item in new array.

*Return:*
>  - Result(T<TYPE>DynArray): Return a new array. If none elements pass in test or 'func' is not assigned, will return a empty array.

*Example:*

``` pascal
procedure Main;
var 
	data,data2: T<TYPE>DynArray;
begin
	data = [<EX5'>,<EX1'>,<EX2'>,<EX3'>];
	data2 = data.Filter(Function (Index:integer; Item:<TYPE>):boolean
				 		begin
				 			if (Index = 0) then
				 				Exit(True);
				 			Result:= Item.length > 5;
				 		end);
	ShowMessage(data2.Join());
	Expected: "<EX5> <EX3> <EX2>"
end;
```

<hr width=”100%”>

```pascal
function Find(func: TFunc<<TYPE>, Integer, Boolean>): <TYPE>; overload;
 ```

> Return a first ocorrence of element pass in 'func' test.

*Params:*
>  - func(``TFunc<<TYPE>, Integer, Boolean>``): This function must be this param:
> 		- Item(<TYPE>): Value of element in array;
> 		- Index(Integer): Index of element in array;
> 		- Result(Boolean): The function must return a boolean value for the test, value **TRUE** will satisfy and terminate a function, then it will be returned.

*Return:*
>  - Result(<TYPE>): Return the vector element that pass the test. If none elements pass in test or 'func' is not assigned, will return <DEF_VAL>.

*Example:*

``` pascal
procedure Main;
var 
	data T<TYPE>DynArray;
	found:<TYPE>;
begin
	data = [<EX5'>,<EX1'>,<EX2'>,<EX3'>];
	found = data.Find(Function (Index:integer; Item:<TYPE>):boolean
			begin			
				<MANUAL_CHANGE>		
				If (Index > 1) 		
					Result:= (Item = <EX2'>) or (Item = <EX1'>)
				else
					Result:= false;
			end);
	ShowMessage(found);
	Expected: "<EX1>"

	found = data.Find(Function (Item:<TYPE>):boolean
			begin				 			
				Result:= (Item = <EX6'>) or (Item.length = 3);
			end);
	ShowMessage(found);
	Expected: ""
end;
```

<hr width=”100%”>

```pascal
function Find(func: TFunc<<TYPE>,  Boolean>): <TYPE>; overload;
 ```

> Return a first ocorrence of element pass in 'func' test.

*Params:*
>  - func(``TFunc<<TYPE>, Boolean>``): This function must be this param:
> 		- Item(<TYPE>): Value of element in array;
> 		- Result(Boolean): The function must return a boolean value for the test, value **TRUE** will satisfy and terminate a function, then it will be returned.

*Return:*
>  - Result(<TYPE>): Return the vector element that pass the test. If none elements pass in test or 'func' is not assigned, will return <DEF_VAL>.

*Example:*

``` pascal
procedure Main;
var 
	data T<TYPE>DynArray;
	found:<TYPE>;
begin
	data = [<EX5'>,<EX1'>,<EX2'>,<EX3'>];
	found = data.Find(Function (Item:<TYPE>):boolean
			begin		
				<MANUAL_CHANGE>		 			
				Result:= (Item = <EX2'>) or (Item = <EX1'>);
			end);
	ShowMessage(found);
	Expected: "<EX1>"

	found = data.Find(Function (Item:<TYPE>):boolean
			begin				 			
				Result:= (Item = <EX6'>) or (Item.length = 3);
			end);
	ShowMessage(found);
	Expected: ""
end;
```

<hr width=”100%”>

```pascal
procedure Shift(aCount: Integer = 1);
 ```

> Move a first element in array to last position. If length of array is bellow two, this function will be ignored.

*Params:*
>  - aCount(Integer): How many itens will be moved. **Default** = 1. Values bellow one not accepted.

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX5'>,<EX4'>,<EX1'>,<EX2'>];
	
	data.Shift();
	ShowMessage(data.Join());
	// Expected: "<EX4> <EX1> <EX2> <EX5>"

	data.Shift();
	ShowMessage(data.Join());
	// Expected: "<EX1> <EX2> <EX5> <EX4>"

	data.Shift();
	ShowMessage(data.Join());
	// Expected: "<EX2> <EX5> <EX4> <EX1>"

	data = [<EX1'>,<EX2'>,<EX3'>,<EX4'>];

	data.Shift(3);
	ShowMessage(data.Join());
	// Expected: "<EX4>, <EX1>, <EX2>, <EX3>"
end;
```

<hr width=”100%”>

```pascal
procedure Unshift(aCount: Integer = 1);
 ```

> Move a last element in array to first position. If length of array is bellow two, this function will be ignored.

*Params:*
>  - aCount(Integer): How many itens will be moved. **Default** = 1. Values bellow one not accepted.

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data = [<EX1'>,<EX2'>,<EX3'>,<EX4'>];
	
	data.Unshift();
	ShowMessage(data.Join());
	// Expected: "<EX2> <EX3> <EX4> <EX1>"

	data.Unshift();
	ShowMessage(data.Join());
	// Expected: "<EX3> <EX4> <EX1> <EX2>"

	data.Unshift();
	ShowMessage(data.Join());
	// Expected: "<EX4> <EX1> <EX2> <EX3>"

	data = [<EX1'>,<EX2'>,<EX3'>,<EX4'>];

	data.Unshift(3);
	ShowMessage(data.Join());
	// Expected: "<EX4> <EX1> <EX2> <EX3>"
end;
```

<hr width=”100%”>

```pascal
function Union(const Values: T<TYPE>DynArray): T<TYPE>DynArray;
 ```

Create a array with a 'self' and append the elements of 'Values' that not present.

*Params:*
>  - Values(T<TYPE>DynArray): Source vector to compare in new vector.

*Return:*
>  - Result(T<TYPE>DynArray): new array with a union of elements.

*Example:*

``` pascal
procedure Main;
var 
	data,data2,data3: T<TYPE>DynArray;
begin
	data = [<EX4'>,<EX1'>,<EX2'>,<EX3'>,<EX1'>];
	data2 = [<EX6'>,<EX5'>,<EX1'>,<EX2'>];
	
	data3 = data.Union(data2);
	ShowMessage(data3.Join());
	// Expected: "<EX4> <EX1> <EX2> <EX3> <EX6> <EX5>"
end;
```

<hr width=”100%”>

```pascal
function Diference(const Values: T<TYPE>DynArray): T<TYPE>DynArray;
 ```

Create a array with a 'self' and remove the elements common with 'Values'.

*Params:*
>  - Values(T<TYPE>DynArray): Source vector to compare in new vector.

*Return:*
>  - Result(T<TYPE>DynArray): new array with a union of elements.

*Example:*

``` pascal
procedure Main;
var 
	data,data2,data3: T<TYPE>DynArray;
begin
	data = [<EX4'>,<EX1'>,<EX2'>,<EX3'>,<EX1'>];
	data2 = [<EX6'>,<EX5'>,<EX1'>,<EX2'>];
	
	data3 = data.Diference(data2);
	ShowMessage(data3.Join());
	// Expected: "<EX4> <EX3>"
end;
```

<hr width=”100%”>

```pascal
function Interception(const Values: T<TYPE>DynArray): T<TYPE>DynArray;
 ```

Create a array with a 'self' and remove the elements **NOT** common with 'Values'.

*Params:*
>  - Values(T<TYPE>DynArray): Source vector to compare in new vector.

*Return:*
>  - Result(T<TYPE>DynArray): new array with a union of elements.

*Example:*

``` pascal
procedure Main;
var 
	data,data2,data3: T<TYPE>DynArray;
begin
	data = [<EX4'>,<EX1'>,<EX2'>,<EX3'>,<EX1'>];
	data2 = [<EX6'>,<EX5'>,<EX1'>,<EX2'>];
	
	data3 = data.Interception(data2);
	ShowMessage(data3.Join());
	// Expected: "<EX1> <EX2>"
end;
```

<hr width=”100%”>

```pascal
function Exclusion(const Values: T<TYPE>DynArray): T<TYPE>DynArray;
 ```

Create a array with a 'self', append all elements of 'Values', then remove the elements common between two arrays.

*Params:*
>  - Values(T<TYPE>DynArray): Source vector to compare in new vector.

*Return:*
>  - Result(T<TYPE>DynArray): new array with a union of elements.

*Example:*

``` pascal
procedure Main;
var 
	data,data2,data3: T<TYPE>DynArray;
begin
	data = [<EX4'>,<EX1'>,<EX2'>,<EX3'>,<EX1'>];
	data2 = [<EX6'>,<EX5'>,<EX1'>,<EX2'>];
	
	data3 = data.Exclusion(data2);
	ShowMessage(data3.Join());
	// Expected: "<EX4> <EX3> <EX6> <EX5>"
end;
```

<hr width=”100%”>

```pascal
function Same(const Values: T<TYPE>DynArray): Boolean;
 ```

Compare a 'self' array with a 'Values' array.

*Params:*
>  - Values(T<TYPE>DynArray): Source vector to compare.

*Return:*
>  - Result(Boolean): Return **TRUE** if all elements in same position has the same value. Otherwise return **FALSE**.

*Example:*

``` pascal
procedure Main;
var 
	data,data2: T<TYPE>DynArray;
begin
	data  = [<EX1'>,<EX2'>,<EX3'>,<EX2'>];
	data2 = [<EX1'>,<EX2'>,<EX3'>,<EX2'>];
	
	data.Same(data2);
	// Expected: TRUE

	data  = [<EX1'>,<EX2'>,<EX3'>,<EX2'>];
	data2 = [<EX3'>,<EX1'>,<EX2'>,<EX3'>];
	
	data.Same(data2);
	// Expected: FALSE

	data  = [<EX4'>,<EX2'>,<EX3'>,<EX2'>];
	data2 = [<EX3'>,<EX1'>,<EX2'>,<EX3'>];
	
	data.Same(data2);
	// Expected: FALSE
end;
```

<hr width=”100%”>

```pascal
function SameData(const Values: T<TYPE>DynArray): Boolean;
 ```

Compare a 'self' array with a 'Values' array.

*Params:*
>  - Values(T<TYPE>DynArray): Source vector to compare.

*Return:*
>  - Result(Boolean): Return **TRUE** if all elements in any position has the same value. Otherwise return **FALSE**.

*Example:*

``` pascal
procedure Main;
var 
	data,data2: T<TYPE>DynArray;
begin
	data  = [<EX1'>,<EX2'>,<EX3'>,<EX2'>];
	data2 = [<EX1'>,<EX2'>,<EX3'>,<EX2'>];
	
	data.SameData(data2);
	// Expected: TRUE

	data  = [<EX1'>,<EX2'>,<EX3'>,<EX2'>];
	data2 = [<EX3'>,<EX1'>,<EX2'>,<EX3'>];
	
	data.SameData(data2);
	// Expected: TRUE

	data  = [<EX4'>,<EX2'>,<EX3'>,<EX2'>];
	data2 = [<EX3'>,<EX1'>,<EX2'>,<EX3'>];
	
	data.SameData(data2);
	// Expected: FALSE
end;
```
<hr width=”100%”>

```pascal
function RemoveDuplicate: Integer;
 ```

Scan and remove all duplicate items.

*Params:*
>  - None

*Return:*
>  - Result(Integer): Return a number of duplicates removed.

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
	duplicateCount : Integer;
begin
	data  = [<EX1'>,<EX2'>,<EX3'>,<EX2'>,<EX3'>];
	
	duplicateCount = data.RemoveDuplicate();
	ShowMessage(data.Join())
	// Expected: "<EX1> <EX2> <EX3>"
	//	 		 duplicateCount = 2
end;
```
<hr width=”100%”>

```pascal
procedure Trim;
 ```

For all Items remove white spaces in torn of item, and if it has only spaces or is empty, then will be removed.
- For default white spaces are treated as part of item, in functions like **Assign, Comma, Join etc**

*Params:*
>  - None

*Return:*
>  - Result(Integer): Return a number of duplicates removed.

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
	duplicateCount : Integer;
begin
	data  = ['  <EX1>  ', '  ', '  <EX3>', '<EX2>  ', '',''];
	
	data.Trim();
	ShowMessage(data.Join())
	// Expected: "<EX1> <EX3> <EX2>"
end;
```

<hr width=”100%”>


```pascal
function First:<TYPE>;
 ```
Return the value of fist element in array or <DEF_VAL> if not have one.

*Params:*
>  - None

*Return:*
>  - Result(<TYPE>): Return the fist element.

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data  = [<EX1'>,<EX2'>,<EX3'>;
	
	ShowMessage(data.Fist);
	// Expected: "<EX1>"

	data.Clear();

	ShowMessage(data.Fist);
	// Expected: <DEF_VAL>	
end;
```

<hr width=”100%”>

```pascal
function Last:<TYPE>;
 ```
Return the value of last element in array or <DEF_VAL> if not have one.

*Params:*
>  - None

*Return:*
>  - Result(string): Return the last element.

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data  = [<EX1'>,<EX2'>,<EX3'>;
	
	ShowMessage(data.Last);
	// Expected: "<EX3>"

	data.Clear();

	ShowMessage(data.Last);
	// Expected: <DEF_VAL>	
end;
```

<hr width=”100%”>

```pascal
function PushFront:<TYPE>;
 ```
Return the value of first element in array, then remove it from array. if not have one, return <DEF_VAL>.

*Params:*
>  - None

*Return:*
>  - Result(<TYPE>): Return the first element.

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data  = [<EX1'>,<EX2'>,<EX3'>;
	
	ShowMessage(data.PushFront);
	// Expected: "<EX1>"

	ShowMessage(data.PushFront);
	// Expected: "<EX2>"

	ShowMessage(data.PushFront);
	// Expected: "<EX3>"

	ShowMessage(data.PushFront);
	// Expected: <DEF_VAL>
	
end;
```

<hr width=”100%”>

```pascal
function PushBack:<TYPE>;
 ```
Return the value of last element in array, then remove it from array. if not have one, return <DEF_VAL>.

*Params:*
>  - None

*Return:*
>  - Result(<TYPE>): Return the last element.

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data  = [<EX1'>,<EX2'>,<EX3'>;
	
	ShowMessage(data.PushBack);
	// Expected: "<EX3>"

	ShowMessage(data.PushBack);
	// Expected: "<EX2>"

	ShowMessage(data.PushBack);
	// Expected: "<EX1>"

	ShowMessage(data.PushBack);
	// Expected: <DEF_VAL>	
end;
```

<hr width=”100%”>

```pascal
function Has(const value: <TYPE>): Boolean;
 ```
Return **TRUE** if array has one ou more items with value 'value'.

*Params:*
>  - value(<TYPE>): <TYPE> value to compare with items.

*Return:*
>  - Result(Boolean): Return **TRUE** if has 'value', otherwise return **FALSE**.

*Example:*

``` pascal
procedure Main;
var 
	data: T<TYPE>DynArray;
begin
	data  = [<EX1'>,<EX2'>,<EX3'>];
	
	If (data.Has(<EX2'>)) then
		ShowMessage("This array has <EX2>");
	else
		ShowMessage("This array hasn't <EX2>");
	// Expected: "This array has <EX2>"

	If (data.Has(<EX6'>)) then
		ShowMessage("This array has <EX6>");
	else
		ShowMessage("This array hasn't <EX6>");
	// Expected: "This array hasn't <EX6>"
end;
```
