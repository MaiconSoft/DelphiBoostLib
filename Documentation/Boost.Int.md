## ``TArray <Integer>`` 
**Aka:** Array of Integer, TIntegerDynArray

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
	data: TIntegerDynArray;
begin
	data = [1,2,3];

	ShowMessage(data.join());
	// Expected: "1 2 3"

	ShowMessage(data.join(', '));
	// Expected: "1, 2, 3"

	ShowMessage(data.join(' - '));
	// Expected: "1 - 2 - 3"
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
	data: TIntegerDynArray;
begin
	data = [2,3,1];

	data.sort();

	ShowMessage(data.join());
	// Expected: "1 2 3"
end;
```
<hr width=”100%”>

```pascal
 procedure Sort(const Comparison: TComparison<Integer>); overload;
 ```

> Sorts all elements of the array in using the 'Comparison' function, the order is custom.

*Params:*
> - ``Comparison(TComparison<Integer>)``: Custom function to compare elements.

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data = [2,3,1];

	data.sort();

	ShowMessage(data.join());
	// Expected: "1 2 3"
end;
```

<hr width=”100%”>

```pascal
 procedure Sort(const Comparison: TComparison<Integer>; Index, Count: integer);
      overload;
 ```

> Same of custom Sort, but with limits.

*Params:*
> - ``Comparison(TComparison<Integer>)``: Custom function to compare elements;
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
	data: TIntegerDynArray;
begin
	data = [1,2,3];

	data.rsort();

	ShowMessage(data.join());
	// Expected: "3 2 1"
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
	data: TIntegerDynArray;
begin
	data = [1,3,2];

	data.Shuffle();

	ShowMessage(data.join());
	// Expected: random order every time
	// Example: "2 3 1"
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
	data: TIntegerDynArray;
begin
	data = [1,2,3];

	data.Reverse();

	ShowMessage(data.join());
	// Expected: "3 2 1"
end;
```

<hr width=”100%”>

```pascal
 function IndexOf(const Value: Integer; StartPos: Integer = 0): Integer;
 ```

> Get index of a element in array.

*Params:*
> - Value(Integer): Search element;
> - StartPos(Integer): Position to start search. **Default** 0.

*Return:*
>  - Result(Integer):
>  	- If item is found: return index of value in array (zero based);
>  	- Else: return -1.

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
	index: Integer;
begin
	data = [1,2,1 3];

	index = data.IndexOf(1);
	// Expected: 0

	index = data.IndexOf(2);
	// Expected: 1

	index = data.IndexOf(4);
	// Expected: -1	

	index = data.IndexOf(1,1);
	// Expected: 2

	index = data.IndexOf(2,2);
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
	data: TIntegerDynArray;
	index: Integer;
begin
	data = [1,2,1, 3];

	index = data.LastIndexOf(1);
	// Expected: 2

	index = data.LastIndexOf(2);
	// Expected: 1

	index = data.LastIndexOf(4);
	// Expected: -1	

	index = data.LastIndexOf(1,1);
	// Expected: 0

	index = data.LastIndexOf(3,2);
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
	data: TIntegerDynArray;
begin
	data = [1,2,3];
	data.Delete(0);
	ShowMessage(data.join());	
	// Expected: "3 2"

	data = [1,2,3];
	data.Delete(-1);
	ShowMessage(data.join());	
	// Expected: "1 3"

	data = [1,2,3];
	data.Delete(-2);
	ShowMessage(data.join());	
	// Expected: "1 2"

	data = [1,2,3];
	data.Delete(-3);
	ShowMessage(data.join());	
	// Expected: "3 2"
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
	data: TIntegerDynArray;
begin	
	data = [1,2,3];
	data.Delete(0,0);
	ShowMessage(data.join());	
	// Expected: "1 2 3"

	data = [1,2,3];
	data.Delete(0,2);
	ShowMessage(data.join());	
	// Expected: "3"

	data = [1,2,3];
	data.Delete(-1,2);
	ShowMessage(data.join());	
	// Expected: "1 2"

	data = [1,2,3];
	data.Delete(1,5);
	ShowMessage(data.join());	
	// Expected: "1"
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
	data: TIntegerDynArray;
begin
	data = [1,2,3];	
	data.Insert(0,4);
	ShowMessage(data.join());	
	// Expected: "4 1 2 3"
	
	data = [1,2,3];
	data.Insert(-1,4);
	ShowMessage(data.join());	
	// Expected: "1 2 4 3"

	data = [1,2,3];
	data.Insert(4,4);
	ShowMessage(data.join());	
	// Expected: "1 4 2 3"
end;
```

