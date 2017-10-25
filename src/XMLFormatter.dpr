program XMLFormatter;

{$APPTYPE CONSOLE}

{$R *.res}

uses
    Classes
  , SysUtils
  , OmniXML
  ;

type
  TParams = record
    ReplaceFile: Boolean;
    FileList: array of string;
  end;

procedure FormatXMLFile(FileName: string; Target: string = '');
begin
  if Target.IsEmpty then begin
    Target := FileName;
  end;

  with CreateXMLDoc do begin
    PreserveWhiteSpace := False;
    Load(FileName);
    Save(Target, ofIndent);
  end;
end;

procedure ShowTitle;
begin
  WriteLn;
  WriteLn('==================');
  WriteLn('XML Formatter v1.1');
  WriteLn('==================');
  WriteLn;
end;

procedure ShowFooter;
begin
  WriteLn;
  WriteLn('------------------------------------');
  WriteLn('XMLFormatter v1.1 2017 © Nuno Picado');
  WriteLn;
  WriteLn;
end;

function TargetFileName(FileName: string): string;
begin
  Result := Format(
    '%sFormatted_%s',
    [
      ExtractFilePath(FileName),
      ExtractFileName(FileName)
    ]
  );
end;

procedure FormatXMLFiles(Params: TParams);
var
  i: Integer;
begin
  ShowTitle;
  for i := 0 to Pred(Length(Params.FileList)) do begin
    Write(Format('A formatar "%s"... ', [Params.FileList[i]]));
    if Params.ReplaceFile then begin
      FormatXMLFile(Params.FileList[i]);
    end
    else begin
      FormatXMLFile(
        Params.FileList[i],
        TargetFileName(Params.FileList[i])
      );
    end;
    WriteLn('Feito.');
  end;
  ShowFooter;
end;

procedure ShowHelp;
begin
  ShowTitle;
  WriteLn('Modo de utilização:');
  WriteLn('   XMLFormatter [/r] file1.xml [file2.xml file3.xml ...]');
  WriteLn;
  WriteLn('   /r         Substitui os ficheiros originais pela versão formatada/indentada dos mesmos.');
  WriteLn('   file?.xml  Ficheiro a formatar/indentar.');
  ShowFooter;
end;

function ParseParams: TParams;
var
  i: Integer;
begin
  SetLength(Result.FileList, 0);
  for i := 1 to ParamCount do begin
    if UpperCase(ParamStr(i)) = '/R' then begin
      Result.ReplaceFile := True
    end;
    if FileExists(ParamStr(i)) then begin
      SetLength(Result.FileList, Length(Result.FileList) + 1);
      Result.FileList[Length(Result.FileList) - 1] := ParamStr(i);
    end;
  end;
end;

begin
  {$IFDEF DEBUG}
    ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

  if ParamCount > 0 then begin
    FormatXMLFiles(ParseParams);
  end
  else begin
    ShowHelp;
  end;
end.
