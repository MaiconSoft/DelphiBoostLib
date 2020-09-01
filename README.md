# Delphi Boost Library

Library to boost delphi objects using helpers.

## ``TArray <string>`` 
**Aka:** Array of string, TStringDynArray


## Functions

### Notes:
<div id="SURROUND_INDEX"/>

 Surround index: The index can be above length of array or bellow zero.

> Above values will be coverted in first mutiple of length.

> Bellow zero values will be converted in reverse order:

> Exemples: [a, b, c, d]:

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

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];

	ShowMessage(data.join());
	// Expected: "apple orange banana"

	ShowMessage(data.join(', '));
	// Expected: "apple, orange, banana"

	ShowMessage(data.join(' - '));
	// Expected: "apple - orange - banana"
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

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];

	data.sort();

	ShowMessage(data.join());
	// Expected: "apple banana orange"
end;
```
<hr width=”100%”>

```pascal
 procedure Sort(const Comparison: TComparison<string>); overload;
 ```

> Sorts all elements of the array in using the 'Comparison' function, the order is custom.

*Params:*
> - ``Comparison(TComparison<string>)``: Custom function to compare elements.

*Return:*
>  - None

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];

	data.sort();

	ShowMessage(data.join());
	// Expected: "apple banana orange"
end;
```

<hr width=”100%”>

```pascal
 procedure Sort(const Comparison: TComparison<string>; Index, Count: integer);
      overload;
 ```

> Same of custom Sort, but with limits.

*Params:*
> - ``Comparison(TComparison<string>)``: Custom function to compare elements;
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

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];

	data.rsort();

	ShowMessage(data.join());
	// Expected: "orange banana apple"
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

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','banana','orange'];

	data.rsort();

	ShowMessage(data.join());
	// Expected: random order every time
	// Exemple: "banana orange apple"
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

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];

	data.Reverse();

	ShowMessage(data.join());
	// Expected: "banana orange apple"
end;
```

<hr width=”100%”>

```pascal
 function IndexOf(const Value: string; StartPos: Integer = 0): Integer;
 ```

> Get index of a element in array.

*Params:*
> - Value(string): Search element;
> - StartPos(Integer): Position to start search. **Default** 0.

*Return:*
>  - Result(Integer):
>  	- If item is found: return index of value in array (zero based);
>  	- Else: return -1.

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
	index: Integer;
begin
	data = ['apple','orange','apple' 'banana'];

	index = data.IndexOf('apple');
	// Expected: 0

	index = data.IndexOf('orange');
	// Expected: 1

	index = data.IndexOf('lime');
	// Expected: -1

	index = data.IndexOf('apple ');
	// Expected: -1

	index = data.IndexOf('apple',1);
	// Expected: 2

	index = data.IndexOf('orange',2);
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
	data: TStringDynArray;
	index: Integer;
begin
	data = ['apple','orange','apple', 'banana'];

	index = data.LastIndexOf('apple');
	// Expected: 2

	index = data.LastIndexOf('orange');
	// Expected: 1

	index = data.LastIndexOf('lime');
	// Expected: -1

	index = data.LastIndexOf('apple ');
	// Expected: -1

	index = data.LastIndexOf('apple',1);
	// Expected: 0

	index = data.LastIndexOf('banana',2);
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

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];
	data.Delete(0);
	ShowMessage(data.join());	
	// Expected: "orange banana"

	data = ['apple','orange','banana'];
	data.Delete(-1);
	ShowMessage(data.join());	
	// Expected: "apple orange"

	data = ['apple','orange','banana'];
	data.Delete(-2);
	ShowMessage(data.join());	
	// Expected: "apple banana"

	data = ['apple','orange','banana'];
	data.Delete(-3);
	ShowMessage(data.join());	
	// Expected: "orange banana"
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

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin	
	data = ['apple','orange','banana'];
	data.Delete(0,0);
	ShowMessage(data.join());	
	// Expected: "apple orange banana"

	data = ['apple','orange','banana'];
	data.Delete(0,2);
	ShowMessage(data.join());	
	// Expected: "banana"

	data = ['apple','orange','banana'];
	data.Delete(-1,2);
	ShowMessage(data.join());	
	// Expected: "apple orange"

	data = ['apple','orange','banana'];
	data.Delete(1,5);
	ShowMessage(data.join());	
	// Expected: "apple"
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

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];	
	data.Insert(0,'lime');
	ShowMessage(data.join());	
	// Expected: "lime apple orange banana"
	
	data = ['apple','orange','banana'];
	data.Insert(-1,'lime');
	ShowMessage(data.join());	
	// Expected: "apple orange lime banana"

	data = ['apple','orange','banana'];
	data.Insert(4,'lime');
	ShowMessage(data.join());	
	// Expected: "apple lime orange banana"
end;
```