<hr width=”100%”>

```pascal
procedure Insert(Index: Integer; Values: TIntegerDynArray); overload;
 ```

> Inset a range of value into array at position index; 

*Params:*
> - Index(Integer): Position to insert in array. See [Surround Index](#SURROUND_INDEX).
> - Values(TIntegerDynArray): Values to insert.

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data = [1,2,3];	
	data.Insert(0,[4,5,6]);
	ShowMessage(data.join());	
	// Expected: "4 5 6 1 2 3"

	data = [1,2,3];
	data.Insert(-1,[4,5,6]);
	ShowMessage(data.join());	
	// Expected: "1 2 4 5 6 3"
	
	data = [1,2,3];
	data.Insert(4,[4,5,6]);
	ShowMessage(data.join());	
	// Expected: "1 4 5 6 2 3"
end;
```

<hr width=”100%”>

```pascal
procedure Add(Value: Integer); overload;
 ```

> Append value in array; 

*Params:*
> - Value(Integer): Value to append

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data = [1,2,3];
	
	data.Add(4);
	ShowMessage(data.join());	
	// Expected: "1 2 3 4"
end;
```

<hr width=”100%”>

```pascal
procedure Add(Values: TIntegerDynArray); overload;
 ```

> Append a range of values in array; 

*Params:*
> - Values(TIntegerDynArray): Range of values to append

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data = [1,2,3];
	
	data.Add([4,5,6]);
	ShowMessage(data.join());	
	// Expected: "1 2 3 4 5 6"
end;
```

<hr width=”100%”>

```pascal
function CountItems(Item: Integer): Integer;
```

> Count how many times the item exist in array; 

*Params:*
> - Item(Integer): Item for search for.

*Return:*
>  - Result(Integer): Number of Itens found (0 if not found).

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
	count:Integer;
begin
	data = [1,2,1,3,1,3];
	
	count:= data.CountItems(1);	
	// Expected: 3

	count:= data.CountItems(2);	
	// Expected: 1

	count:= data.CountItems(3);	
	// Expected: 2

	count:= data.CountItems(6);	
	// Expected: 0
end;
```

<hr width=”100%”>

```pascal
procedure Remove(Item: Integer); overload;
 ```

> Removes the first occurrence of the Item in array by value.  

*Params:*
> - Item(Integer): Item for search for.

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data = [1,2,1,3];
	
	data.Remove(2);
	ShowMessage(data.join());	
	// Expected: "1 1 3"

	data = [1,2,1,3];
	data.Remove(1);
	ShowMessage(data.join());	
	// Expected: "2 1 3"
	
	data = [1,2,1,3];
	data.Remove(5);
	ShowMessage(data.join());	
	// Expected: "1 2 1 3"

end;
```

<hr width=”100%”>

```pascal
procedure Remove(Item: Integer; count: integer); overload;
 ```

> Removes the 'Count' occurrences of the Item in array.  

*Params:*
> - Item(Integer): Item for search for.
> - Count(Integer): Number of repetitions of item to be removed.

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data = [1,2,1,3];
	
	data.Remove(2,0);
	ShowMessage(data.join());	
	// Expected: "1 2 1 3"

	data = [1,2,1,3];
	data.Remove(1,2);
	ShowMessage(data.join());	
	// Expected: "2 3"
	
	data = [1,2,1,3];
	data.Remove(5,3);
	ShowMessage(data.join());	
	// Expected: "1 2 1 3"

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
	data: TIntegerDynArray;
begin
	data = [1,2,3];
	
	data.Clear();
	ShowMessage(data.join());	
	// Expected: ""
	ShowMessage(IntToStr(data.length);	
	// Expected: 0
end;
```

<hr width=”100%”>

```pascal
function Slice(StartPos, EndPos: integer): TIntegerDynArray; overload;
 ```

> Extract a piece of array between 'StartPos' and 'EndPos' (incluse)

*Params:*
>  - StartPos(Integer): Initial position to cut;
>  - EndPos(Integer): Final position to cut;

*Return:*
>  - Result(TIntegerDynArray): Array extracted;

*Example:*

``` pascal
procedure Main;
var 
	data,piece: TIntegerDynArray;
begin
	data = [1,2,3];
	
	piece = data.slice(0,1);
	ShowMessage(piece.join());	
	// Expected: "1 2"
	
	piece = data.slice(-1,1);
	ShowMessage(piece.join());	
	// Expected: "3 1"
	
	piece = data.slice(4,1);
	ShowMessage(piece.join());	
	// Expected: "2"
end;
```

<hr width=”100%”>

```pascal
function Slice(StartPos: integer): TIntegerDynArray; overload;
 ```

> Extract a piece of array between 'StartPos' and length of array

*Params:*
>  - StartPos(Integer): Initial position to cut;

*Return:*
>  - Result(TIntegerDynArray): Array extracted;

*Example:*

``` pascal
procedure Main;
var 
	data,piece: TIntegerDynArray;
begin
	data = [1,2,3];
	
	piece = data.slice(0);
	ShowMessage(piece.join());	
	// Expected: "1 2 3"
	
	piece = data.slice(-1);
	ShowMessage(piece.join());	
	// Expected: "3"
	
	piece = data.slice(4);
	ShowMessage(piece.join());	
	// Expected: "2"
end;
```

<hr width=”100%”>

```pascal
function Head(EndPos: integer): TIntegerDynArray;
 ```

> Extract a piece of array between position 0 and 'EndPos';

*Params:*
>  - EndPos(Integer): Final position to cut;

*Return:*
>  - Result(TIntegerDynArray): Array extracted;

*Example:*

``` pascal
procedure Main;
var 
	data,piece: TIntegerDynArray;
begin
	data = [1,2,3];
	
	piece = data.Head(0);
	ShowMessage(piece.join());	
	// Expected: "1"
	
	piece = data.Head(-1);
	ShowMessage(piece.join());	
	// Expected: "1 2 3"
	
	piece = data.Head(4);
	ShowMessage(piece.join());	
	// Expected: "1 2"
end;
```

<hr width=”100%”>

```pascal
function Tail(StartPos: integer): TIntegerDynArray;
 ```

> Extract a piece of array between position 'StartPos' and length of array;

*Params:*
>  - StartPos(Integer): Initial position to cut;

*Return:*
>  - Result(TIntegerDynArray): Array extracted;

*Example:*

``` pascal
procedure Main;
var 
	data,piece: TIntegerDynArray;
begin
	data = [1,2,3];
	
	piece = data.Tail(0);
	ShowMessage(piece.join());	
	// Expected: "1 2 3"
	
	piece = data.Tail(-1);
	ShowMessage(piece.join());	
	// Expected: "3"
	
	piece = data.Tail(4);
	ShowMessage(piece.join());	
	// Expected: "2 3"
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
	data: TIntegerDynArray;
begin
	data = [1,2,3];
	
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
	data: TIntegerDynArray;
begin
	data = [1,2,3];
	data.Save('c:\data.txt');
	data.Clear();	
	ShowMessage(data.join());	
	// Expected: ""

	data.load('c:\data.txt');
	ShowMessage(data.join());	
	// Expected: "1 2 3"	
end;
```


<hr width=”100%”>

```pascal
function Clone: TIntegerDynArray;
 ```

> Create a full copy of array

*Params:*
>  - None

*Return:*
>  - Result(TIntegerDynArray): Copy of array.

*Example:*

``` pascal
procedure Main;
var 
	data,data2: TIntegerDynArray;
begin
	data = [1,2,3];

	data2 = data.Clone();
	ShowMessage(data2.join());	
	// Expected: "1 2 3"
end;
```

<hr width=”100%”>

```pascal
procedure Assign(const Values: TIntegerDynArray); overload;
 ```

> Copy all elements in 'Values' to self array;

*Params:*
>  - Values(TIntegerDynArray): Source array to be copy;

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data,data2: TIntegerDynArray;
begin
	data = [1,2,3];

	data2.Assign(data);
	ShowMessage(data2.join());	
	// Expected: "1 2 3"
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
	data: TIntegerDynArray;
begin
	data.Assign('1, 2, 3',[',']);
	ShowMessage(data.join());	
	// Expected: "1 2 3"

	data.Assign('1 2 3',[' ']);
	ShowMessage(data.join());	
	// Expected: "1 2 3"
end;
```

<hr width=”100%”>

```pascal
procedure Assign(const Values: string; Separator: TIntegerDynArray); overload;
 ```

> Split a string by any string in 'Separator', then copy all piaces to self array;

*Params:*
>  - Values(string): string to be split;
>  - Separator(TIntegerDynArray): list of separator string;

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data.Assign('1 \t 3 \t 2',['\t']);
	ShowMessage(data.join());	
	// Expected: "1 3 2"

	data.Assign('1 \t 3 \n 2',['\t','\n']);
	ShowMessage(data.join());	
	// Expected: "1 3 2"
end;
```

<hr width=”100%”>

```pascal
procedure Fill(const Value: Integer; const StartIndex: integer = 0; const
      Endindex: integer = -1);
 ```

> Fill all elements of array with 'Value', started by 'StartIndex'

*Params:*
>  - Value(Integer): Value to fill array;
>  - StartIndex(Integer): Initial index to fill. If 'StartIndex' is above length of array or length of array is zero, this functions will be igorened.

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data = [1,2,3];
	data.fill(6);
	ShowMessage(data.join());	
	// Expected: "6 6 6"

	data.Clear();
	data.fill(4);
	ShowMessage(data.join());	
	// Expected: ""

	data.Count = 4;
	data.fill(5);
	ShowMessage(data.join());	
	// Expected: "5 5 5 5"

	data.fill(4,2);
	ShowMessage(data.join());	
	// Expected: "5 5 4 4"
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
	data: TIntegerDynArray;
begin
	data.Comma = '1, 3, 2';
	ShowMessage(data.join());	
	// Expected: "1 3 2"
	
	data.Add(6);
	ShowMessage(data.Comma);	
	// Expected: "1, 3, 2, 6"
end;
```

<hr width=”100%”>

```pascal
property Items[Index: Integer]: Integer read GetItem write SetItem;
 ```

> This property is used to acesss and manipulate elements of array using [Surround Index](#SURROUND_INDEX).

*SET(Integer):*
>  - Store a Integer in array at position Index;

*GET(Integer):*
>  - Return a Integer stored in array at position Index;

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data = [1,2,3];
	ShowMessage(data.Items[0]);	
	// Expected: "1"
	
	ShowMessage(data.Items[-1]);	
	// Expected: "3"

	ShowMessage(data.Item[4]);	
	// Expected: "2"

	data.Items[4] = 5;
	ShowMessage(data.Join());	
	// Expected: "1 5 3"
end;
```

<hr width=”100%”>

```pascal
property Count: Integer read GetCount write SetCount;
 ```

> This property is used to manipulate de length of array.

*SET(Integer):*
>  - Define a length of array, if need expand, it will be fill with default value 0;

*GET(Integer):*
>  - Return a length of array;

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data = [1,2,3];
	ShowMessage(StrToInt(data.Count));	
	// Expected: 3
	
	data.Count = 4;
	data.Items[3] = 5;
	ShowMessage(data.Join());
	// Expected: "1 2 3 5"

	data.Count = 2;
	ShowMessage(data.Join());
	// Expected: "1 2"
end;
```

<hr width=”100%”>

```pascal
procedure ForEach(proc: TProcVar<Integer, Integer>); overload;
 ```

> Apply a procedure ('proc') at all elements in array. 

*Params:*
>  - proc(``TProcVar<Integer, Integer>``): This procedure must be theses params:
> 		- Index(Integer): Index of element in array;
> 		- var Item(Integer): Value of element in array, changes in this variable will be apply in array.

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data = [1,2,3];
	data.ForEach(Procedure (Index:Integer;var Item:Integer)
				 begin						 				
				 	Item = Index;
				 end);

	ShowMessage(data.Join());
	// Expected: "0 1 2"		
end;
```

<hr width=”100%”>

```pascal
procedure ForEach(proc: TProcVar<Integer>); overload;
 ```

> Apply a procedure ('proc') at all elements in array. 

*Params:*
>  - proc(``TProcVar<Integer>``): This procedure must be this param:
> 		- var Item(Integer): Value of element in array, changes in this variable will be apply in array.

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data = [1,2,3];
	data.ForEach(Procedure (var Item:Integer)
				 begin				   
				 	Item = Item*Item;
				 end);

	ShowMessage(data.Join());
	// Expected: "1 4 9"		
end;
```

<hr width=”100%”>

```pascal
procedure ForEach(proc: TProc<Integer, Integer>); overload;
 ```

> Apply a procedure ('proc') at all elements in array. 

*Params:*
>  - proc(``TProc<Integer, Integer>``): This procedure must be theses params:
> 		- Index(Integer): Index of element in array;
> 		- Item(Integer): Value of element in array, changes in this variable will **NOT** be apply in array.

*Return:*
>  - None

*Example:*

```pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data = [1,2,3];
	data.ForEach(Procedure (Index:Integer;Item:Integer)
				 begin				    
				 	ShowMessage(format('The Item at Index %d is %d',[Index,Item]));
				 end);
	Expected:
		"The Item at Index 0 is 1"
		"The Item at Index 1 is 2"
		"The Item at Index 2 is 3"
end;
```

<hr width=”100%”>

```pascal
procedure ForEach(proc: TProc<Integer>); overload;
```

> Apply a procedure ('proc') at all elements in array. 

*Params:*
>  - proc(``TProcVar<Integer, Integer>``): This procedure must be this param:
> 		- Item(Integer): Value of element in array, changes in this variable will **NOT** be apply in array.

*Return:*
>  - None

*Example:*

```pascal

procedure Main;
var 
	data: TIntegerDynArray;
begin
	data = [1,2,3];
	data.ForEach(Procedure (Item:Integer)
				 begin				    
				 	ShowMessage(format('The Item is %d',[Item]));
				 end);
	Expected:
		"The Item is 1"
		"The Item is 2"
		"The Item is 3"
end;

```

<hr width=”100%”>

```pascal
procedure _Of(const Args: array of const);
 ```

> Convert diferents types of elements in Integer, then store in array

*Params:*
>  - Args(array of const): list of elements to be converted to array

*Return:*
>  - None

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data._Of([True, 10, 'words', '9','3.6', 3.1416]);	
	ShowMessage(data.Join());
	// Expected: "1 10 0 9 4 3"
	// - 'words': was coverted in default value (0)
	// - '9': was coverted in integer 9
	// - '2.6': was converted in float, then rounded to integer (4)
end;
```

<hr width=”100%”>

```pascal
function Every(func: TFunc<Integer, Boolean>): Boolean; overload;
 ```

> Check if all elements in array follow the user 'func'

*Params:*
>  - func(``TFunc<Integer, Boolean>``): This function must be this param:
> 		- Item(Integer): Value of element in array;
> 		- Result(Boolean): The function must return a boolean value for the test, values **FALSE** will terminate a function and fail in test.


*Return:*
>  - Result(Boolean): Return **TRUE** if all elements in array pass in test. Otherwise return **FALSE**.

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data = [1,2,3];
	data.Every(Function (Item:Integer):boolean
				 begin				    
				 	Result:= Item  < 4
				 end);
	Expected:
		True

	data.Every(Function (Item:Integer):boolean
				 begin
					Result:= Odd(Item);
				 end);
	Expected:
		False
end;
```

<hr width=”100%”>

```pascal
function Every(func: TFunc<Integer, Integer, Boolean>): Boolean; overload;
 ```

> Check if all elements in array follow the user 'func'

*Params:*
>  - func(``TFunc<Integer, Boolean>``): This function must be this param:
> 		- Item(Integer): Value of element in array;
> 		- Index(Integer): Index of element in array;
> 		- Result(Boolean): The function must return a boolean value for the test, values **FALSE** will terminate a function and fail in test.

*Return:*
>  - Result(Boolean): Return **TRUE** if all elements in array pass in test. Otherwise return **FALSE**.

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data = [2,7,9,20];
	// Verify all items are even and odd respectively
	data.Every(Function (Index:integer; Item:Integer):boolean
				 begin
					If Odd(Index) then						
				 		Result:= Odd(Item)
				 	else:
				 		Result:= not Odd(Item);
				 end);
	Expected:
		True
	
	// Verify all items are odd and even respectively
	data.Every(Function (Index:integer; Item:Integer):boolean
				 begin
					If Odd(Index) then						
				 		Result:= not Odd(Item)
				 	else:
				 		Result:= Odd(Item);			 	
				 end);
	Expected:
		False
end;
```

<hr width=”100%”>

```pascal
function Filter(func: TFunc<Integer, Boolean>): TIntegerDynArray; overload;
 ```

> Create a new array with all elements pass in test of function 'func'.

*Params:*
>  - func(``TFunc<Integer, Boolean>``): This function must be this param:
> 		- Item(Integer): Value of element in array;
> 		- Result(Boolean): The function must return a boolean value for the test, values **FALSE** exclude a item in new array.

*Return:*
>  - Result(TIntegerDynArray): Return a new array. If none elements pass in test or 'func' is not assigned, will return a empty array.

*Example:*

``` pascal
procedure Main;
var 
	data,data2: TIntegerDynArray;
begin
	data = [5,1,2,3];
	data2 = data.Filter(Function (Item:Integer):boolean
				 		begin					 				 					 		
				 			Result:= Odd(Item);
				 		end);
	ShowMessage(data2.Join());
	Expected: "5 1 3"
end;
```

<hr width=”100%”>

```pascal
function Filter(func: TFunc<Integer, Integer, Boolean>): TIntegerDynArray; overload;
 ```

> Create a new array with all elements pass in test of function 'func'.

*Params:*
>  - func(``TFunc<Integer, Integer, Boolean>``): This function must be this param:
> 		- Item(Integer): Value of element in array;
> 		- Index(Integer): Index of element in array;
> 		- Result(Boolean): The function must return a boolean value for the test, values **FALSE** exclude a item in new array.

*Return:*
>  - Result(TIntegerDynArray): Return a new array. If none elements pass in test or 'func' is not assigned, will return a empty array.

*Example:*

``` pascal
procedure Main;
var 
	data,data2: TIntegerDynArray;
begin
	data = [-5,1,2,5,8];
	data2 = data.Filter(Function (Index:integer; Item:Integer):boolean
				 		begin
				 			if (Index = 0) then
				 				Exit(True);
				 			Result:= Item > 2;
				 		end);
	ShowMessage(data2.Join());
	Expected: "-5 5 8"
end;
```

<hr width=”100%”>

```pascal
function Find(func: TFunc<Integer, Integer, Boolean>): Integer; overload;
 ```

> Return a first ocorrence of element pass in 'func' test.

*Params:*
>  - func(``TFunc<Integer, Integer, Boolean>``): This function must be this param:
> 		- Item(Integer): Value of element in array;
> 		- Index(Integer): Index of element in array;
> 		- Result(Boolean): The function must return a boolean value for the test, value **TRUE** will satisfy and terminate a function, then it will be returned.

*Return:*
>  - Result(Integer): Return the vector element that pass the test. If none elements pass in test or 'func' is not assigned, will return 0.

*Example:*

``` pascal
procedure Main;
var 
	data TIntegerDynArray;
	found:Integer;
begin
	data = [5,9,2,3];
	found = data.Find(Function (Index:integer; Item:Integer):boolean
			begin				
				If (Index > 1) 		
					Result:= (Item = 2) or (Item = 9)
				else
					Result:= false;
			end);
	ShowMessage(found);
	Expected: 9

	found = data.Find(Function (Item:Integer):boolean
			begin				 			
				Result:= (Item = 6) or (Item < 0);
			end);
	ShowMessage(found);
	Expected: 0 // default value
end;
```

<hr width=”100%”>

```pascal
function Find(func: TFunc<Integer,  Boolean>): Integer; overload;
 ```

> Return a first ocorrence of element pass in 'func' test.

*Params:*
>  - func(``TFunc<Integer, Boolean>``): This function must be this param:
> 		- Item(Integer): Value of element in array;
> 		- Result(Boolean): The function must return a boolean value for the test, value **TRUE** will satisfy and terminate a function, then it will be returned.

*Return:*
>  - Result(Integer): Return the vector element that pass the test. If none elements pass in test or 'func' is not assigned, will return 0.

*Example:*

``` pascal
procedure Main;
var 
	data TIntegerDynArray;
	found:Integer;
begin
	data = [5,8,2,3];
	found = data.Find(Function (Item:Integer):boolean
			begin								
				Result:= (Item = 2) or (Item = 3);
			end);
	ShowMessage(found);
	Expected: "2"

	found = data.Find(Function (Item:Integer):boolean
			begin				 			
				Result:= (Item = 9) or (Item = 1);
			end);
	ShowMessage(found);
	Expected: 0 default value
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
	data: TIntegerDynArray;
begin
	data = [5,4,1,2];
	
	data.Shift();
	ShowMessage(data.Join());
	// Expected: "4 1 2 5"

	data.Shift();
	ShowMessage(data.Join());
	// Expected: "1 2 5 4"

	data.Shift();
	ShowMessage(data.Join());
	// Expected: "2 5 4 1"

	data = [1,2,3,4];

	data.Shift(3);
	ShowMessage(data.Join());
	// Expected: "4, 1, 2, 3"
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
	data: TIntegerDynArray;
begin
	data = [1,2,3,4];
	
	data.Unshift();
	ShowMessage(data.Join());
	// Expected: "2 3 4 1"

	data.Unshift();
	ShowMessage(data.Join());
	// Expected: "3 4 1 2"

	data.Unshift();
	ShowMessage(data.Join());
	// Expected: "4 1 2 3"

	data = [1,2,3,4];

	data.Unshift(3);
	ShowMessage(data.Join());
	// Expected: "4 1 2 3"
end;
```

<hr width=”100%”>

```pascal
function Union(const Values: TIntegerDynArray): TIntegerDynArray;
 ```

Create a array with a 'self' and append the elements of 'Values' that not present.

*Params:*
>  - Values(TIntegerDynArray): Source vector to compare in new vector.

*Return:*
>  - Result(TIntegerDynArray): new array with a union of elements.

*Example:*

``` pascal
procedure Main;
var 
	data,data2,data3: TIntegerDynArray;
begin
	data = [4,1,2,3,1];
	data2 = [6,5,1,2];
	
	data3 = data.Union(data2);
	ShowMessage(data3.Join());
	// Expected: "4 1 2 3 6 5"
end;
```

<hr width=”100%”>

```pascal
function Diference(const Values: TIntegerDynArray): TIntegerDynArray;
 ```

Create a array with a 'self' and remove the elements common with 'Values'.

*Params:*
>  - Values(TIntegerDynArray): Source vector to compare in new vector.

*Return:*
>  - Result(TIntegerDynArray): new array with a union of elements.

*Example:*

``` pascal
procedure Main;
var 
	data,data2,data3: TIntegerDynArray;
begin
	data = [4,1,2,3,1];
	data2 = [6,5,1,2];
	
	data3 = data.Diference(data2);
	ShowMessage(data3.Join());
	// Expected: "4 3"
end;
```

<hr width=”100%”>

```pascal
function Interception(const Values: TIntegerDynArray): TIntegerDynArray;
 ```

Create a array with a 'self' and remove the elements **NOT** common with 'Values'.

*Params:*
>  - Values(TIntegerDynArray): Source vector to compare in new vector.

*Return:*
>  - Result(TIntegerDynArray): new array with a union of elements.

*Example:*

``` pascal
procedure Main;
var 
	data,data2,data3: TIntegerDynArray;
begin
	data = [4,1,2,3,1];
	data2 = [6,5,1,2];
	
	data3 = data.Interception(data2);
	ShowMessage(data3.Join());
	// Expected: "1 2"
end;
```

<hr width=”100%”>

```pascal
function Exclusion(const Values: TIntegerDynArray): TIntegerDynArray;
 ```

Create a array with a 'self', append all elements of 'Values', then remove the elements common between two arrays.

*Params:*
>  - Values(TIntegerDynArray): Source vector to compare in new vector.

*Return:*
>  - Result(TIntegerDynArray): new array with a union of elements.

*Example:*

``` pascal
procedure Main;
var 
	data,data2,data3: TIntegerDynArray;
begin
	data = [4,1,2,3,1];
	data2 = [6,5,1,2];
	
	data3 = data.Exclusion(data2);
	ShowMessage(data3.Join());
	// Expected: "4 3 6 5"
end;
```

<hr width=”100%”>

```pascal
function Same(const Values: TIntegerDynArray): Boolean;
 ```

Compare a 'self' array with a 'Values' array.

*Params:*
>  - Values(TIntegerDynArray): Source vector to compare.

*Return:*
>  - Result(Boolean): Return **TRUE** if all elements in same position has the same value. Otherwise return **FALSE**.

*Example:*

``` pascal
procedure Main;
var 
	data,data2: TIntegerDynArray;
begin
	data  = [1,2,3,2];
	data2 = [1,2,3,2];
	
	data.Same(data2);
	// Expected: TRUE

	data  = [1,2,3,2];
	data2 = [3,1,2,3];
	
	data.Same(data2);
	// Expected: FALSE

	data  = [4,2,3,2];
	data2 = [3,1,2,3];
	
	data.Same(data2);
	// Expected: FALSE
end;
```

<hr width=”100%”>

```pascal
function SameData(const Values: TIntegerDynArray): Boolean;
 ```

Compare a 'self' array with a 'Values' array.

*Params:*
>  - Values(TIntegerDynArray): Source vector to compare.

*Return:*
>  - Result(Boolean): Return **TRUE** if all elements in any position has the same value. Otherwise return **FALSE**.

*Example:*

``` pascal
procedure Main;
var 
	data,data2: TIntegerDynArray;
begin
	data  = [1,2,3,2];
	data2 = [1,2,3,2];
	
	data.SameData(data2);
	// Expected: TRUE

	data  = [1,2,3,2];
	data2 = [3,1,2,3];
	
	data.SameData(data2);
	// Expected: TRUE

	data  = [4,2,3,2];
	data2 = [3,1,2,3];
	
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
	data: TIntegerDynArray;
	duplicateCount : Integer;
begin
	data  = [1,2,3,2,3];
	
	duplicateCount = data.RemoveDuplicate();
	ShowMessage(data.Join())
	// Expected: "1 2 3"
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
	data: TIntegerDynArray;
	duplicateCount : Integer;
begin
	data  = ['  1  ', '  ', '  3', '2  ', '',''];
	
	data.Trim();
	ShowMessage(data.Join())
	// Expected: "1 3 2"
end;
```

<hr width=”100%”>


```pascal
function First:Integer;
 ```
Return the value of fist element in array or 0 if not have one.

*Params:*
>  - None

*Return:*
>  - Result(Integer): Return the fist element.

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data  = [1,2,3;
	
	ShowMessage(data.Fist);
	// Expected: "1"

	data.Clear();

	ShowMessage(data.Fist);
	// Expected: 0	
end;
```

<hr width=”100%”>

```pascal
function Last:Integer;
 ```
Return the value of last element in array or 0 if not have one.

*Params:*
>  - None

*Return:*
>  - Result(string): Return the last element.

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data  = [1,2,3;
	
	ShowMessage(data.Last);
	// Expected: "3"

	data.Clear();

	ShowMessage(data.Last);
	// Expected: 0	
end;
```

<hr width=”100%”>

```pascal
function PushFront:Integer;
 ```
Return the value of first element in array, then remove it from array. if not have one, return 0.

*Params:*
>  - None

*Return:*
>  - Result(Integer): Return the first element.

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data  = [1,2,3;
	
	ShowMessage(data.PushFront);
	// Expected: "1"

	ShowMessage(data.PushFront);
	// Expected: "2"

	ShowMessage(data.PushFront);
	// Expected: "3"

	ShowMessage(data.PushFront);
	// Expected: 0
	
end;
```

<hr width=”100%”>

```pascal
function PushBack:Integer;
 ```
Return the value of last element in array, then remove it from array. if not have one, return 0.

*Params:*
>  - None

*Return:*
>  - Result(Integer): Return the last element.

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data  = [1,2,3;
	
	ShowMessage(data.PushBack);
	// Expected: "3"

	ShowMessage(data.PushBack);
	// Expected: "2"

	ShowMessage(data.PushBack);
	// Expected: "1"

	ShowMessage(data.PushBack);
	// Expected: 0	
end;
```

<hr width=”100%”>

```pascal
function Has(const value: Integer): Boolean;
 ```
Return **TRUE** if array has one ou more items with value 'value'.

*Params:*
>  - value(Integer): Integer value to compare with items.

*Return:*
>  - Result(Boolean): Return **TRUE** if has 'value', otherwise return **FALSE**.

*Example:*

``` pascal
procedure Main;
var 
	data: TIntegerDynArray;
begin
	data  = [1,2,3];
	
	If (data.Has(2)) then
		ShowMessage("This array has 2");
	else
		ShowMessage("This array hasn't 2");
	// Expected: "This array has 2"

	If (data.Has(6)) then
		ShowMessage("This array has 6");
	else
		ShowMessage("This array hasn't 6");
	// Expected: "This array hasn't 6"
end;
```
