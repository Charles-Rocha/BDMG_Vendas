unit untCadastroFornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, untTelaBaseCRUD, Rest.Types, System.JSON, Vcl.Mask, System.Math;

type
  TfrmCadastroFornecedores = class(TfrmTelaBaseCRUD)
    pnlCampos: TPanel;
    edtRazaoSocial: TEdit;
    lblRazaoSocial: TLabel;
    lblStatus: TLabel;
    lblCNPJ: TLabel;
    edtNomeFantasia: TEdit;
    lblNomeFantasia: TLabel;
    edtCodigo: TEdit;
    lblCodigo: TLabel;
    cmbStatus: TComboBox;
    edtCNPJ: TMaskEdit;
    procedure edtCNPJExit(Sender: TObject);
    procedure edtNomeFantasiaExit(Sender: TObject);
    procedure edtRazaoSocialExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure dbgBaseCadastroCellClick(Column: TColumn);
  private
    { Private declarations }
    FVerbo: TRestRequestMethod;

    function FornecedoresPostPut(pNomeFantasia, pRazaoSocial, pCNPJ, pStatus: string; out erro: string): boolean;
    function FornecedoresDelete(pCodigo: string; out erro: string): boolean;
    procedure HabilitaControles;
    procedure DesabilitaControles;
    procedure LimpaControles;
    procedure PreencheCamposFornecedor;
    function ValidarCNPJ(pCNPJ: string): boolean;
    function ValidaCamposObrigatorios: boolean;
  public
    { Public declarations }
  end;

var
  frmCadastroFornecedores: TfrmCadastroFornecedores;

implementation

{$R *.dfm}

uses untDM, untPesquisarFornecedores;

function TfrmCadastroFornecedores.ValidarCNPJ(pCNPJ: string): boolean;
var
  v: array[1..2] of Word;
  cnpj: array[1..14] of Byte;
  I: Byte;
begin
  Result := False;

  { Verificando se tem 11 caracteres }
  if Length(pCNPJ) <> 14 then
  begin
    Exit;
  end;

  { Conferindo se todos dígitos são iguais }
  if pCNPJ = StringOfChar('0', 14) then
    Exit;

  if pCNPJ = StringOfChar('1', 14) then
    Exit;

  if pCNPJ = StringOfChar('2', 14) then
    Exit;

  if pCNPJ = StringOfChar('3', 14) then
    Exit;

  if pCNPJ = StringOfChar('4', 14) then
    Exit;

  if pCNPJ = StringOfChar('5', 14) then
    Exit;

  if pCNPJ = StringOfChar('6', 14) then
    Exit;

  if pCNPJ = StringOfChar('7', 14) then
    Exit;

  if pCNPJ = StringOfChar('8', 14) then
    Exit;

  if pCNPJ = StringOfChar('9', 14) then
    Exit;

  try
    for I := 1 to 14 do
      cnpj[i] := StrToInt(pCNPJ[i]);

    //Nota: Calcula o primeiro dígito de verificação.
    v[1] := 5*cnpj[1] + 4*cnpj[2]  + 3*cnpj[3]  + 2*cnpj[4];
    v[1] := v[1] + 9*cnpj[5] + 8*cnpj[6]  + 7*cnpj[7]  + 6*cnpj[8];
    v[1] := v[1] + 5*cnpj[9] + 4*cnpj[10] + 3*cnpj[11] + 2*cnpj[12];
    v[1] := 11 - v[1] mod 11;
    v[1] := IfThen(v[1] >= 10, 0, v[1]);

    //Nota: Calcula o segundo dígito de verificação.
    v[2] := 6*cnpj[1] + 5*cnpj[2]  + 4*cnpj[3]  + 3*cnpj[4];
    v[2] := v[2] + 2*cnpj[5] + 9*cnpj[6]  + 8*cnpj[7]  + 7*cnpj[8];
    v[2] := v[2] + 6*cnpj[9] + 5*cnpj[10] + 4*cnpj[11] + 3*cnpj[12];
    v[2] := v[2] + 2*v[1];
    v[2] := 11 - v[2] mod 11;
    v[2] := IfThen(v[2] >= 10, 0, v[2]);

    //Nota: Verdadeiro se os dígitos de verificação são os esperados.
    Result := ((v[1] = cnpj[13]) and (v[2] = cnpj[14]));
  except on E: Exception do
    Result := False;
  end;
end;

procedure TfrmCadastroFornecedores.HabilitaControles;
begin
  pnlCampos.Visible := true;
  edtNomeFantasia.Enabled := true;
  edtRazaoSocial.Enabled := true;
  edtCNPJ.Enabled := true;
  cmbStatus.Enabled := true;
  edtNomeFantasia.SetFocus;
  PreencheCamposFornecedor;