<hr width=”100%”>

```pascal
procedure Insert(Index: Integer; Values: TStringDynArray); overload;
 ```

> Inset a range of value into array at position index; 

*Params:*
> - Index(Integer): Position to insert in array. See [Surround Index](#SURROUND_INDEX).
> - Values(TStringDynArray): Values to insert.

*Return:*
>  - None

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];	
	data.Insert(0,['lime','grape','strawberry']);
	ShowMessage(data.join());	
	// Expected: "lime grape strawberry apple orange banana"

	data = ['apple','orange','banana'];
	data.Insert(-1,['lime','grape','strawberry']);
	ShowMessage(data.join());	
	// Expected: "apple orange lime grape strawberry banana"
	
	data = ['apple','orange','banana'];
	data.Insert(4,['lime','grape','strawberry']);
	ShowMessage(data.join());	
	// Expected: "apple lime grape strawberry orange banana"
end;
```

<hr width=”100%”>

```pascal
procedure Add(Value: string); overload;
 ```

> Append value in array; 

*Params:*
> - Value(String): Value to append

*Return:*
>  - None

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];
	
	data.Add('lime');
	ShowMessage(data.join());	
	// Expected: "apple orange banana lime"
end;
```

<hr width=”100%”>

```pascal
procedure Add(Values: TStringDynArray); overload;
 ```

> Append a range of values in array; 

*Params:*
> - Values(TStringDynArray): Range of values to append

*Return:*
>  - None

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];
	
	data.Add(['lime','grape','strawberry']);
	ShowMessage(data.join());	
	// Expected: "apple orange banana lime grape strawberry"
end;
```

<hr width=”100%”>

```pascal
function CountItems(Item: string): Integer;
```

> Count how many times the item exist in array; 

*Params:*
> - Item(string): Item for search for.

*Return:*
>  - Result(Integer): Number of Itens found (0 if not found).

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
	count:Integer;
begin
	data = ['apple','orange','apple','banana','apple','banana'];
	
	count:= data.CountItems('apple');	
	// Expected: 3

	count:= data.CountItems('orange');	
	// Expected: 1

	count:= data.CountItems('banana');	
	// Expected: 2

	count:= data.CountItems('strawberry');	
	// Expected: 0
end;
```

<hr width=”100%”>

```pascal
procedure Remove(Item: string); overload;
 ```

> Removes the first occurrence of the Item in array by value.  

*Params:*
> - Item(String): Item for search for.

*Return:*
>  - None

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','apple','banana'];
	
	data.Remove('orange');
	ShowMessage(data.join());	
	// Expected: "apple apple banana"

	data = ['apple','orange','apple','banana'];
	data.Remove('apple');
	ShowMessage(data.join());	
	// Expected: "orange apple banana"
	
	data = ['apple','orange','apple','banana'];
	data.Remove('grape');
	ShowMessage(data.join());	
	// Expected: "apple orange apple banana"

end;
```

<hr width=”100%”>

```pascal
procedure Remove(Item: string; count: integer); overload;
 ```

> Removes the 'Count' occurrences of the Item in array.  

*Params:*
> - Item(String): Item for search for.
> - Count(Integer): Number of repetitions of item to be removed.

*Return:*
>  - None

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','apple','banana'];
	
	data.Remove('orange',0);
	ShowMessage(data.join());	
	// Expected: "apple orange apple banana"

	data = ['apple','orange','apple','banana'];
	data.Remove('apple',2);
	ShowMessage(data.join());	
	// Expected: "apple banana"
	
	data = ['apple','orange','apple','banana'];
	data.Remove('grape',3);
	ShowMessage(data.join());	
	// Expected: "apple orange apple banana"

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

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];
	
	data.Clear();
	ShowMessage(data.join());	
	// Expected: ""
	ShowMessage(IntToStr(data.length);	
	// Expected: 0
end;
```

<hr width=”100%”>

```pascal
function Slice(StartPos, EndPos: integer): TStringDynArray; overload;
 ```

> Extract a piece of array between 'StartPos' and 'EndPos' (incluse)

*Params:*
>  - StartPos(Integer): Initial position to cut;
>  - EndPos(Integer): Final position to cut;

*Return:*
>  - Result(TStringDynArray): Array extracted;

*Exemple:*

