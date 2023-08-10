unit untCadastroClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, untTelaBaseCRUD, Rest.Types, System.JSON, Vcl.Mask;

type
  TfrmCadastroClientes = class(TfrmTelaBaseCRUD)
    pnlCampos: TPanel;
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    lblNome: TLabel;
    edtNome: TEdit;
    lblCPF: TLabel;
    lblStatus: TLabel;
    lblDataNascimento: TLabel;
    edtCPF: TMaskEdit;
    edtDataNascimento: TMaskEdit;
    cmbStatus: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure edtCPFExit(Sender: TObject);
    procedure edtNomeExit(Sender: TObject);
    procedure edtDataNascimentoExit(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure dbgBaseCadastroCellClick(Column: TColumn);
  private
    { Private declarations }
    FVerbo: TRestRequestMethod;

    function ClientesPostPut(pNome, pCPF, pStatus, pDataNascimento: string; out erro: string): boolean;
    function ClientesDelete(pCodigo: string; out erro: string): boolean;
    procedure HabilitaControles;
    procedure DesabilitaControles;
    procedure LimpaControles;
    procedure PreencheCamposCliente;
    function ValidarCpf(num: string): boolean;
    function ValidaCamposObrigatorios: boolean;
  public
    { Public declarations }
  end;

var
  frmCadastroClientes: TfrmCadastroClientes;

implementation

{$R *.dfm}

uses untDM, untPesquisarClientes;

function TfrmCadastroClientes.ValidarCpf(num: string): boolean;
var
  n1, n2, n3, n4, n5, n6, n7, n8, n9: integer;
  d1, d2: integer;
  digitado, calculado: string;
begin
  n1:= StrToInt(num[1]);
  n2:= StrToInt(num[2]);
  n3:= StrToInt(num[3]);
  n4:= StrToInt(num[4]);
  n5:= StrToInt(num[5]);
  n6:= StrToInt(num[6]);
  n7:= StrToInt(num[7]);
  n8:= StrToInt(num[8]);
  n9:= StrToInt(num[9]);
  d1:= n9*2+n8*3+n7*4+n6*5+n5*6+n4*7+n3*8+n2*9+n1*10;
  d1:= 11-(d1 mod 11);

  if d1>=10 then
    d1:=0;

  d2:= d1*2+n9*3+n8*4+n7*5+n6*6+n5*7+n4*8+n3*9+n2*10+n1*11;
  d2:= 11-(d2 mod 11);

  if d2>=10 then
    d2:=0;

  calculado:= inttostr(d1)+inttostr(d2);
  digitado:= num[10]+num[11];

  if calculado = digitado then
    result := true
  else
    result := false;
end;

procedure TfrmCadastroClientes.HabilitaControles;
begin
  pnlCampos.Visible := true;
  edtNome.Enabled := true;
  edtCPF.Enabled := true;
  cmbStatus.Enabled := true;
  edtDataNascimento.Enabled := true;
  PreencheCamposCliente;
  edtNome.SetFocus;
end;

procedure TfrmCadastroClientes.DesabilitaControles;
begin
  pnlCampos.Visible := false;
  edtNome.Enabled := false;
  edtCPF.Enabled := false;
  cmbStatus.Enabled := false;
  edtDataNascimento.Enabled := false;
end;

procedure TfrmCadastroClientes.edtCPFExit(Sender: TObject);
var
  sCPF: string;
begin
  if ActiveControl = btnCancelar then
  begin
    exit;
  end;

  if edtCPF.Text <> '' then
  begin
    if not ValidarCpf(edtCPF.Text) then
    begin
      Application.MessageBox('O CPF digitado é inválido', 'Aviso', mb_Ok + mb_IconExclamation);
      edtCPF.SetFocus;
      exit;
    end;

    dm.cdsCliente.First;
    while not dm.cdsCliente.Eof do
    begin
      sCPF := dm.cdsClientecpf.AsString;
      if sCPF = edtCPF.Text then
      begin
        Application.MessageBox('Não é permitido cadastrar o mesmo CPF', 'Aviso', mb_Ok + mb_IconExclamation);
        edtCPF.SetFocus;
        abort;
      end;
      dm.cdsCliente.Next;
    end;
  end;
end;

procedure TfrmCadastroClientes.edtDataNascimentoExit(Sender: TObject);
begin
  if ActiveControl = btnCancelar then
  begin
    exit;
  end;

  if edtDataNascimento.Text = '' then
  begin
    Application.MessageBox('O campo Data Nascimento é de preenchimento obrigatório', 'Aviso', mb_Ok + mb_IconExclamation);
    edtDataNascimento.SetFocus;
    exit;
  end;
end;

procedure TfrmCadastroClientes.edtNomeExit(Sender: TObject);
begin
  if ActiveControl = btnCancelar then
  begin
    exit;
  end;

  if edtNome.Text = '' then
  begin
    Application.MessageBox('O campo Nome é de preenchimento obrigatório', 'Aviso', mb_Ok + mb_IconExclamation);
    edtNome.SetFocus;
    exit;
  end;
end;

procedure TfrmCadastroClientes.LimpaControles;
begin
  edtCodigo.Clear;
  edtNome.Clear;
  edtCPF.Clear;
  cmbStatus.ItemIndex := 1;
  edtDataNascimento.Clear;
end;

procedure TfrmCadastroClientes.btnAtualizarClick(Sender: TObject);
begin
  dm.cdsCliente.Filtered := false;
  StatusBar1.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgBaseCadastro.DataSource.DataSet.RecordCount);
