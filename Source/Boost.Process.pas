unit Boost.Process;

interface

uses
  windows, system.classes, system.sysutils;

const
  BUFSIZE = 4096;

type
  TPipe = class
  private
    g_hChildStd_IN_Rd: THANDLE;
    g_hChildStd_IN_Wr: THANDLE;
    g_hChildStd_OUT_Rd: THANDLE;
    g_hChildStd_OUT_Wr: THANDLE;
    g_hInputFile, hParentStdOut: THANDLE;
    chBuf: array [0 .. BUFSIZE - 1] of AnsiChar;
    siStartInfo: TStartupInfoA;
    saAttr: TSecurityAttributes;
    dwRead, dwWritten: DWord;
    piProcInfo: TProcessInformation;
    bSuccess: boolean;
    class function NewSecurityAttributes: TSecurityAttributes;
    class function NewStartInfo(HRead, HWrite: THANDLE;
      Visible: boolean = false): TStartupInfoA;
    function Pipe(var HRead: THANDLE; var HWrite: THANDLE;
      UseWrite: boolean = false): boolean;
    class function Assert(state: boolean; Msg: string): boolean;
    function NewProcess(CommandLine: AnsiString;
      CurrentDirectory: AnsiString = ''): boolean;
  public
    // StdIn: THandle = 0; StdOut: THandle = 0;StdErr: THandle = 0
    procedure Write(const Buffer; Size: DWord); overload;
    procedure Write(value: string); overload;
    procedure Write(FmtString: string; Params: array of const); overload;
    procedure WriteA(value: AnsiString); overload;
    procedure WritelnA(value: AnsiString); overload;
    procedure WriteA(FmtString: AnsiString; Params: array of const); overload;
    procedure Write(value: byte); overload;
    procedure Write(value: AnsiChar); overload;
    procedure Write(value: DWord); overload;
    procedure Writeln(value: string);
    function Wait(Ms: DWord = INFINITE): boolean;
    function Run(CommandLine: string; CurrentDirectory: string = '';
      Visible: boolean = false): boolean;
    function ReadAllData(Func: TProc<string> = nil): string;
    function Kill: boolean;
    constructor Create; overload;
    constructor Create(CommandLine: string; CurrentDirectory: string = '';
      Visible: boolean = false); overload;
    destructor Destroy; override;
  end;

implementation

{ TPipe }

class function TPipe.Assert(state: boolean; Msg: string): boolean;
begin
  Result := state;
  if not Result then
    raise Exception.Create(Msg + ': ' + SysErrorMessage(GetLastError));
end;

constructor TPipe.Create;
begin
  saAttr := NewSecurityAttributes;
end;

constructor TPipe.Create(CommandLine: string; CurrentDirectory: string = '';
  Visible: boolean = false);
begin
  Create;
  Run(CommandLine, CurrentDirectory, Visible);
end;

destructor TPipe.Destroy;
begin
  CloseHandle(piProcInfo.hProcess);
  CloseHandle(piProcInfo.hThread);

  Assert(CloseHandle(g_hChildStd_IN_Wr), 'Fail on close handle StdInWr');
  inherited;
end;

function TPipe.Kill: boolean;
begin
  Assert(TerminateProcess(piProcInfo.hProcess, 0),
    'Fail on terminate child process: ');
end;

function TPipe.NewProcess(CommandLine: AnsiString;
  CurrentDirectory: AnsiString): boolean;
begin
  Result := CreateProcessA(nil, Pansichar(CommandLine), @saAttr, @saAttr, True,
    NORMAL_PRIORITY_CLASS, nil, Pansichar(CurrentDirectory), siStartInfo,
    piProcInfo);
end;

class function TPipe.NewSecurityAttributes: TSecurityAttributes;
begin
  with Result do
  begin
    nlength := SizeOf(TSecurityAttributes);
    binherithandle := True;
    lpsecuritydescriptor := nil;
  end;
end;

class function TPipe.NewStartInfo(HRead, HWrite: THANDLE; Visible: boolean)
  : TStartupInfoA;
