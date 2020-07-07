# Delphi Boost Library

Library to boost delphi objects using helpers.

## ``TArray <string>`` 
**Aka:** Array of string, TStringDynArray


## Functions

### Notas:
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

<hr width=”100%”>

```pascal
 procedure Sort; overload;
 ```

> Sorts all elements of the array in ascending order.

*Params:*
> - None

*Return:*
>  - None

<hr width=”100%”>

```pascal
 procedure Sort(const Comparison: TComparison<string>); overload;
 ```

> Sorts all elements of the array in using the 'Comparison' function, the order is custom.

*Params:*
> - ``Comparison(TComparison<string>)``: Custom function to compare elements.

*Return:*
>  - None

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

<hr width=”100%”>

```pascal
 procedure Shuffle;
 ```

> Shuffle all elements of the array in random order.

*Params:*
> - None

*Return:*
>  - None

<hr width=”100%”>

```pascal
 procedure Reverse;
 ```

> Invert the order of all elements.

*Params:*
> - None

*Return:*
>  - None

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
>   - Else: return -1.

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
>   - Else: return -1.

<hr width=”100%”>

```pascal
 procedure Delete(Index: Integer); overload;
 ```

> Delete the element at index. Ignore if length of array is zero.

*Params:*
> - Index(Integer): Index of element in array. See [Surround Index](#SURROUND_INDEX).

*Return:*
>  - None

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

<hr width=”100%”>

```pascal
procedure Add(Value: string); overload;
 ```

> Append value in array; 

*Params:*
> - Value(String): Value to append

*Return:*
>  - None

<hr width=”100%”>

```pascal
procedure Add(Values: TStringDynArray); overload;
 ```

> Append a range of values in array; 

*Params:*
> - Values(TStringDynArray): Range of values to append

*Return:*
>  - None

<hr width=”100%”>

```pascal
function CountItems(Item: string): Integer;
 ```

> Count how many times the item exist in array; 

*Params:*
> - Item(string): Item for search for.

*Return:*
>  - Result(Integer): Number of Itens found (0 if not found).

<hr width=”100%”>

```pascal
procedure Remove(Item: string); overload;
 ```

> Removes the first occurrence of the Item in array.  

*Params:*
> - Item(String): Item for search for.

*Return:*
>  - None

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

<hr width=”100%”>

```pascal
procedure Clear();
 ```

> Removes all elements in array and set length to zero;  

*Params:*
>  - None

*Return:*
>  - None

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

<hr width=”100%”>

```pascal
function Slice(StartPos: integer): TStringDynArray; overload;
 ```

> Extract a piece of array between 'StartPos' and length of array

*Params:*
>  - StartPos(Integer): Initial position to cut;

*Return:*
>  - Result(TStringDynArray): Array extracted;

<hr width=”100%”>

```pascal
function Head(EndPos: integer): TStringDynArray;
 ```

> Extract a piece of array between position 0 and 'EndPos';

*Params:*
>  - EndPos(Integer): Final position to cut;

*Return:*
>  - Result(TStringDynArray): Array extracted;

<hr width=”100%”>

```pascal
function Tail(StartPos: integer): TStringDynArray;
 ```

> Extract a piece of array between position 'StartPos' and length of array;

*Params:*
>  - StartPos(Integer): Initial position to cut;

*Return:*
>  - Result(TStringDynArray): Array extracted;

<hr width=”100%”>

```pascal
function Save(FileName: string): boolean;
 ```

> Save the elements from array to file in disk;

*Params:*
>  - FileName(String): Name of file to save. Files existing will be override;

*Return:*
>  - Result(Boolean): Return **TRUE** if sucessfull save.


<hr width=”100%”>

```pascal
function Load(FileName: string): boolean;
 ```

> Save the elements from array to file in disk;

*Params:*
>  - FileName(String): Name of file to load. If file name not exist, this function is will be ignored;

*Return:*
>  - Result(Boolean): Return **TRUE** if sucessfull load. Return **FALSE** if file not exist ou can't be load.

<hr width=”100%”>

```pascal
function Clone: TStringDynArray;
 ```

> Create a full copy of array

*Params:*
>  - None

*Return:*
>  - Result(TStringDynArray): Copy of array.

<hr width=”100%”>

```pascal
procedure Assign(const Values: TStringDynArray); overload;
 ```

> Copy all elements in 'Values' to self array;

*Params:*
>  - Values(TStringDynArray): Source array to be copy;

*Return:*
>  - None

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

<hr width=”100%”>

```pascal
property Comma: string read GetAsComa write SetAsComma;
 ```

> This property is used to convert strings separed by comma in array and convert back;

*SET(string):*
>  - Convert strings separed by comma in elements array

*GET(string):*
>  - Return a strings separed by comma using elements array

<hr width=”100%”>

```pascal
property Items[Index: Integer]: string read GetItem write SetItem;
 ```

> This property is used to acesss and manipulate elements of array using [Surround Index](#SURROUND_INDEX).

*SET(string):*
>  - Store a string in array at position Index;

*GET(string):*
>  - Return a string stored in array at position Index;

<hr width=”100%”>

```pascal
property Count: Integer read GetCount write SetCount;
 ```

> This property is used to manipulate de length of array.

*SET(Integer):*
>  - Define a length of array, if need expand, it will be fill with empty string;

*GET(string):*
>  - Return a length of array;

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

<hr width=”100%”>

```pascal
procedure ForEach(proc: TProc<Integer, string>); overload;
 ```

> Apply a procedure ('proc') at all elements in array. 

*Params:*
>  - proc(``TProcVar<Integer, string>``): This procedure must be theses params:
> 		- Index(Integer): Index of element in array;
> 		- Item(string): Value of element in array, changes in this variable will **NOT** be apply in array.

*Return:*
>  - None

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

<hr width=”100%”>

```pascal
procedure _Of(const Args: array of const);
 ```

> Convert diferents types of elements in string, then store in array

*Params:*
>  - Args(array of const): list of elements to be converted to array

*Return:*
>  - None

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

<hr width=”100%”>

```pascal
procedure Shift(aCount: Integer = 1);
 ```

> Move a first element in array to last position. If length of array is bellow two, this function will be ignored.

*Params:*
>  - aCount(Integer): How many itens will be moved. **Default** = 1. Values bellow one not accepted.

*Return:*
>  - None

<hr width=”100%”>

```pascal
procedure Unshift(aCount: Integer = 1);
 ```

> Move a last element in array to first position. If length of array is bellow two, this function will be ignored.

*Params:*
>  - aCount(Integer): How many itens will be moved. **Default** = 1. Values bellow one not accepted.

*Return:*
>  - None

<hr width=”100%”>

```pascal
function Union(const Values: TStringDynArray): TStringDynArray;
 ```

Create a array with a 'self' and append the elements of 'Values' that not present.

*Params:*
>  - Values(TStringDynArray): Source vector to compare in new vector.

*Return:*
>  - Result(TStringDynArray): new array with a union of elements.

<hr width=”100%”>

```pascal
function Diference(const Values: TStringDynArray): TStringDynArray;
 ```

Create a array with a 'self' and remove the elements common with 'Values'.

*Params:*
>  - Values(TStringDynArray): Source vector to compare in new vector.

*Return:*
>  - Result(TStringDynArray): new array with a union of elements.

<hr width=”100%”>

```pascal
function Interception(const Values: TStringDynArray): TStringDynArray;
 ```

Create a array with a 'self' and remove the elements **NOT** common with 'Values'.

*Params:*
>  - Values(TStringDynArray): Source vector to compare in new vector.

*Return:*
>  - Result(TStringDynArray): new array with a union of elements.

<hr width=”100%”>

```pascal
function Exclusion(const Values: TStringDynArray): TStringDynArray;
 ```

Create a array with a 'self', append all elements of 'Values', then remove the elements common between two arrays.

*Params:*
>  - Values(TStringDynArray): Source vector to compare in new vector.

*Return:*
>  - Result(TStringDynArray): new array with a union of elements.

```pascal
function Same(const Values: TStringDynArray): Boolean;
 ```

Compare a 'self' array with a 'Values' array.

*Params:*
>  - Values(TStringDynArray): Source vector to compare.

*Return:*
>  - Result(Boolean): Return **TRUE** if all elements in same position has the same value. Otherwise return **FALSE**.

```pascal
function SameData(const Values: TStringDynArray): Boolean;
 ```

Compare a 'self' array with a 'Values' array.

*Params:*
>  - Values(TStringDynArray): Source vector to compare.

*Return:*
>  - Result(Boolean): Return **TRUE** if all elements in any position has the same value. Otherwise return **FALSE**.