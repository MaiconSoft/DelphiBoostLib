## `Store`

This object is a instace auto initialized of **TStore** class, developed for manipulate persistent data. The system base is the class TInifiles, storing data in a file with name _AppName.store.ini_, where AppName is the name of application.

Inifiles has a know limitation of 256 chars for eatch value.

### Const defaults<div id="CONST_DEFAULT"/>

constant default returned in conversion fail.

- DEFAULT_DOUBLE = 0.0;
- DEFAULT_DATETIME = 0.0;
- DEFAULT_INTEGER = 0;
- DEFAULT_STRING = '';

### Methods

<hr width=”100%”>

```pascal
 property AsFloat[Key: string]: Double read GetDoubleDefault;
```

> Get and set a Double value, by a indent key.

_Params:_

> - Key(String): Key for indetify the variable data;

_Return:_

> Result(Double):
>
> - When used as property get, return a value stored indexed by key, if it exist
> - Else: return [DEFAULT_DOUBLE](#CONST_DEFAULT)

_Example:_

```pascal
procedure Main;
  var
    previusRation: double;
begin

  // Read a stored RATIO, or return DEFAULT_DOUBLE (0.0)
  previusRation = Store.AsFloat['RATIO'];

  if(previusRation < 2.5) then
  begin
    // Store the value 2.55 in RATIO
    Store.AsFloat['RATIO'] := 2.55;
  end;

end;
```

<hr width=”100%”>

```pascal
property AsFloatDef[Key: string; Default: double]: Double read GetDoubleDefault;
```

> Get a Double value, by a indent key, but can pass a default value in case of fail.

_Params:_

> - Key(String): Key for indetify the variable data;
> - Default(double): value returned in case of fail;

_Return:_

> Result(Double):
>
> - When used as property get, return a value stored indexed by key, if it exist
> - Else: return _Default_ parameter.

_Example:_

```pascal
procedure Main;
  var
    previusRation: double;
begin

  // Read a stored RATIO, or return 3.2
  previusRation = Store.AsFloatDef['RATIO',3.2];

  if(previusRation > 2.5) then
  begin
    // Store the value 2.55 in RATIO
    Store.AsFloat['RATIO'] := 2.55;
  end;

end;
```

<hr width=”100%”>

```pascal
 property AsStr[Key: string]: string read GetString write SetString;
```

> Get and set a String value, by a indent key.

_Params:_

> - Key(String): Key for indetify the variable data;

_Return:_

> Result(String):
>
> - When used as property get, return a value stored indexed by key, if it exist
> - Else: return [DEFAULT_STRING](#CONST_DEFAULT)

_Example:_

```pascal
procedure Main;
  var
    userName:string;
begin

  // Read a stored USER_NAME, or return DEFAULT_STRING ('')
  userName = Store.AsStr['USER_NAME'];

  if(userName = '') then
  begin
    userName := 'unknown'
    // Store the value 'unknown' in USER_NAME
    Store.AsStr['USER_NAME'] := userName;
  end;
end;
```

<hr width=”100%”>

```pascal
property AsStrDef[Key: string; Default: string]: string read GetStringDefault;
```

> Get a String value, by a indent key, but can pass a default value in case of fail.

_Params:_

> - Key(String): Key for indetify the variable data;
> - Default(String): value returned in case of fail;

_Return:_

> Result(String):
>
> - When used as property get, return a value stored indexed by key, if it exist
> - Else: return _Default_ parameter.

_Example:_

```pascal
procedure Main;
  var
    userName:string;
begin

  // Read a stored USER_NAME, or return 'unknown'
  userName = Store.AsStrDef['USER_NAME','unknown'];
end;
```

<hr width=”100%”>

```pascal
property AsInt[Key: string]: Integer read GetInteger write SetInteger;
```

> Get and set a Integer value, by a indent key.

_Params:_

> - Key(String): Key for indetify the variable data;

_Return:_

> Result(Integer):
>
> - When used as property get, return a value stored indexed by key, if it exist
> - Else: return [DEFAULT_INTEGER](#CONST_DEFAULT)

_Example:_

```pascal
procedure Main;
  var
    waterLevel:integer;
begin

  // Read a stored WATER_LEVEL, or return DEFAULT_INTEGER (0)
  waterLevel = Store.AsInt['WATER_LEVEL'];

  if(waterLevel < 100) then
  begin
    inc(waterLevel);

    // Store the value of waterLevel in WATER_LEVEL
    Store.AsInt['WATER_LEVEL'] := waterLevel;
  end;
end;
```

<hr width=”100%”>

```pascal
property AsIntDef[Key: string; Default: Integer]: Integer read GetIntegerDefault;
```

> Get a Integer value, by a indent key, but can pass a default value in case of fail.

_Params:_

> - Key(String): Key for indetify the variable data;
> - Default(Integer): value returned in case of fail;

_Return:_

> Result(Integer):
>
> - When used as property get, return a value stored indexed by key, if it exist
> - Else: return _Default_ parameter.

_Example:_

```pascal
procedure Main;
  var
    waterLevel:integer;
begin

  // Read a stored WATER_LEVEL, or return 10
  waterLevel = Store.AsIntDef['WATER_LEVEL',10];

  if(waterLevel < 100) then
  begin
    inc(waterLevel);

    // Store the value of waterLevel in WATER_LEVEL
    Store.AsInt['WATER_LEVEL'] := waterLevel;
  end;
end;
```

<hr width=”100%”>

```pascal
property AsDateTime[Key: string]: TDateTime read GetDateTime write SetDateTime;
```

> Get and set a Datetime value, by a indent key.

_Params:_

> - Key(String): Key for indetify the variable data;

_Return:_

> Result(Datetime):
>
> - When used as property get, return a value stored indexed by key, if it exist
> - Else: return [DEFAULT_DATETIME](#CONST_DEFAULT)

_Example:_

```pascal
procedure Main;
  var
    lastRun:TDateTime;
    timeAway:string;
begin

  // Read a stored LAST_RUN, or return DEFAULT_DATETIME (0.0)
  lastRun = Store.AsDateTime['LAST_RUN'];

  if(lastRun = DEFAULT_DATETIME) then
    lastRun := now;

  timeAway := FormatDateTime('mm-dd-yyyy hh:nn:ss', now - lastRun);

  Store.AsDateTime['LAST_RUN'] := lastRun;

end;
```

<hr width=”100%”>

```pascal
 property AsDateTimeDef[Key: string; default: TDateTime]: TDateTime read
      GetDateTimeDef;
```

> Get a Datetime value, by a indent key, but can pass a default value in case of fail.

_Params:_

> - Key(String): Key for indetify the variable data;
> - Default(Datetime): value returned in case of fail;

_Return:_

> Result(Datetime):
>
> - When used as property get, return a value stored indexed by key, if it exist
> - Else: return _Default_ parameter.

_Example:_

```pascal
procedure Main;
  var
    lastRun:TDateTime;
    timeAway:string;
begin

  // Read a stored LAST_RUN, or return now
  lastRun = Store.AsDateTimeDef['LAST_RUN',now];

  timeAway := FormatDateTime('mm-dd-yyyy hh:nn:ss', now - lastRun);

  Store.AsDateTime['LAST_RUN'] := lastRun;

end;
```

<hr width=”100%”>

```pascal
  property SetAsStream[Key: string]: TStream write SetStream;
```

> Set a TStream (and inherited classes) value, by a indent key.

_Params:_

> - Key(String): Key for indetify the variable data;

_Example:_

```pascal
procedure Main;
  var
    mem:TMemoryStream;
    data: TArray<byte>;
begin

  // sample
  data := [0, 1, 2, Ord('A')];

  mem := TMemoryStream.create;
  mem.write(data,length(data));

  // store a mem data
  Store.SetAsStream['INFO'] := mem;

  mem.free;
end;
```

<hr width=”100%”>

```pascal
    property GetAsStream[Key: string]: TStream write GetStream;
```

> Get a TStream (and inherited classes) value, by a indent key.

_Params:_

> - Key(String): Key for indetify the variable data;

_Example:_

```pascal
procedure Main;
  var
    mem:TMemoryStream;
    data: TArray<byte>;
begin

  mem := TMemoryStream.create;

  // read a mem data
  Store.GetAsStream['INFO'] := mem;

  setLength(data,mem.size);
  mem.read(data,length(data));

  mem.free;
end;
```

<hr width=”100%”>

```pascal
property ReduceMemory: Boolean read FReduceMemory write FReduceMemory;
```

> Configuration to dispose (free) TInifile every time write/read data, enable this parameter can reduce a use of memory,but cust a constant load of file. For default this parameter is false.

_Value(boolean):_

> - False (Default): Stay Inifile opened until application terminate;
> - True: Open and Close Inifile every acess to it.

_Example:_

```pascal
procedure Main;
begin
  Store.ReduceMemory = True;

  ...
end;
```
