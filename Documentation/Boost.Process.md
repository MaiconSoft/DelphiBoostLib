# ``TPipe`` 

The **TPipe** implement a class for easy manager command line aplications and [redirect child process I/O](https://docs.microsoft.com/en-us/windows/win32/ProcThread/creating-a-child-process-with-redirected-input-and-output).

## Features

 - Run child process;
 - Write WideString, AnsiString and bytes on child;
 - Read all data from child process (just after close it);
 - Wait for child process close;
 - Force close;

## Methods
```pascal
	constructor Create; overload;
	constructor Create(CommandLine: string); overload;
	destructor Destroy; override;	
 ```

> Constructors for TPipe, support:
- **No parameter constructor**: For run application in future (use "Run" method to run);
- **CommandLine(String)**: Create a object and run the command line;

<hr width=”100%”>

``` pascal
	procedure Write(const Buffer; Size: DWord); overload;
```
> Generic function to write data in child process

*Params:*
> - Buffer: Any data variable (string, array, variable etc.);
> - Size(DWord): Size of data buffer in bytes;

*Return:*
>  - None;

*Example:*

``` pascal
procedure Main;
var 
	Pipe: TPipe;
	intValue:Integer;
begin	
	intValue := 1500;
	Pipe: TPipe.Create("ChildProcess.exe");	
	
	// Write 1500 on ChildProcess.exe
	Pipe.Write(intValue, SizeOf(Integer));

	// Wait until ChildProcess.exe terminate
	Pipe.Wait;

	// Read ChildProcess.exe content text (or error)
	Pipe.ReadAllData;
	Pipe.free;
end;
```

<hr width=”100%”>

``` pascal
	procedure Write(value: string); overload;
	procedure WriteA(value: AnsiString); overload;
```
> Function to write string in child process. The "WriteA" is for write a AnsiString; 

*Params:*
> - value(string for Write): WideString to write in child process;
> - value(AnsiString for WriteA): AnsiString to write in child process;

*Return:*
>  - None;

<hr width=”100%”>

``` pascal
	procedure Write(FmtString: string; Params: array of const); overload;	
	procedure WriteA(FmtString: AnsiString; Params: array of const); overload;
```
> Function to write string formated in child process. The "WriteA" is for write a AnsiString; 

*Params:*
> - FmtString(string for Write): WideString format to write in child process;
> - FmtString(AnsiString for WriteA): AnsiString format to write in child process;
> - Params(array of const): Any data variable or const to write.

*Return:*
>  - None;

*Example:*

``` pascal
procedure Main;
var 
	Pipe: TPipe;
begin		
	Pipe: TPipe.Create("ChildProcess.exe");	
	
	// Write "hello world" (WideString) in ChildProcess.exe
	Pipe.Write('hello world');

	// Write "hello world" (AnsiString) in ChildProcess.exe
	Pipe.WriteA('hello world');

	// Write "1 0xF 3.14" (WideString) in ChildProcess.exe
	Pipe.Write('%d 0x%x %f',[ 2, 15, 3.14]);

	// Write "1 0xF 3.14" (AnsiString) in ChildProcess.exe
	Pipe.WriteA('%d 0x%x %f',[ 2, 15, 3.14]);

	// Wait until ChildProcess.exe terminate
	Pipe.Wait;

	// Read ChildProcess.exe content text (or error)
	Pipe.ReadAllData;
	Pipe.free;
end;
```

<hr width=”100%”>

``` pascal
	procedure Write(value: byte); overload;	
```
> Function to write a single byte in child process.

*Params:*
> - value(byte): byte to write in child process;

*Return:*
>  - None;

<hr width=”100%”>

``` pascal
	procedure Write(value: AnsiChar); overload;	
```
> Function to write a single char (ansi, 0..255) in child process.

*Params:*
> - value(AnsiChar): char to write in child process;

*Return:*
>  - None;

<hr width=”100%”>

``` pascal
	procedure Write(value: DWORD); overload;
```
> Function to write a DWORD (cardinal) value in child process.

*Params:*
> - value(DWORD): value to write in child process;

*Return:*
>  - None;

*Example:*

``` pascal
procedure Main;
var 
	Pipe: TPipe;
begin		
	Pipe: TPipe.Create("ChildProcess.exe");	
	
	// Write 0xFF byte in ChildProcess.exe
	Pipe.Write($FF);

	// Write #32 char in ChildProcess.exe
	Pipe.Write(#32);

	// Write 1500 (unsigned) in ChildProcess.exe
	Pipe.Write(1500);

	// Wait until ChildProcess.exe terminate
	Pipe.Wait;

	// Read ChildProcess.exe content text (or error)
	Pipe.ReadAllData;
	Pipe.free;
end;
```

<hr width=”100%”>

``` pascal
	function ReadAllData: string;
```
> Function to read text from child process after it close (this function blocking and will wait for it close).

*Params:*
> - None;

*Return:*
>  - Result(string): Text from child process;

<hr width=”100%”>

``` pascal
	function Wait(Ms: DWord = INFINITE): boolean;
```
> Function to read text from child process after it close (this function blocking and will wait for it close).

*Params:*
> - Ms(DWord): Wait milliseconds until program close. DEFAULT: INFINITE = max Dword;

*Return:*
>  - Result(boolean): Return True if child process closed sucessfull before timeout. False if timout or closed by error;

<hr width=”100%”>

``` pascal
	function Kill: boolean;
```
> Function to force close child process;

*Params:*
> - None;

*Return:*
>  - Result(boolean): Return True if child process closed sucessfull otherwise return False;

*Example:*

``` pascal
procedure Main;
var 
	Pipe: TPipe;
begin		
	Pipe: TPipe.Create("ChildProcess.exe");	

	// Wait for 1s to ChildProcess.exe terminate, if not close it
	if not Pipe.Wait(1000) then
		Pipe.Kill;

	// Read ChildProcess.exe content text (or error)
	Pipe.ReadAllData;
	Pipe.free;
end;
```