end;

procedure TfrmCadastroClientes.btnCancelarClick(Sender: TObject);
begin
  inherited;
  DesabilitaControles;
  if dbgBaseCadastro.DataSource.DataSet.RecordCount > 0 then
    begin
      dm.cdsCliente.Last;
    end;
  PreencheCamposCliente;
end;

procedure TfrmCadastroClientes.btnEditarClick(Sender: TObject);
begin
  inherited;
  FVerbo := rmPUT;
  HabilitaControles;
end;

procedure TfrmCadastroClientes.btnGravarClick(Sender: TObject);
var
  erro: string;
  bResultado: boolean;
  sStatus: string;
begin
  if not ValidaCamposObrigatorios then
    exit;

  if cmbStatus.Text = 'Ativo' then
    sStatus := '1';
  if cmbStatus.Text = 'Inativo' then
    sStatus := '0';

  bResultado := ClientesPostPut(edtNome.Text, edtCPF.Text, sStatus, edtDataNascimento.EditText, erro);
  if not bResultado then
    Application.MessageBox(PChar(erro), 'Aviso', mb_Ok + mb_IconExclamation)
  else
    begin
      dm.ReqClienteGet.Execute;
      StatusBar1.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgBaseCadastro.DataSource.DataSet.RecordCount);
      DesabilitaControles;
    end;
  inherited;
  dm.ReqClienteGet.Execute;
end;

procedure TfrmCadastroClientes.btnApagarClick(Sender: TObject);
var
  erro: string;
  bResultado: boolean;
begin
  Case Application.MessageBox('Tem certeza que deseja apagar o Cliente selecionado?','Aviso', MB_YesNo + MB_IconExclamation) of
  IdYes:
    begin
      try
        try
          bResultado := ClientesDelete(dm.cdsClientecodigo.AsString, erro);
          if not bResultado then
            Application.MessageBox(PChar(erro), 'Aviso', mb_Ok + mb_IconExclamation);

          dm.ReqClienteGet.Execute;
          StatusBar1.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgBaseCadastro.DataSource.DataSet.RecordCount);
        except
          on E : Exception do
            Application.MessageBox(PChar('Erro encontrado! ' + E.Message),'Aviso',mb_Ok+mb_IconExclamation);
        end;
      finally
        begin
          LimpaControles;
        end;
      end;
    end;
  IdNo:
    begin
      DesabilitaControles;
    end;
  end;
  inherited;
end;

procedure TfrmCadastroClientes.btnInserirClick(Sender: TObject);
begin
  inherited;
  FVerbo := rmPOST;
  HabilitaControles;
  LimpaControles;
end;

procedure TfrmCadastroClientes.btnPesquisarClick(Sender: TObject);
begin
  frmPesquisarClientes.ShowModal;
end;

