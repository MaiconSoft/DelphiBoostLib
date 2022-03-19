unit Boost.Store;

interface

uses
  Sysutils, x, Classes, IniFiles, Boost.Generics.Collection, System.NetEncoding;

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
    function GetGeneric(Key: string; def: Variant): Variant;
    procedure SetGeneric(Key: string; value: Variant);
    function GetGenericStream(Key: string; value: TStream): TStream;
    procedure SetGenericStream(Key: string; value: TStream);
    function GetDoubleDefault(Key: string; Default: double): double;
    function GetDouble(Key: string): double;
    procedure SetDouble(Key: string; const value: double);
    function GetStringDefault(Key, Default: string): string;
    function GetString(Key: string): string;
    procedure SetString(Key: string; const value: string);
    function GetIntegerDefault(Key: string; Default: Integer): Integer;
    function GetInteger(Key: string): Integer;
    procedure SetInteger(Key: string; const value: Integer);
    function GetDateTimeDef(Key: string; Default: TDateTime): TDateTime;
    function GetDateTime(Key: string): TDateTime;
    procedure SetDateTime(Key: string; const value: TDateTime);
    procedure GetStream(Key: string; value: TStream);
    procedure SetStream(Key: string; const value: TStream);
  public
    property AsFloatDef[Key: string; Default: double]: double
      read GetDoubleDefault;
    property AsFloat[Key: string]: double read GetDouble write SetDouble;
    property AsStrDef[Key: string; Default: string]: string
      read GetStringDefault;
    property AsStr[Key: string]: string read GetString write SetString;
    property AsIntDef[Key: string; Default: Integer]: Integer
      read GetIntegerDefault;
    property AsInt[Key: string]: Integer read GetInteger write SetInteger;
    property AsDateTimeDef[Key: string; default: TDateTime]: TDateTime
      read GetDateTimeDef;
    property AsDateTime[Key: string]: TDateTime read GetDateTime
      write SetDateTime;
    property SetAsStream[Key: string]: TStream write SetStream;
    property GetAsStream[Key: string]: TStream write GetStream;
    property ReduceMemory: Boolean read FReduceMemory write FReduceMemory;
  end;

var
  Store: TStore = nil;

implementation

const
  SEASON = 'VARIABLES';

procedure RegisterStore;
begin
  Store := TStore.Create;
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

function TStore.GetDateTimeDef(Key: string; Default: TDateTime): TDateTime;
begin
  Result := GetDoubleDefault(Key, default);
end;

function TStore.GetDouble(Key: string): double;
begin
  Result := GetDoubleDefault(Key, DEFAULT_DOUBLE);
end;

function TStore.GetDoubleDefault(Key: string; Default: double): double;
begin
  Result := GetGeneric(Key, Default);
end;

function TStore.GetGeneric(Key: string; def: Variant): Variant;
begin
  var
  a := 0;
  if FData.HasKey(Key) then
    exit(FData[Key]);

  Result := GetInifile.ReadString(SEASON, Key, def);
  FData.Add(Key, Result);
end;

function TStore.GetGenericStream(Key: string; value: TStream): TStream;
var
  data: TArray<byte>;
  code: string;
begin
  code := GetGeneric(Key, '');

  if (code = '') then
    exit;

  data := TNetEncoding.Base64.DecodeStringToBytes(code);

//  value.Seek(0, 0);
  value.Write(data, Length(data));
end;

function TStore.GetInifile: TInifile;
begin
  if not Assigned(FInifile) then
    FInifile := TInifile.Create(ChangeFileExt(ParamStr(0), '.store.ini'));
  Result := FInifile;
end;

function TStore.GetInteger(Key: string): Integer;
begin
  Result := GetIntegerDefault(Key, DEFAULT_INTEGER);
end;

function TStore.GetIntegerDefault(Key: string; Default: Integer): Integer;
begin
  Result := GetGeneric(Key, Default);
end;

procedure TStore.GetStream(Key: string; value: TStream);
begin
  GetGenericStream(Key, value);
end;

function TStore.GetString(Key: string): string;
begin
  Result := GetStringDefault(Key, DEFAULT_STRING)
end;

function TStore.GetStringDefault(Key, Default: string): string;
begin
  Result := GetGeneric(Key, Default);
end;

procedure TStore.SetDateTime(Key: string; const value: TDateTime);
begin
  SetDouble(Key, value);
end;

procedure TStore.SetDouble(Key: string; const value: double);
begin
  SetGeneric(Key, value);
end;

procedure TStore.SetGeneric(Key: string; value: Variant);
begin
  var
  has := FData.HasKey(Key);
  if FData.HasKey(Key) then
    if FData.Item[Key] = value then
      exit;

  FData.Add(Key, value);
  GetInifile.WriteString(SEASON, Key, value);
end;

procedure TStore.SetGenericStream(Key: string; value: TStream);
var
  data: TArray<byte>;
  code: string;
  size: Int64;
begin
  size := value.size;
  value.Seek(0, 0);
  SetLength(data, size);
  value.Read(data, size);

  code := TNetEncoding.Base64.EncodeBytesToString(data, size);

  SetString(Key, code);
end;

procedure TStore.SetInteger(Key: string; const value: Integer);
begin
  SetGeneric(Key, value);
end;

procedure TStore.SetStream(Key: string; const value: TStream);
begin
  SetGenericStream(Key, value);
end;

procedure TStore.SetString(Key: string; const value: string);
begin
  SetGeneric(Key, value);
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