``` pascal
procedure Main;
var 
	data,piece: TStringDynArray;
begin
	data = ['apple','orange','banana'];
	
	piece = data.slice(0,1);
	ShowMessage(piece.join());	
	// Expected: "apple orange"
	
	piece = data.slice(-1,1);
	ShowMessage(piece.join());	
	// Expected: "banana apple"
	
	piece = data.slice(4,1);
	ShowMessage(piece.join());	
	// Expected: "orange"
end;
```

<hr width=”100%”>

```pascal
function Slice(StartPos: integer): TStringDynArray; overload;
 ```

> Extract a piece of array between 'StartPos' and length of array

*Params:*
>  - StartPos(Integer): Initial position to cut;

*Return:*
>  - Result(TStringDynArray): Array extracted;

*Exemple:*

``` pascal
procedure Main;
var 
	data,piece: TStringDynArray;
begin
	data = ['apple','orange','banana'];
	
	piece = data.slice(0);
	ShowMessage(piece.join());	
	// Expected: "apple orange banana"
	
	piece = data.slice(-1);
	ShowMessage(piece.join());	
	// Expected: "banana"
	
	piece = data.slice(4);
	ShowMessage(piece.join());	
	// Expected: "orange"
end;
```

<hr width=”100%”>

```pascal
function Head(EndPos: integer): TStringDynArray;
 ```

> Extract a piece of array between position 0 and 'EndPos';

*Params:*
>  - EndPos(Integer): Final position to cut;

*Return:*
>  - Result(TStringDynArray): Array extracted;

*Exemple:*

``` pascal
procedure Main;
var 
	data,piece: TStringDynArray;
begin
	data = ['apple','orange','banana'];
	
	piece = data.Head(0);
	ShowMessage(piece.join());	
	// Expected: "apple"
	
	piece = data.Head(-1);
	ShowMessage(piece.join());	
	// Expected: "apple orange banana"
	
	piece = data.Head(4);
	ShowMessage(piece.join());	
	// Expected: "apple orange"
end;
```

<hr width=”100%”>

```pascal
function Tail(StartPos: integer): TStringDynArray;
 ```

> Extract a piece of array between position 'StartPos' and length of array;

*Params:*
>  - StartPos(Integer): Initial position to cut;

*Return:*
>  - Result(TStringDynArray): Array extracted;

*Exemple:*

``` pascal
procedure Main;
var 
	data,piece: TStringDynArray;
begin
	data = ['apple','orange','banana'];
	
	piece = data.Tail(0);
	ShowMessage(piece.join());	
	// Expected: "apple orange banana"
	
	piece = data.Tail(-1);
	ShowMessage(piece.join());	
	// Expected: "banana"
	
	piece = data.Tail(4);
	ShowMessage(piece.join());	
	// Expected: "orange banana"
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

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];
	
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

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];
	data.Save('c:\data.txt');
	data.Clear();	
	ShowMessage(data.join());	
	// Expected: ""

	data.load('c:\data.txt');
	ShowMessage(data.join());	
	// Expected: "apple orange banana"	
end;
```


<hr width=”100%”>

```pascal
function Clone: TStringDynArray;
 ```

> Create a full copy of array

*Params:*
>  - None

*Return:*
>  - Result(TStringDynArray): Copy of array.

*Exemple:*

``` pascal
procedure Main;
var 
	data,data2: TStringDynArray;
begin
	data = ['apple','orange','banana'];

	data2 = data.Clone();
	ShowMessage(data2.join());	
	// Expected: "apple orange banana"
end;
```

<hr width=”100%”>

```pascal
procedure Assign(const Values: TStringDynArray); overload;
 ```

> Copy all elements in 'Values' to self array;

*Params:*
>  - Values(TStringDynArray): Source array to be copy;

*Return:*
>  - None

*Exemple:*

``` pascal
procedure Main;
var 
	data,data2: TStringDynArray;
begin
	data = ['apple','orange','banana'];

	data2.Assign(data);
	ShowMessage(data2.join());	
	// Expected: "apple orange banana"
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

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data.Assign('apple, orange, banana',[',']);
	ShowMessage(data.join());	
	// Expected: "apple orange banana"

	data.Assign('apple orange banana',[' ']);
	ShowMessage(data.join());	
	// Expected: "apple orange banana"
end;
```

<hr width=”100%”>

```pascal
procedure Assign(const Values: string; Separator: TStringDynArray); overload;
 ```

> Split a string by any string in 'Separator', then copy all piaces to self array;

*Params:*
>  - Values(string): string to be split;
>  - Separator(TStringDynArray): list of separator string;