begin
  FillChar(Result, SizeOf(TStartUpInfo), #0);
  Result.cb := SizeOf(TStartUpInfo);
  Result.wShowWindow := ord(Visible);
  Result.hStdError := HWrite;
  Result.hStdOutput := HWrite;
  Result.hStdInput := HRead;
  Result.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
end;

function TPipe.Pipe(var HRead: THANDLE; var HWrite: THANDLE;
  UseWrite: boolean = false): boolean;
var
  h: THANDLE;
begin
  Result := CreatePipe(HRead, HWrite, @saAttr, 0);
  if UseWrite then
    h := HWrite
  else
    h := HRead;

  if Result then
    Result := SetHandleInformation(h, HANDLE_FLAG_INHERIT, 0);
end;

function TPipe.ReadAllData(Func: TProc<string> = nil): string;
var
  hParentStdOut: THANDLE;
  data: string;
begin
  Result := '';
  hParentStdOut := GetStdHandle(STD_OUTPUT_HANDLE);
  repeat
    FillChar(chBuf, length(chBuf), #0);
    bSuccess := ReadFile(g_hChildStd_OUT_Rd, chBuf, BUFSIZE, dwRead, nil);

    if (not bSuccess or (dwRead = 0)) then
      break;
    data := string(chBuf);
    if Assigned(Func) then
      Func(data);
    Result := Result + data;
  until false;
end;

function TPipe.Run(CommandLine: string; CurrentDirectory: string = '';
  Visible: boolean = false): boolean;
var
  b: byte;
begin
  Assert(Pipe(g_hChildStd_OUT_Rd, g_hChildStd_OUT_Wr),
    'Failed to create pipe for standard input. System error message: ');

  Assert(Pipe(g_hChildStd_IN_Rd, g_hChildStd_IN_Wr, True),
    'Failed to create pipe for standard output. System error message: ');

  siStartInfo := NewStartInfo(g_hChildStd_IN_Rd, g_hChildStd_OUT_Wr, Visible);

  Assert(NewProcess(CommandLine, CurrentDirectory),
    'Failed creating the console process. System error msg: ');

  CloseHandle(g_hChildStd_OUT_Wr);
  CloseHandle(g_hChildStd_IN_Rd);
end;

procedure TPipe.Write(value: string);
begin
  Write(value, length(value) * 2);
end;

procedure TPipe.Write(const Buffer; Size: DWord);
begin
  Assert(WriteFile(g_hChildStd_IN_Wr, Buffer, Size, dwWritten, nil),
    'Error on write on child process: ');
end;

procedure TPipe.Writeln(value: string);
begin
  Write(value + #10);
end;

procedure TPipe.WritelnA(value: AnsiString);
begin
  WriteA(value + #10);
end;

function TPipe.Wait(Ms: DWord): boolean;
begin
  Result := 0 = WaitForSingleObject(g_hChildStd_OUT_Rd, Ms);
end;

procedure TPipe.Write(value: byte);
begin
  Assert(WriteFile(g_hChildStd_IN_Wr, value, 1, dwWritten, nil),
    'Error on write on child process: ');
end;

procedure TPipe.Write(value: DWord);
begin
  Assert(WriteFile(g_hChildStd_IN_Wr, value, 4, dwWritten, nil),
    'Error on write on child process: ');
end;

procedure TPipe.Write(FmtString: string; Params: array of const);
begin
  Write(Format(FmtString, Params).Replace('\n', #10));
end;

procedure TPipe.WriteA(FmtString: AnsiString; Params: array of const);
begin
  WriteA(Format(FmtString, Params).Replace('\n', #10));
end;

procedure TPipe.Write(value: AnsiChar);
begin
  write(ord(value));
end;

procedure TPipe.WriteA(value: AnsiString);
var
  i: integer;
begin

  for i := 1 to length(value) do
    chBuf[i - 1] := value[i];

  Assert(WriteFile(g_hChildStd_IN_Wr, chBuf, length(value), dwWritten, nil),
    'Error on write on child process: ');
end;

end.
