## `TDotEnv`

The TDotEnv is a library to manipulate ".env" files. This file is bare translate of node [DotEnv](https://www.npmjs.com/package/dotenv) library.

### Data

The output data has a [dictionary](https://github.com/MaiconSoft/DelphiBoostLib/blob/master/Source/Boost.Generics.Collection.pas) of strings

```pascal
  TDotEnvData = TDictionary<string, string>;
```

### Methods

<hr width=”100%”>

```pascal
  constructor Create; overload;
```

> Create a object with default parameters

- Path: _Current directory;_
- Override: _true_, any key duplicated will be override the previus value;
- Encodig: _utf8_.

_Example:_

```pascal
procedure Main;
var
	env: TDotEnv;
begin
  env.Create; // current dir, override and utf8
  env.Reload;

  if( env.data['ENABLE'] = 'true')then
    showmessage('Action is enable')
  else
    showmessage('Action is disable')
	env.free;
end;
```

<hr width=”100%”>

```pascal
  constructor Create(Path: string; aOverride: boolean = false); overload;
```

> Create a object with custom parameters

_Params:_

> - Path(String) = Directory of .env file;
> - aOverride(Boolean) = True = any key duplicated will be override the previus value. False = any key duplicated will be ignored.

_Example:_

```pascal
procedure Main;
var
	env: TDotEnv;
begin
	env.Create('c:\configs', false); // "c:\configs\.env", not override and utf8
  env.Reload;

  if( env.data['ENABLE'] = 'true')then
    showmessage('Action is enable')
  else
    showmessage('Action is disable')
	env.free;
end;
```

<hr width=”100%”>

```pascal
  procedure Reload;
```

> Reload data from .env file.

_Example:_

```pascal
procedure Main;
var
	env: TDotEnv;
begin
	env.Create; // current dir, override and utf8
  env.Reload;

  if( env.data['ENABLE'] = 'true')then
    showmessage('Action is enable')
  else
    showmessage('Action is disable')
	env.free;
end;
```

<hr width=”100%”>

```pascal
  property Data: TDotEnvData;
```

> Readonly proprerty with all data from .env. Call "Reaload();" to update.

_Example:_

```pascal
procedure Main;
var
	env: TDotEnv;
begin
  env.Create; // current dir, override and utf8
  env.Reload;

  if( env.data['ENABLE'] = 'true')then
    showmessage('Action is enable')
  else
    showmessage('Action is disable')
	env.free;
end;
```

<hr width=”100%”>

```pascal
  property Path: string;
```

> Get or set the path from .env.

_Example:_

```pascal
procedure Main;
var
	env: TDotEnv;
begin
  env.Create; // current dir, override and utf8
  env.path := 'c:\config'; // change directory to "c:\config"
  env.Reload;

  if( env.data['ENABLE'] = 'true')then
    showmessage('Action is enable')
  else
    showmessage('Action is disable')
	env.free;
end;
```

<hr width=”100%”>

```pascal
  property Encoding: TEncoding;
```

> Get or set the encoding type from .env file.

_Example:_

```pascal
procedure Main;
var
	env: TDotEnv;
begin
  env.Create; // current dir, override and utf8

  env.Encoding := TEncoding.ASCII; // change to ascii
  env.Reload;

  if( env.data['ENABLE'] = 'true')then
    showmessage('Action is enable')
  else
    showmessage('Action is disable')
	env.free;
end;
```

<hr width=”100%”>

```pascal
  property aOverride: bool;
```

> Enable or disable override values of keys duplicated.

_Example:_

```pascal
procedure Main;
var
	env: TDotEnv;
begin
  env.Create; // current dir, override and utf8

  env.aOverride := false; // keys dup will be ignored
  env.Reload;

  if( env.data['ENABLE'] = 'true')then
    showmessage('Action is enable')
  else
    showmessage('Action is disable')
	env.free;
end;
```

<hr width=”100%”>

```pascal
  function Parse(aLine: string; aOverride: boolean = True): TDotEnvData;
```

> This function can be used to parse .env raw data in directory. None configuration defined will be applayed.

_Params:_

> - aLine(String) = Raw data from .env in string format;
> - aOverride(Boolean, Optional) = _true_, any key duplicated will be override the previus value;

_Example:_

```pascal
procedure Main;
var
	env: TDotEnv;
const
  RAW_DATA = 'ENABLE=true'#13'DEBUG=false'#13'COUNT=5'
begin
	env.Create;
  var data = env.Parse(RAW_DATA);

  if( data['ENABLE'] = 'true')then
    showmessage('Action is enable by '+data['COUNT']+' times')
    // Action is enable by 5 times
  else
    showmessage('Action is disable')
	env.free;
end;
```
