unit Boost.Dotenv;

interface

uses
  Winapi.Windows, System.sysUtils, Boost.Generics.Collection, System.IOUtils,
  System.RegularExpressions;

const
  ENV_FILE = '.env';
  LINE = '(?:^|^)\s*(?:export\s+)?([\w.-]+)(?:\s*=\s*?|:\s+?)(\s*''(?:\\''|[^''])*''|\s*"(?:\\"|[^"])*"|\s*`(?:\\`|[^`])*`|[^#\r\n]+)?\s*(?:#.*)?(?:$|$)';

Type
  TDotEnvData = TDictionary<string, string>;

  TDotEnv = class
  private
    FData: TDotEnvData;
    FPath: string;
    FaOverride: bool;
    FEncoding: TEncoding;
    function GetEnvFileName(): string;
    class function ClearValue(value: string): string;
  public
    constructor Create; overload;
    constructor Create(Path: string; aOverride: boolean = false); overload;
    procedure Reload;
    function Parse(aLine: string; aOverride: boolean = True): TDotEnvData;
    property Data: TDotEnvData read FData;
    property Path: string read FPath write FPath;
    property Encoding: TEncoding read FEncoding write FEncoding;
    property aOverride: bool read FaOverride write FaOverride;
  end;

implementation

{ TDotEnv }

class function TDotEnv.ClearValue(value: string): string;
begin
  Result := value.Trim.DeQuotedString('"').Replace('\\n', #13)
    .Replace('\\r', #10);

end;

constructor TDotEnv.Create(Path: string; aOverride: boolean = false);
begin
  FPath := IncludeTrailingPathDelimiter(Path);
  FaOverride := aOverride;
end;

constructor TDotEnv.Create;
begin
  FPath := IncludeTrailingPathDelimiter(TDirectory.GetCurrentDirectory);
  FEncoding := TEncoding.UTF8;
  FaOverride := true;
end;

function TDotEnv.GetEnvFileName: string;
begin
  Result := Path + ENV_FILE;
end;

function TDotEnv.Parse(aLine: string; aOverride: boolean = True): TDotEnvData;
var
  aMatch: TMatch;
  aKey, aValue: string;
  res: TDotEnvData;
begin
  res.init;

  with TRegEx.Create(LINE, [roMultiLine]) do
  begin
    aMatch := Match(aLine.Replace(#10#13, #10, [rfReplaceAll]));
    with aMatch do
    begin
      while Success do
        with res do
        begin
          aKey := Groups[1].value;

          if (Groups.Count > 2) then
            aValue := Groups[2].value
          else
            aValue := '';
          if (aOverride or (not HasKey(aKey))) then
            Add(aKey, ClearValue(aValue));
          aMatch := NextMatch;
        end;
    end;
  end;
  Result := res;
end;

procedure TDotEnv.Reload();
var
  content: string;
begin
  if (not TFile.Exists(GetEnvFileName)) then
    exit;

  content := TFile.ReadAllText(GetEnvFileName, TEncoding.UTF8);

  FData := Parse(content);

end;

end.
