program XMLFormatter;

{$APPTYPE CONSOLE}

{$R *.res}

uses
    Classes
  , SysUtils
  , OmniXML
  ;

procedure FormatXMLFile(FileName: string);
begin
  with CreateXMLDoc do begin
    PreserveWhiteSpace := False;
    Load(FileName);
    Save(FileName, ofIndent);
  end;
end;

procedure ShowTitle;
begin
  WriteLn;
  WriteLn('==================');
  WriteLn('XML Formatter v1.0');
  WriteLn('==================');
  WriteLn;
end;

procedure ShowFooter;
begin
  WriteLn;
  WriteLn('------------------------------------');
  WriteLn('XMLFormatter v1.0 2017 © Nuno Picado');
  WriteLn;
  WriteLn;
end;

procedure FormatXMLFiles;
var
  i: Integer;
begin
  ShowTitle;
  for i := 1 to ParamCount do begin
    Write(Format('A formatar "%s"... ', [ParamStr(i)]));
    FormatXMLFile(ParamStr(i));
    WriteLn('Feito.');
  end;
  ShowFooter;
end;

procedure ShowHelp;
begin
  ShowTitle;
  WriteLn('Modo de utilização:');
  WriteLn('   XMLFormatter file1.xml [file2.xml file3.xml ...]');
  WriteLn;
  WriteLn('Os ficheiros originais serão subsituídos por uma versão formatada/indentada dos mesmos.');
  ShowFooter;
end;

begin
  {$IFDEF DEBUG}
    ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

  if ParamCount > 0 then begin
    FormatXMLFiles;
  end
  else begin
    ShowHelp;
  end;
end.
