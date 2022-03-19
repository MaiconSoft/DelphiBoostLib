unit Boost.Store;

interface

uses
  Sysutils, Classes, IniFiles, Boost.Generics.Collection;

const
  DEFAULT_DOUBLE = 0.0;
  DEFAULT_DATETIME = 0.0;
  DEFAULT_INTEGER = 0;
  DEFAULT_STRING = '';

type
  TStore = class
  private
    FInifile: TInifile;
    FReduceMemory: Boolean;
    FData: TDictionary<string, Variant>;
    constructor Create;
    destructor Destroy; override;
    function GetInifile: TInifile;
    procedure Update;
    procedure DisposeInifile;
    function GetGeneric(Key: string; def: variant): variant;
    procedure SetGeneric(Key: string; value: variant);
    function GetGenericStream(Key: string): TStream;
    procedure SetGenericStream(Key: string; value: TStream);
    function GetDoubleDefault(Key: string; Default: double): Double;
    function GetDouble(Key: string): Double;
    procedure SetDouble(Key: string; const Value: Double);
    function GetStringDefault(Key, Default: string): string;
    function GetString(Key: string): string;
    procedure SetString(Key: string; const Value: string);
    function GetIntegerDefault(Key: string; Default: Integer): Integer;
    function GetInteger(Key: string): Integer;
    procedure SetInteger(Key: string; const Value: Integer);
    function GetDateTimeDef(Key: string; default: TDateTime): TDateTime;
    function GetDateTime(Key: string): TDateTime;
    procedure SetDateTime(Key: string; const Value: TDateTime);
    function GetStream(Key: string): TStream;
    procedure SetStream(Key: string; const Value: TStream);
  public
    property AsFloatDef[Key: string; Default: double]: Double read GetDoubleDefault;
    property AsFloat[Key: string]: Double read GetDouble write SetDouble;
    property AsStrDef[Key: string; Default: string]: string read GetStringDefault;
    property AsStr[Key: string]: string read GetString write SetString;
    property AsIntDef[Key: string; Default: Integer]: Integer read GetIntegerDefault;
    property AsInt[Key: string]: Integer read GetInteger write SetInteger;
    property AsDateTimeDef[Key: string; default: TDateTime]: TDateTime read
      GetDateTimeDef;
    property AsDateTime[Key: string]: TDateTime read GetDateTime write SetDateTime;
    property AsStream[Key: string]: TStream read GetStream write SetStream;
    property ReduceMemory: Boolean read FReduceMemory write FReduceMemory;
  end;

var
  Store: TStore = nil;

implementation

const
  SEASON = 'VARIABLES';

procedure RegisterStore;
begin
  Store := TStore.create;
end;

procedure UnregisterStore;
begin
  if Assigned(Store) then
    Store.Free;
end;

{ TStore }

constructor TStore.Create;
begin
  ReduceMemory := false;
  FData.Init;
end;

destructor TStore.Destroy;
begin
  DisposeInifile;
  inherited;
end;

procedure TStore.DisposeInifile;
begin
  if Assigned(FInifile) then
  begin
    FInifile.Free;
    FInifile := nil;
  end;
end;

function TStore.GetDateTime(Key: string): TDateTime;
begin
  Result := GetDateTimeDef(Key, DEFAULT_DATETIME);
end;

function TStore.GetDateTimeDef(Key: string; default: TDateTime): TDateTime;
begin
  Result := GetDoubleDefault(Key, default);
end;

function TStore.GetDouble(Key: string): Double;
begin
  Result := GetDoubleDefault(Key, DEFAULT_DOUBLE);
end;

function TStore.GetDoubleDefault(Key: string; Default: double): Double;
begin
  Result := GetGeneric(Key, Default);
end;

function TStore.GetGeneric(Key: string; def: variant): variant;
begin
  var a := 0;
  if FData.HasKey(Key) then
    exit(fdata[Key]);

  Result := GetInifile.ReadString(SEASON, Key, def);
  FData.Add(Key, Result);
end;

function TStore.GetGenericStream(Key: string): TStream;
begin
  Result := TMemoryStream.Create;
  GetInifile.ReadBinaryStream(SEASON, Key, Result);
end;

function TStore.GetInifile: TInifile;
begin
  if not Assigned(FInifile) then
    FInifile := TIniFile.Create(ChangeFileExt(ParamStr(0), '.store.ini'));
  result := FInifile;
end;

function TStore.GetInteger(Key: string): Integer;
begin
  Result := GetIntegerDefault(Key, DEFAULT_INTEGER);
end;

function TStore.GetIntegerDefault(Key: string; Default: Integer): Integer;
begin
  Result := GetGeneric(Key, Default);
end;

function TStore.GetStream(Key: string): TStream;
begin
  Result := GetGenericStream(Key);
end;

function TStore.GetString(Key: string): string;
begin
  Result := GetStringDefault(Key, DEFAULT_STRING)
end;

function TStore.GetStringDefault(Key, Default: string): string;
begin
  Result := GetGeneric(Key, Default);
end;

procedure TStore.SetDateTime(Key: string; const Value: TDateTime);
begin
  SetDouble(Key, Value);
end;

procedure TStore.SetDouble(Key: string; const Value: Double);
begin
  SetGeneric(Key, Value);
end;

procedure TStore.SetGeneric(Key: string; value: variant);
begin
  var has := FData.HasKey(Key);
  if FData.HasKey(Key) then
    if FData.Item[Key] = value then
      exit;

  FData.Add(Key, value);
  GetInifile.WriteString(SEASON, Key, value);
end;

procedure TStore.SetGenericStream(Key: string; value: TStream);
begin
  GetInifile.WriteBinaryStream(SEASON, Key, value);
end;

procedure TStore.SetInteger(Key: string; const Value: Integer);
begin
  SetGeneric(Key, Value);
end;

procedure TStore.SetStream(Key: string; const Value: TStream);
begin
  SetGenericStream(Key, Value);
end;

procedure TStore.SetString(Key: string; const Value: string);
begin
  SetGeneric(Key, Value);
end;

procedure TStore.Update;
begin
  if Assigned(FInifile) then
  begin
    FInifile.UpdateFile;
    if ReduceMemory then
      DisposeInifile;
  end;
end;

initialization
  RegisterStore;

finalization
  UnregisterStore;

end.