*Return:*
>  - None

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data.Assign('apple fruit orange fruit banana',['fruit']);
	ShowMessage(data.join());	
	// Expected: "apple orange banana"

	data.Assign('apple fruit orange citric banana',['fruit','citric']);
	ShowMessage(data.join());	
	// Expected: "apple orange banana"
end;
```

<hr width=”100%”>

```pascal
procedure Fill(const Value: string; const StartIndex: integer = 0; const
      Endindex: integer = -1);
 ```

> Fill all elements of array with 'Value', started by 'StartIndex'

*Params:*
>  - Value(string): Value to fill array;
>  - StartIndex(Integer): Initial index to fill. If 'StartIndex' is above length of array or length of array is zero, this functions will be igorened.

*Return:*
>  - None

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];
	data.fill('strawberry');
	ShowMessage(data.join());	
	// Expected: "strawberry strawberry strawberry"

	data.Clear();
	data.fill('lime');
	ShowMessage(data.join());	
	// Expected: ""

	data.Count = 4;
	data.fill('grape');
	ShowMessage(data.join());	
	// Expected: "grape grape grape grape"

	data.fill('lime',2);
	ShowMessage(data.join());	
	// Expected: "grape grape lime lime"
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

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data.Comma = 'apple, orange, banana';
	ShowMessage(data.join());	
	// Expected: "apple orange banana"
	
	data.Add('strawberry');
	ShowMessage(data.Comma);	
	// Expected: "apple, orange, banana, strawberry"
end;
```

<hr width=”100%”>

```pascal
property Items[Index: Integer]: string read GetItem write SetItem;
 ```

> This property is used to acesss and manipulate elements of array using [Surround Index](#SURROUND_INDEX).

*SET(string):*
>  - Store a string in array at position Index;

*GET(string):*
>  - Return a string stored in array at position Index;

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];
	ShowMessage(data.Items[0]);	
	// Expected: "apple"
	
	ShowMessage(data.Items[-1]);	
	// Expected: "banana"

	ShowMessage(data.Item[4]);	
	// Expected: "orange"

	data.Items[4] = 'grape';
	ShowMessage(data.Join());	
	// Expected: "apple grape banana"
end;
```

<hr width=”100%”>

```pascal
property Count: Integer read GetCount write SetCount;
 ```

> This property is used to manipulate de length of array.

*SET(Integer):*
>  - Define a length of array, if need expand, it will be fill with empty string;

*GET(Integer):*
>  - Return a length of array;

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];
	ShowMessage(StrToInt(data.Count));	
	// Expected: 3
	
	data.Count = 4;
	data.Items[3] = 'grape';
	ShowMessage(data.Join());
	// Expected: "apple orange banana grape"

	data.Count = 2;
	ShowMessage(data.Join());
	// Expected: "apple orange"
end;
```

<hr width=”100%”>

```pascal
procedure ForEach(proc: TProcVar<Integer, string>); overload;
 ```

> Apply a procedure ('proc') at all elements in array. 

*Params:*
>  - proc(``TProcVar<Integer, string>``): This procedure must be theses params:
> 		- Index(Integer): Index of element in array;
> 		- var Item(string): Value of element in array, changes in this variable will be apply in array.

*Return:*
>  - None

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];
	data.ForEach(Procedure (Index:Integer;var Item:string)
				 begin
				 	Item = Index.ToString()+':'+Item;
				 end);

	ShowMessage(data.Join());
	// Expected: "0:apple 1:orange 2:banana"		
end;
```

<hr width=”100%”>

```pascal
procedure ForEach(proc: TProcVar<string>); overload;
 ```

> Apply a procedure ('proc') at all elements in array. 

*Params:*
>  - proc(``TProcVar<string>``): This procedure must be this param:
> 		- var Item(string): Value of element in array, changes in this variable will be apply in array.

*Return:*
>  - None

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];
	data.ForEach(Procedure (var Item:string)
				 begin
				 	Item = 'Fruit '+Item;
				 end);

	ShowMessage(data.Join());
	// Expected: "Fruit apple Fruit orange Fruit banana"		
end;
```

<hr width=”100%”>

```pascal
procedure ForEach(proc: TProc<Integer, string>); overload;
 ```

> Apply a procedure ('proc') at all elements in array. 

*Params:*
>  - proc(``TProc<Integer, string>``): This procedure must be theses params:
> 		- Index(Integer): Index of element in array;
> 		- Item(string): Value of element in array, changes in this variable will **NOT** be apply in array.

*Return:*
>  - None

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];
	data.ForEach(Procedure (Index:Integer;Item:string)
				 begin
				 	ShowMessage(format('The Item at Index %d is %s',[Index,Item]));
				 end);
	Expected:
		"The Item at Index 0 is apple"
		"The Item at Index 1 is orange"
		"The Item at Index 2 is banana"