end;

procedure TfrmCadastroFornecedores.DesabilitaControles;
begin
  pnlCampos.Visible := false;
  edtNomeFantasia.Enabled := false;
  edtRazaoSocial.Enabled := false;
  edtCNPJ.Enabled := false;
  cmbStatus.Enabled := false;
end;

procedure TfrmCadastroFornecedores.edtNomeFantasiaExit(Sender: TObject);
begin
  if ActiveControl = btnCancelar then
  begin
    exit;
  end;

  if edtNomeFantasia.Text = '' then
  begin
    Application.MessageBox('O campo Nome Fantasia é de preenchimento obrigatório', 'Aviso', mb_Ok + mb_IconExclamation);
    edtNomeFantasia.SetFocus;
    exit;
  end;
end;

procedure TfrmCadastroFornecedores.edtRazaoSocialExit(Sender: TObject);
begin
  if ActiveControl = btnCancelar then
  begin
    exit;
  end;

  if edtRazaoSocial.Text = '' then
  begin
    Application.MessageBox('O campo Razão Social é de preenchimento obrigatório', 'Aviso', mb_Ok + mb_IconExclamation);
    edtRazaoSocial.SetFocus;
    exit;
  end;
end;

procedure TfrmCadastroFornecedores.edtCNPJExit(Sender: TObject);
var
  sCPF: string;
begin
  if ActiveControl = btnCancelar then
  begin
    exit;
  end;

  if edtCNPJ.Text = '' then
  begin
    Application.MessageBox('O campo CNPJ é de preenchimento obrigatório', 'Aviso', mb_Ok + mb_IconExclamation);
    edtCNPJ.SetFocus;
    exit;
  end;

  if edtCNPJ.Text <> '' then
  begin
    if not ValidarCNPJ(edtCNPJ.Text) then
    begin
      Application.MessageBox('O CNPJ digitado é inválido', 'Aviso', mb_Ok + mb_IconExclamation);
      edtCNPJ.SetFocus;
      exit;
    end;

    dm.cdsFornecedor.First;
    while not dm.cdsFornecedor.Eof do
    begin
      sCPF := dm.cdsFornecedorcnpj.AsString;
      if sCPF = edtCNPJ.Text then
      begin
        Application.MessageBox('Não é permitido cadastrar o mesmo CNPJ', 'Aviso', mb_Ok + mb_IconExclamation);
        edtCNPJ.SetFocus;
        abort;
      end;
      dm.cdsFornecedor.Next;
    end;
  end;
end;

procedure TfrmCadastroFornecedores.LimpaControles;
begin
  edtCodigo.Clear;
  edtNomeFantasia.Clear;
  edtRazaoSocial.Clear;
  edtCNPJ.Clear;
  cmbStatus.ItemIndex := 1;
end;

procedure TfrmCadastroFornecedores.btnAtualizarClick(Sender: TObject);
begin
  dm.cdsFornecedor.Filtered := false;
  StatusBar1.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgBaseCadastro.DataSource.DataSet.RecordCount);
end;

procedure TfrmCadastroFornecedores.btnCancelarClick(Sender: TObject);
begin
  inherited;
  DesabilitaControles;
  if dbgBaseCadastro.DataSource.DataSet.RecordCount > 0 then
    begin
      dm.cdsFornecedor.Last;
    end;
  PreencheCamposFornecedor;
end;

procedure TfrmCadastroFornecedores.btnEditarClick(Sender: TObject);
begin
  inherited;
  FVerbo := rmPUT;
  HabilitaControles;
end;

procedure TfrmCadastroFornecedores.btnGravarClick(Sender: TObject);
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

  bResultado := FornecedoresPostPut(edtNomeFantasia.Text, edtRazaoSocial.Text, edtCNPJ.Text, sStatus, erro);
  if not bResultado then
    Application.MessageBox(PChar(erro), 'Aviso', mb_Ok + mb_IconExclamation)
  else
    begin
      dm.ReqFornecedorGet.Execute;
      StatusBar1.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgBaseCadastro.DataSource.DataSet.RecordCount);
      DesabilitaControles;
    end;
  inherited;
end;

procedure TfrmCadastroFornecedores.btnApagarClick(Sender: TObject);
var
  erro: string;
  bResultado: boolean;
begin
  Case Application.MessageBox('Tem certeza que deseja apagar o Fornecedor selecionado?','Aviso', MB_YesNo + MB_IconExclamation) of
  IdYes:
    begin
      try
        try
          bResultado := FornecedoresDelete(dm.cdsFornecedorcodigo.AsString, erro);
          if not bResultado then
            Application.MessageBox(PChar(erro), 'Aviso', mb_Ok + mb_IconExclamation);

          dm.ReqFornecedorGet.Execute;
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