procedure TfrmCadastroClientes.FormShow(Sender: TObject);
begin
  inherited;
  pnlCampos.Visible := false;
  if not dm.cdsCliente.IsEmpty then
    begin
      btnEditar.Enabled := true;
      btnApagar.Enabled := true;
      btnPesquisar.Enabled := true;
      btnAtualizar.Enabled := true;
    end
  else
    begin
      btnEditar.Enabled := false;
      btnApagar.Enabled := false;
      btnPesquisar.Enabled := false;
      btnAtualizar.Enabled := false;
    end;
  StatusBar1.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgBaseCadastro.DataSource.DataSet.RecordCount);
  dm.ReqClienteGet.Execute;
  dm.cdsCliente.Filtered := false;
end;

procedure TfrmCadastroClientes.PreencheCamposCliente;
begin
  edtCodigo.Text := dm.cdsClientecodigo.AsString;
  edtNome.Text := dm.cdsClientenome.AsString;
  edtCPF.Text := dm.cdsClientecpf.AsString;
  if dm.cdsClientestatus.AsString = 'True' then
    cmbStatus.ItemIndex := 1
  else
    cmbStatus.ItemIndex := 0;
  edtDataNascimento.EditText := dm.cdsClientedataNascimento.AsString;
end;

function TfrmCadastroClientes.ClientesPostPut(pNome, pCPF, pStatus, pDataNascimento: string; out erro: string): boolean;
var
  jsonBody: TJSONObject;
  data: TDateTime;
begin
  jsonBody := TJSONObject.Create;
  result := false;
  erro := '';
  data := StrToDateTime(pDataNascimento);
  try
    try
      if FVerbo = rmPUT then
        jsonBody.AddPair('codigo', dm.cdsClientecodigo.AsString);

      jsonBody.AddPair('nome', pNome);
      jsonBody.AddPair('cpf', pCPF);
      jsonBody.AddPair('status', pStatus);
      jsonBody.AddPair('datanascimento', FormatDateTime('yyyy-mm-dd', data));

      dm.ReqClientePostPut.Params.Clear;
      dm.ReqClientePostPut.ClearBody;
      dm.ReqClientePostPut.Method := FVerbo;
      dm.ReqClientePostPut.AddBody(jsonBody.ToString, ContentTypeFromString('application/json'));
      dm.ReqClientePostPut.Execute;

      if (dm.ReqClientePostPut.Response.StatusCode <> 200) and
         (dm.ReqClientePostPut.Response.StatusCode <> 201) then
      begin
        erro := 'Erro ao gravar dados ' + dm.ReqClientePostPut.Response.StatusCode.ToString;
        exit;
      end;

      result := true;

    except on e: Exception do
      begin
        erro := 'Erro encontrado: ' + e.Message;
      end;
    end;
  finally
    jsonBody.Free;
  end;
end;

procedure TfrmCadastroClientes.dbgBaseCadastroCellClick(Column: TColumn);
begin
  PreencheCamposCliente
end;

function TfrmCadastroClientes.ClientesDelete(pCodigo: string; out erro: string): boolean;
begin
  result := false;
  erro := '';
  try
    DM.ReqClienteDelete.Resource := 'cliente/' + pCodigo;
    DM.ReqClienteDelete.Execute;

    if dm.ReqClienteDelete.Response.StatusCode <> 200 then
    begin
      erro := 'Erro ao excluir dados ' + dm.ReqClienteDelete.Response.StatusCode.ToString;
      exit;
    end;

    result := true;

  except on e: Exception do
    begin
      erro := 'Erro encontrado: ' + e.Message;
    end;
  end;
end;

function TfrmCadastroClientes.ValidaCamposObrigatorios: boolean;
begin
  result := true;
  if edtNome.Text = '' then
  begin
    Application.MessageBox('O campo Nome é de preenchimento obrigatório', 'Aviso', mb_Ok + mb_IconExclamation);
    result := false;
    edtNome.SetFocus;
    exit;
  end;

  if edtCPF.Text = '' then
  begin
    Application.MessageBox('O campo CPF é de preenchimento obrigatório', 'Aviso', mb_Ok + mb_IconExclamation);
    result := false;
    edtCPF.SetFocus;
    exit;
  end;

  if edtDataNascimento.Text = '' then
  begin
    Application.MessageBox('O campo Data Nascimento é de preenchimento obrigatório', 'Aviso', mb_Ok + mb_IconExclamation);
    result := false;
    edtDataNascimento.SetFocus;
    exit;
  end;
end;

end.