end;
```

<hr width=”100%”>

```pascal
procedure ForEach(proc: TProc<string>); overload;
 ```

> Apply a procedure ('proc') at all elements in array. 

*Params:*
>  - proc(``TProcVar<Integer, string>``): This procedure must be this param:
> 		- Item(string): Value of element in array, changes in this variable will **NOT** be apply in array.

*Return:*
>  - None

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];
	data.ForEach(Procedure (Item:string)
				 begin
				 	ShowMessage(format('The Item is %s',[Item]));
				 end);
	Expected:
		"The Item is apple"
		"The Item is orange"
		"The Item is banana"
end;
```

<hr width=”100%”>

```pascal
procedure _Of(const Args: array of const);
 ```

> Convert diferents types of elements in string, then store in array

*Params:*
>  - Args(array of const): list of elements to be converted to array

*Return:*
>  - None

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data._Of([True, 10, 'words', 'A','z', 3.1416]);

	ShowMessage(data.Join());
	// Expected: "true 10 words A z 3.1416"
end;
```

<hr width=”100%”>

```pascal
function Every(func: TFunc<string, Boolean>): Boolean; overload;
 ```

> Check if all elements in array follow the user 'func'

*Params:*
>  - func(``TFunc<string, Boolean>``): This function must be this param:
> 		- Item(String): Value of element in array;
> 		- Result(Boolean): The function must return a boolean value for the test, values **FALSE** will terminate a function and fail in test.


*Return:*
>  - Result(Boolean): Return **TRUE** if all elements in array pass in test. Otherwise return **FALSE**.

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];
	data.Every(Function (Item:string):boolean
				 begin
				 	Result:= Item.length > 4
				 end);
	Expected:
		True

	data.Every(Function (Item:string):boolean
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
function Every(func: TFunc<string, Integer, Boolean>): Boolean; overload;
 ```

> Check if all elements in array follow the user 'func'

*Params:*
>  - func(``TFunc<string, Boolean>``): This function must be this param:
> 		- Item(String): Value of element in array;
> 		- Index(Integer): Index of element in array;
> 		- Result(Boolean): The function must return a boolean value for the test, values **FALSE** will terminate a function and fail in test.

*Return:*
>  - Result(Boolean): Return **TRUE** if all elements in array pass in test. Otherwise return **FALSE**.

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['apple','orange','banana'];
	data.Every(Function (Index:integer; Item:string):boolean
				 begin
					If (Index = 0) then
				 		Result:= Item.length = 5
				 	else:
				 		Result:= Item.length = 6
				 end);
	Expected:
		True

	data.Every(Function (Index:integer; Item:string):boolean
				 begin
					If (Index > 1) then
					  Exit(True);

					Result:= Item = 'apple';				 	
				 end);
	Expected:
		False
end;
```

<hr width=”100%”>

```pascal
function Filter(func: TFunc<string, Boolean>): TStringDynArray; overload;
 ```

> Create a new array with all elements pass in test of function 'func'.

*Params:*
>  - func(``TFunc<string, Boolean>``): This function must be this param:
> 		- Item(String): Value of element in array;
> 		- Result(Boolean): The function must return a boolean value for the test, values **FALSE** exclude a item in new array.

*Return:*
>  - Result(TStringDynArray): Return a new array. If none elements pass in test or 'func' is not assigned, will return a empty array.

*Exemple:*

``` pascal
procedure Main;
var 
	data,data2: TStringDynArray;
begin
	data = ['grape','apple','orange','banana'];
	data2 = data.Filter(Function (Item:string):boolean
				 		begin				 		
				 			If (Item.length > 0)
				 				Result:= Item[1] in ['a'..'g']
				 			else
				 				Result:= False;
				 		end);
	ShowMessage(data2.Join());
	Expected: "grape apple banana"
end;
```

<hr width=”100%”>

```pascal
function Filter(func: TFunc<string, Integer, Boolean>): TStringDynArray; overload;
 ```

> Create a new array with all elements pass in test of function 'func'.

*Params:*
>  - func(``TFunc<string, Integer, Boolean>``): This function must be this param:
> 		- Item(String): Value of element in array;
> 		- Index(Integer): Index of element in array;
> 		- Result(Boolean): The function must return a boolean value for the test, values **FALSE** exclude a item in new array.

*Return:*
>  - Result(TStringDynArray): Return a new array. If none elements pass in test or 'func' is not assigned, will return a empty array.

*Exemple:*

``` pascal
procedure Main;
var 
	data,data2: TStringDynArray;