procedure TfrmCadastroFornecedores.btnInserirClick(Sender: TObject);
begin
  inherited;
  FVerbo := rmPOST;
  HabilitaControles;
  LimpaControles;
end;

procedure TfrmCadastroFornecedores.btnPesquisarClick(Sender: TObject);
begin
  frmPesquisarFornecedores.ShowModal;
end;

procedure TfrmCadastroFornecedores.dbgBaseCadastroCellClick(Column: TColumn);
begin
  PreencheCamposFornecedor;
end;

procedure TfrmCadastroFornecedores.FormShow(Sender: TObject);
begin
  inherited;
  pnlCampos.Visible := false;
  if not dm.cdsFornecedor.IsEmpty then
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
  dm.ReqFornecedorGet.Execute;
  dm.cdsFornecedor.Filtered := false;
end;

procedure TfrmCadastroFornecedores.PreencheCamposFornecedor;
begin
  edtCodigo.Text := dm.cdsFornecedorcodigo.AsString;
  edtNomeFantasia.Text := dm.cdsFornecedorNomeFantasia.AsString;
  edtRazaoSocial.Text := dm.cdsFornecedorRazaoSocial.AsString;
  edtCNPJ.Text := dm.cdsFornecedorCNPJ.AsString;
  if dm.cdsFornecedorStatus.AsString = 'True' then
    cmbStatus.ItemIndex := 1
  else
    cmbStatus.ItemIndex := 0;
end;

function TfrmCadastroFornecedores.FornecedoresPostPut(pNomeFantasia, pRazaoSocial, pCNPJ, pStatus: string; out erro: string): boolean;
var
  jsonBody: TJSONObject;
begin
  jsonBody := TJSONObject.Create;
  result := false;
  erro := '';
  try
    try
      if FVerbo = rmPUT then
        jsonBody.AddPair('codigo', dm.cdsFornecedorCodigo.AsString);

      jsonBody.AddPair('nomefantasia', pNomeFantasia);
      jsonBody.AddPair('razaosocial', pRazaoSocial);
      jsonBody.AddPair('cnpj', pCNPJ);
      jsonBody.AddPair('status', pStatus);

      dm.ReqFornecedorPostPut.Params.Clear;
      dm.ReqFornecedorPostPut.ClearBody;
      dm.ReqFornecedorPostPut.Method := FVerbo;
      dm.ReqFornecedorPostPut.AddBody(jsonBody.ToString, ContentTypeFromString('application/json'));
      dm.ReqFornecedorPostPut.Execute;

      if (dm.ReqFornecedorPostPut.Response.StatusCode <> 200) and
         (dm.ReqFornecedorPostPut.Response.StatusCode <> 201) then
      begin
        erro := 'Erro ao gravar dados ' + dm.ReqFornecedorPostPut.Response.StatusCode.ToString;
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

function TfrmCadastroFornecedores.FornecedoresDelete(pcodigo: string; out erro: string): boolean;
begin
  result := false;
  erro := '';
  try
    DM.ReqFornecedorDelete.Resource := 'fornecedor/' + pcodigo;
    DM.ReqFornecedorDelete.Execute;

    if dm.ReqFornecedorDelete.Response.StatusCode <> 200 then
    begin
      erro := 'Erro ao excluir dados ' + dm.ReqFornecedorDelete.Response.StatusCode.ToString;
      exit;
    end;

    result := true;

  except on e: Exception do
    begin
      erro := 'Erro encontrado: ' + e.Message;
    end;
  end;
end;

function TfrmCadastroFornecedores.ValidaCamposObrigatorios: boolean;
begin
  result := true;
  if edtNomeFantasia.Text = '' then
  begin
    Application.MessageBox('O campo Nome Fantasia é de preenchimento obrigatório', 'Aviso', mb_Ok + mb_IconExclamation);
    result := false;
    edtNomeFantasia.SetFocus;
    exit;
  end;

  if edtRazaoSocial.Text = '' then
  begin
    Application.MessageBox('O campo Razão Social é de preenchimento obrigatório', 'Aviso', mb_Ok + mb_IconExclamation);
    result := false;
    edtRazaoSocial.SetFocus;
    exit;
  end;

  if edtCNPJ.Text = '' then
  begin
    Application.MessageBox('O campo CNPJ é de preenchimento obrigatório', 'Aviso', mb_Ok + mb_IconExclamation);
    result := false;
    edtCNPJ.SetFocus;
    exit;
  end;
end;

end.
