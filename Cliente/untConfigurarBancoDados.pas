unit untConfigurarBancoDados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IniFiles;

type
  TfrmConfigurarBancoDados = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnOk: TButton;
    lblServidor: TLabel;
    edtServidor: TEdit;
    lblBancoDados: TLabel;
    edtBancoDados: TEdit;
    lblUsuario: TLabel;
    edtUsuario: TEdit;
    lblSenha: TLabel;
    edtSenha: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfigurarBancoDados: TfrmConfigurarBancoDados;

implementation

{$R *.dfm}

procedure TfrmConfigurarBancoDados.FormShow(Sender: TObject);
var
  ArqIni : TIniFile;
begin
  ArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'bdmg_config.ini');
  if not FileExists(ExtractFilePath(Application.ExeName)+'bdmg_config.ini') then
    begin
      try
        ArqIni.WriteString('Dados', 'DriverID', 'MSSQL');
        ArqIni.WriteString('Dados', 'Server', '');
        ArqIni.WriteString('Dados', 'DataBase', '');
        ArqIni.WriteString('Dados', 'Username', '');
        ArqIni.WriteString('Dados', 'Password', '');
      finally
        ArqIni.Free;
      end;
    end
  else
    begin
      try
        edtServidor.Text := ArqIni.ReadString('Dados', 'Server', 'Erro ao ler valor');
        edtBancoDados.Text := ArqIni.ReadString('Dados', 'DataBase', 'Erro ao ler valor');
        edtUsuario.Text := ArqIni.ReadString('Dados', 'Username', 'Erro ao ler valor');
        edtSenha.Text := ArqIni.ReadString('Dados', 'Password', 'Erro ao ler valor');
      finally
        ArqIni.Free;
      end;
    end;
end;

procedure TfrmConfigurarBancoDados.btnOkClick(Sender: TObject);
var
  ArqIni : TIniFile;
  sCaminho: string;
begin
  sCaminho := Copy(ExtractFileDir(Application.ExeName), 1, LastDelimiter('\', ExtractFileDir(Application.ExeName)));
  ArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'bdmg_config.ini');
  try
    try
      ArqIni.WriteString('Dados', 'Server', edtServidor.Text);
      ArqIni.WriteString('Dados', 'DataBase', edtBancoDados.Text);
      ArqIni.WriteString('Dados', 'Username', edtUsuario.Text);
      ArqIni.WriteString('Dados', 'Password', edtSenha.Text);
      Close;
    except
      on E : Exception do
        begin
          Application.MessageBox(PChar('Erro encontrado. Verifique os dados fornecidos.' + #13#13 + E.Message),'Aviso',mb_Ok+mb_IconExclamation);
          exit;
        end;
    end;
  finally
    begin
      ArqIni.Free;
    end;
  end;
end;

end.