begin
	data = ['grape','apple','orange','banana'];
	data2 = data.Filter(Function (Index:integer; Item:string):boolean
				 		begin
				 			if (Index = 0) then
				 				Exit(True);
				 			Result:= Item.length > 5;
				 		end);
	ShowMessage(data2.Join());
	Expected: "grape orange banana"
end;
```

<hr width=”100%”>

```pascal
function Find(func: TFunc<string, Integer, Boolean>): string; overload;
 ```

> Return a first ocorrence of element pass in 'func' test.

*Params:*
>  - func(``TFunc<string, Integer, Boolean>``): This function must be this param:
> 		- Item(String): Value of element in array;
> 		- Index(Integer): Index of element in array;
> 		- Result(Boolean): The function must return a boolean value for the test, value **TRUE** will satisfy and terminate a function, then it will be returned.

*Return:*
>  - Result(string): Return the vector element that pass the test. If none elements pass in test or 'func' is not assigned, will return a empty string.

*Exemple:*

``` pascal
procedure Main;
var 
	data TStringDynArray;
	found:string;
begin
	data = ['grape','apple','orange','banana'];
	found = data.Find(Function (Index:integer; Item:string):boolean
			begin			
				If (Index > 1) 		
					Result:= (Item = 'orange') or (Item = 'apple')
				else
					Result:= false;
			end);
	ShowMessage(found);
	Expected: "apple"

	found = data.Find(Function (Item:string):boolean
			begin				 			
				Result:= (Item = 'strawberry') or (Item.length = 3);
			end);
	ShowMessage(found);
	Expected: ""
end;
```

<hr width=”100%”>

```pascal
function Find(func: TFunc<string,  Boolean>): string; overload;
 ```

> Return a first ocorrence of element pass in 'func' test.

*Params:*
>  - func(``TFunc<string, Boolean>``): This function must be this param:
> 		- Item(String): Value of element in array;
> 		- Result(Boolean): The function must return a boolean value for the test, value **TRUE** will satisfy and terminate a function, then it will be returned.

*Return:*
>  - Result(string): Return the vector element that pass the test. If none elements pass in test or 'func' is not assigned, will return a empty string.

*Exemple:*

``` pascal
procedure Main;
var 
	data TStringDynArray;
	found:string;
