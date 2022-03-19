unit Boost.Token;

interface

uses
  System.SysUtils, System.Classes;

type
  TSetOfAnsiChar = set of AnsiChar;

  TToken = record
  private
    FBuffer: TStream;
    FIsTerminated: boolean;
  public
    constructor Create(Buffer: TStream);
    procedure Reset;
    procedure Back(steps: Cardinal = 1);
    procedure forward(steps: Cardinal = 1);
    function ReadChar: Char;
    function ReadAnsiChar: AnsiChar;
    function ReadByte: Byte;
    function ReadWord: Word;
    function ReadStrNumberA(var Number: Extended; DecimalSeparator: AnsiChar =
      '.'): boolean;
    function ReadStrNumber(var Number: Extended; DecimalSeparator: Char = '.'): boolean;
    function ReadUntilA(chars: AnsiString): AnsiString; overload;
    function ReadUntilA(chars: TSetOfAnsiChar): AnsiString; overload;
    function ReadUntil(chars: string): string;
    function ReadWhileA(chars: AnsiString): AnsiString; overload;
    function ReadWhileA(chars: TSetOfAnsiChar): AnsiString; overload;
    function ReadWhile(chars: string): string; overload;
    procedure SkipSpace;
    procedure SkipSpaceA;
  end;

implementation
  { TToken }

procedure TToken.Back(steps: Cardinal);
begin
  FBuffer.Seek(-steps, soFromCurrent);
end;

constructor TToken.Create(Buffer: TStream);
begin
  fBuffer := Buffer;
  FIsTerminated := false;
end;

procedure TToken.forward(steps: Cardinal);
begin
  FBuffer.Seek(steps, soFromCurrent);
end;

function TToken.ReadAnsiChar: AnsiChar;
begin
  FIsTerminated := FBuffer.Read(Result, 1) = 0;
end;

function TToken.ReadByte: byte;
begin
  FIsTerminated := FBuffer.Read(Result, 1) = 0;
end;

function TToken.ReadChar: char;
begin
  FIsTerminated := FBuffer.Read(Result, sizeOF(char)) = 0;
end;

function TToken.ReadStrNumber(var Number: Extended; DecimalSeparator: Char): boolean;
var
  val: string;
begin
  val := ReadWhile('0123456789+-eE' + DecimalSeparator);

  if DecimalSeparator <> FormatSettings.DecimalSeparator then
    val := StringReplace(val, DecimalSeparator, FormatSettings.DecimalSeparator, []);

  Result := TryStrToFloat(val, Number);
end;

function TToken.ReadStrNumberA(var Number: Extended; DecimalSeparator: AnsiChar
  = '.'): boolean;
var
  val: AnsiString;
begin
  val := ReadWhileA(['0'..'9', '-', '+', 'e', 'E', DecimalSeparator]);

  if DecimalSeparator <> AnsiChar(FormatSettings.DecimalSeparator) then
    val := StringReplace(val, DecimalSeparator, FormatSettings.DecimalSeparator, []);

  Result := TryStrToFloat(val, Number);
end;

function TToken.ReadUntil(chars: string): string;
var
  c: Char;
begin
  Result := '';
  repeat
    c := ReadChar;
    if pos(c, chars) > 0 then
    begin
      Back;
      Break;
    end;
    Result := Result + c;
  until FIsTerminated;
end;

function TToken.ReadUntilA(chars: TSetOfAnsiChar): AnsiString;
var
  c: Ansichar;
begin
  Result := '';
  repeat
    c := ReadAnsiChar;
    if c in chars then
    begin
      Back;
      Break;
    end;
    Result := Result + c;
  until FIsTerminated;
end;

function TToken.ReadUntilA(chars: AnsiString): AnsiString;
var
  c: Ansichar;
begin
  Result := '';
  repeat
    c := ReadAnsiChar;
    if pos(c, chars) > 0 then
    begin
      Back;
      Break;
    end;
    Result := Result + c;
  until FIsTerminated;
end;

function TToken.ReadWhile(chars: string): string;
var
  c: Char;
begin
  Result := '';
  repeat
    c := ReadChar;
    if pos(c, chars) = 0 then
    begin
      Back;
      Break;
    end;
    Result := Result + c;
  until FIsTerminated;
end;

function TToken.ReadWhileA(chars: TSetOfAnsiChar): AnsiString;
var
  c: Ansichar;
begin
  Result := '';
  repeat
    c := ReadAnsiChar;
    if not (c in chars) then
    begin
      Back;
      Break;
    end;
    Result := Result + c;
  until FIsTerminated;
end;

function TToken.ReadWord: Word;
begin
  FIsTerminated := FBuffer.Read(Result, 1) = 0;
end;

function TToken.ReadWhileA(chars: AnsiString): AnsiString;
var
  c: Ansichar;
begin
  Result := '';
  repeat
    c := ReadAnsiChar;
    if pos(c, chars) = 0 then
    begin
      Back;
      Break;
    end;
    Result := Result + c;
  until FIsTerminated;
end;

procedure TToken.Reset;
begin
  FBuffer.Seek(0, soFromBeginning);
end;

procedure TToken.SkipSpace;
begin
  ReadWhile(' ');
end;

procedure TToken.SkipSpaceA;
begin
  ReadWhileA([#32, #09..#13]);
end;

end.