begin
	data = ['grape','apple','orange','banana'];
	found = data.Find(Function (Item:string):boolean
			begin				 			
				Result:= (Item = 'orange') or (Item = 'apple');
			end);
	ShowMessage(found);
	Expected: "apple"

	found = data.Find(Function (Item:string):boolean
			begin				 			
				Result:= (Item = 'strawberry') or (Item.length = 3);
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

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['grape','lime','apple','orange'];
	
	data.Shift();
	ShowMessage(data.Join());
	// Expected: "lime apple orange grape"

	data.Shift();
	ShowMessage(data.Join());
	// Expected: "apple orange grape lime"

	data.Shift();
	ShowMessage(data.Join());
	// Expected: "orange grape lime apple"

	data = ['grape','lime','apple','orange'];

	data.Shift(3);
	ShowMessage(data.Join());
	// Expected: "orange grape lime apple"
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

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data = ['grape','lime','apple','orange'];
	
	data.Unshift();
	ShowMessage(data.Join());
	// Expected: "orange grape lime apple"

	data.Unshift();
	ShowMessage(data.Join());
	// Expected: "apple orange grape lime"

	data.Unshift();
	ShowMessage(data.Join());
	// Expected: "lime apple orange grape"

	data = ['grape','lime','apple','orange'];

	data.Unshift(3);
	ShowMessage(data.Join());
	// Expected: "lime apple orange grape"
end;
```

<hr width=”100%”>

```pascal
function Union(const Values: TStringDynArray): TStringDynArray;
 ```

Create a array with a 'self' and append the elements of 'Values' that not present.

*Params:*
>  - Values(TStringDynArray): Source vector to compare in new vector.

*Return:*
>  - Result(TStringDynArray): new array with a union of elements.

*Exemple:*

``` pascal
procedure Main;
var 
	data,data2,data3: TStringDynArray;
begin
	data = ['lime','apple','orange','banana','apple'];
	data2 = ['strawberry','grape','apple','orange'];
	
	data3 = data.Union(data2);
	ShowMessage(data3.Join());
	// Expected: "lime apple orange banana apple strawberry grape"
end;
```

<hr width=”100%”>

```pascal
function Diference(const Values: TStringDynArray): TStringDynArray;
 ```

Create a array with a 'self' and remove the elements common with 'Values'.

*Params:*
>  - Values(TStringDynArray): Source vector to compare in new vector.

*Return:*
>  - Result(TStringDynArray): new array with a union of elements.

*Exemple:*

``` pascal
procedure Main;
var 
	data,data2,data3: TStringDynArray;
begin
	data = ['lime','apple','orange','banana','apple'];
	data2 = ['strawberry','grape','apple','orange'];
	
	data3 = data.Diference(data2);
	ShowMessage(data3.Join());
	// Expected: "lime banana"
end;
```

<hr width=”100%”>

```pascal
function Interception(const Values: TStringDynArray): TStringDynArray;
 ```

Create a array with a 'self' and remove the elements **NOT** common with 'Values'.

*Params:*
>  - Values(TStringDynArray): Source vector to compare in new vector.

*Return:*
>  - Result(TStringDynArray): new array with a union of elements.

*Exemple:*

``` pascal
procedure Main;
var 
	data,data2,data3: TStringDynArray;
begin
	data = ['lime','apple','orange','banana','apple'];
	data2 = ['strawberry','grape','apple','orange'];
	
	data3 = data.Interception(data2);
	ShowMessage(data3.Join());
	// Expected: "apple orange apple"
end;
```

<hr width=”100%”>

```pascal
function Exclusion(const Values: TStringDynArray): TStringDynArray;
 ```

Create a array with a 'self', append all elements of 'Values', then remove the elements common between two arrays.

*Params:*
>  - Values(TStringDynArray): Source vector to compare in new vector.

*Return:*
>  - Result(TStringDynArray): new array with a union of elements.

*Exemple:*

``` pascal
procedure Main;
var 
	data,data2,data3: TStringDynArray;
begin
	data = ['lime','apple','orange','banana','apple'];
	data2 = ['strawberry','grape','apple','orange'];
	
	data3 = data.Exclusion(data2);
	ShowMessage(data3.Join());
	// Expected: "lime banana strawberry grape"
end;
```

<hr width=”100%”>

```pascal
function Same(const Values: TStringDynArray): Boolean;
 ```

Compare a 'self' array with a 'Values' array.

*Params:*
>  - Values(TStringDynArray): Source vector to compare.

*Return:*
>  - Result(Boolean): Return **TRUE** if all elements in same position has the same value. Otherwise return **FALSE**.

*Exemple:*

``` pascal
procedure Main;
var 
	data,data2: TStringDynArray;
begin
	data  = ['apple','orange','banana','orange'];
	data2 = ['apple','orange','banana','orange'];
	
	data.Same(data2);
	// Expected: TRUE

	data  = ['apple','orange','banana','orange'];
	data2 = ['banana','apple','orange','banana'];
	
	data.Same(data2);
	// Expected: FALSE

	data  = ['lime','orange','banana','orange'];
	data2 = ['banana','apple','orange','banana'];
	
	data.Same(data2);
	// Expected: FALSE
end;
```

<hr width=”100%”>

```pascal
function SameData(const Values: TStringDynArray): Boolean;
 ```

Compare a 'self' array with a 'Values' array.

*Params:*
>  - Values(TStringDynArray): Source vector to compare.

*Return:*
>  - Result(Boolean): Return **TRUE** if all elements in any position has the same value. Otherwise return **FALSE**.

*Exemple:*

``` pascal
procedure Main;
var 
	data,data2: TStringDynArray;
begin
	data  = ['apple','orange','banana','orange'];
	data2 = ['apple','orange','banana','orange'];
	
	data.SameData(data2);
	// Expected: TRUE

	data  = ['apple','orange','banana','orange'];
	data2 = ['banana','apple','orange','banana'];
	
	data.SameData(data2);
	// Expected: TRUE

	data  = ['lime','orange','banana','orange'];
	data2 = ['banana','apple','orange','banana'];
	
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

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
	duplicateCount : Integer;
begin
	data  = ['apple','orange','banana','orange','banana'];
	
	duplicateCount = data.RemoveDuplicate();
	ShowMessage(data.Join())
	// Expected: "apple orange banana"
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

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
	duplicateCount : Integer;
begin
	data  = ['  apple  ', '  ', '  orange', 'banana  ', '',''];
	
	data.Trim();
	ShowMessage(data.Join())
	// Expected: "apple orange banana"
end;
```

<hr width=”100%”>


```pascal
function First:string;
 ```
Return the value of fist element in array or empty string if not have one.

*Params:*
>  - None

*Return:*
>  - Result(string): Return the fist element.

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data  = ['apple','orange','banana';
	
	ShowMessage(data.Fist);
	// Expected: "apple"

	data.Clear();

	ShowMessage(data.Fist);
	// Expected: ""	
end;
```

<hr width=”100%”>

```pascal
function Last:string;
 ```
Return the value of last element in array or empty string if not have one.

*Params:*
>  - None

*Return:*
>  - Result(string): Return the last element.

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data  = ['apple','orange','banana';
	
	ShowMessage(data.Last);
	// Expected: "banana"

	data.Clear();

	ShowMessage(data.Last);
	// Expected: ""	
end;
```

<hr width=”100%”>

```pascal
function PushFront:string;
 ```
Return the value of first element in array, then remove it from array. if not have one, return a empty string.

*Params:*
>  - None

*Return:*
>  - Result(string): Return the first element.

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data  = ['apple','orange','banana';
	
	ShowMessage(data.PushFront);
	// Expected: "apple"

	ShowMessage(data.PushFront);
	// Expected: "orange"

	ShowMessage(data.PushFront);
	// Expected: "banana"

	ShowMessage(data.PushFront);
	// Expected: ""
	
end;
```

<hr width=”100%”>

```pascal
function PushBack:string;
 ```
Return the value of last element in array, then remove it from array. if not have one, return a empty string.

*Params:*
>  - None

*Return:*
>  - Result(string): Return the last element.

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data  = ['apple','orange','banana';
	
	ShowMessage(data.PushBack);
	// Expected: "banana"

	ShowMessage(data.PushBack);
	// Expected: "orange"

	ShowMessage(data.PushBack);
	// Expected: "apple"

	ShowMessage(data.PushBack);
	// Expected: ""	
end;
```

<hr width=”100%”>

```pascal
function Has(const value: string): Boolean;
 ```
Return **TRUE** if array has one ou more items with value 'value'.

*Params:*
>  - value(string): String value to compare with items.

*Return:*
>  - Result(Boolean): Return **TRUE** if has 'value', otherwise return **FALSE**.

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
begin
	data  = ['apple','orange','banana'];
	
	If (data.Has('orange')) then
		ShowMessage("This array has orange");
	else
		ShowMessage("This array hasn't orange");
	// Expected: "This array has orange"

	If (data.Has('strawberry')) then
		ShowMessage("This array has strawberry");
	else
		ShowMessage("This array hasn't strawberry");
	// Expected: "This array hasn't strawberry"
end;
```
<hr width=”100%”>

```pascal
function Quoted(): TStringDynArray;
 ```
Return a array with all elements quoted using char 47 ('). This char is skiped in element using another.

*Params:*
>  - None

*Return:*
>  - Result(TStringDynArray): Return array with all elements quoted.

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
	w: string;
begin
	data  = ['apple','orange','it''not a frut'];
	for w in data.Quoted() do	
		ShowMessage(w);
	// Expected: "'apple'"
	// Expected: "'orange'"
	// Expected: "'it''not a frut'"

	ShowMessage(data.Quoted().comma);
	// Expected: "'apple','orange','it''not a frut'"
end;
```
<hr width=”100%”>

```pascal
function Quoted(Quote: Char): TStringDynArray;
 ```
Return a array with all elements quoted using 'Quote' char. This char is skiped in element using another.

*Params:*
>  - Quote(Char): char to insert surround every word (element) of array;

*Return:*
>  - Result(TStringDynArray): Return array with all elements quoted.

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
	w: string;
begin
	data  = ['apple','orange','|none|'];
	for w in data.Quoted('|') do	
		ShowMessage(w);
	// Expected: "|apple|"
	// Expected: "|orange|"
	// Expected: "||none||"

	ShowMessage(data.Quoted().comma);
	// Expected: "|apple|,|orange|,||none||"
end;
```
<hr width=”100%”>

```pascal
function Quoted(Quote: string; Skip: string): TStringDynArray;
 ```
Return a array with all elements quoted using 'Quote' string. This string is skiped in element using 'Skip' string before.

*Params:*
>  - Quote(String): string to insert surround every word (element) of array;
> - Skip(String): In case 'Quote' string is inside the element, the this string is add before the 'Quote' word.

*Return:*
>  - Result(TStringDynArray): Return array with all elements quoted.

*Exemple:*

``` pascal
procedure Main;
var 
	data: TStringDynArray;
	w: string;
begin
	data  = ['apple','orange','"none"'];
	for w in data.Quoted('"','\') do	
		ShowMessage(w);
	// Expected: "apple"
	// Expected: "orange"
	// Expected: "\"none\""

	ShowMessage(data.Quoted().comma);
	// Expected: "apple","orange","\"none\""
end;
```
<hr width=”100%”>