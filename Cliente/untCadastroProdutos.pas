unit untCadastroProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, untTelaBaseCRUD, Rest.Types, System.JSON, Vcl.Mask, Vcl.DBCtrls, StrUtils;

type
  TfrmCadastroProdutos = class(TfrmTelaBaseCRUD)
    pnlCampos: TPanel;
    lblFornecedor: TLabel;
    lblStatus: TLabel;
    lblPrecoUnitario: TLabel;
    edtDescricao: TEdit;
    lblDescricao: TLabel;
    edtCodigo: TEdit;
    lblCodigo: TLabel;
    cmbStatus: TComboBox;
    dbLookupComboBoxFornecedor: TDBLookupComboBox;
    dtsFornecedores: TDataSource;
    edtPrecoUnitario: TMaskEdit;
    procedure edtDescricaoExit(Sender: TObject);
    procedure edtPrecoUnitarioExit(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbLookupComboBoxFornecedorCloseUp(Sender: TObject);
    procedure edtPrecoUnitarioChange(Sender: TObject);
    procedure dbgBaseCadastroCellClick(Column: TColumn);
    procedure edtPrecoUnitarioEnter(Sender: TObject);
  private
    { Private declarations }
    FVerbo: TRestRequestMethod;

    function ProdutosPostPut(pDescricao, pPrecoUnitario, pCodigoFornecedor, pStatus: string; out erro: string): boolean;
    function ProdutosDelete(pCodigo: string; out erro: string): boolean;
    procedure HabilitaControles;
    procedure DesabilitaControles;
    procedure LimpaControles;
    procedure PreencheCamposProduto;
  public
    { Public declarations }
    function FormatarMoeda(valor: string): string;
  end;

var
  frmCadastroProdutos: TfrmCadastroProdutos;

implementation

{$R *.dfm}

uses untDM, untPesquisarProdutos;

function TfrmCadastroProdutos.FormatarMoeda(valor: string): string;
var
  decimais, centena, milhar, milhoes, bilhoes, trilhoes, quadrilhoes: string;
  i: Integer;
begin
  Result := EmptyStr;

  for i := 0 to Length(valor) - 1 do
    if not(valor[i] in ['0' .. '9']) then
      delete(valor, i, 1);

  if copy(valor, 1, 1) = '0' then
    valor := copy(valor, 2, Length(valor));

  decimais := RightStr(valor, 2);
  centena := copy(RightStr(valor, 5), 1, 3);
  milhar := copy(RightStr(valor, 8), 1, 3);
  milhoes := copy(RightStr(valor, 11), 1, 3);
  bilhoes := copy(RightStr(valor, 14), 1, 3);
  trilhoes := copy(RightStr(valor, 17), 1, 3);
  quadrilhoes := LeftStr(valor, Length(valor) - 17);

  case Length(valor) of
    1:
      Result := '0,0' + valor;
    2:
      Result := '0,' + valor;
    6 .. 8:
      begin
        milhar := LeftStr(valor, Length(valor) - 5);
        Result := milhar + '.' + centena + ',' + decimais;
      end;
    9 .. 11:
      begin
        milhoes := LeftStr(valor, Length(valor) - 8);
        Result := milhoes + '.' + milhar + '.' + centena + ',' + decimais;
      end;
    12 .. 14:
      begin
        bilhoes := LeftStr(valor, Length(valor) - 11);
        Result := bilhoes + '.' + milhoes + '.' + milhar + '.' + centena + ',' + decimais;
      end;
    15 .. 17:
      begin
        trilhoes := LeftStr(valor, Length(valor) - 14);
        Result := trilhoes + '.' + bilhoes + '.' + milhoes + '.' + milhar + '.' + centena + ','
          + decimais;
      end;
    18 .. 20:
      begin
        quadrilhoes := LeftStr(valor, Length(valor) - 17);
        Result := quadrilhoes + '.' + trilhoes + '.' + bilhoes + '.' + milhoes + '.' + milhar + '.'
          + centena + ',' + decimais;
      end
  else
    Result := LeftStr(valor, Length(valor) - 2) + ',' + decimais;
  end;
end;

procedure TfrmCadastroProdutos.HabilitaControles;
begin
  pnlCampos.Visible := true;
  edtDescricao.Enabled := true;
  edtPrecoUnitario.Enabled := true;
  dbLookupComboBoxFornecedor.Enabled := true;
  cmbStatus.Enabled := true;
  edtDescricao.SetFocus;
  PreencheCamposProduto;
end;

procedure TfrmCadastroProdutos.DesabilitaControles;
begin
  pnlCampos.Visible := false;
  edtDescricao.Enabled := false;
  edtPrecoUnitario.Enabled := false;
  dbLookupComboBoxFornecedor.Enabled := false;
  cmbStatus.Enabled := false;
end;

procedure TfrmCadastroProdutos.edtDescricaoExit(Sender: TObject);
begin
  if ActiveControl = btnCancelar then
  begin
    exit;
  end;

  if edtDescricao.Text = '' then
  begin
    Application.MessageBox('O campo Descrição é de preenchimento obrigatório', 'Aviso', mb_Ok + mb_IconExclamation);
    edtDescricao.SetFocus;
    exit;
  end;
end;

procedure TfrmCadastroProdutos.edtPrecoUnitarioChange(Sender: TObject);
begin
  edtPrecoUnitario.Text := FormatarMoeda(edtPrecoUnitario.Text);
  edtPrecoUnitario.SelStart := Length(edtPrecoUnitario.Text);
end;

procedure TfrmCadastroProdutos.edtPrecoUnitarioEnter(Sender: TObject);
begin
  edtPrecoUnitario.SelectAll;
end;

procedure TfrmCadastroProdutos.edtPrecoUnitarioExit(Sender: TObject);
begin
  if ActiveControl = btnCancelar then
  begin
    exit;
  end;

  if edtPrecoUnitario.Text = '0,00' then
  begin
    Application.MessageBox('Não é permitido adicionar um produto com o preço zerado', 'Aviso', mb_Ok + mb_IconExclamation);
    edtPrecoUnitario.SetFocus;
    exit;
  end;
end;

procedure TfrmCadastroProdutos.LimpaControles;
begin
  edtCodigo.Clear;
  edtDescricao.Clear;
  edtPrecoUnitario.Clear;
  cmbStatus.ItemIndex := 1;
  dbLookupComboBoxFornecedor.KeyValue := 0;
end;

procedure TfrmCadastroProdutos.btnAtualizarClick(Sender: TObject);
begin
  dm.cdsProduto.Filtered := false;
  StatusBar1.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgBaseCadastro.DataSource.DataSet.RecordCount);
end;

procedure TfrmCadastroProdutos.btnCancelarClick(Sender: TObject);
begin
  inherited;
  DesabilitaControles;
  if dbgBaseCadastro.DataSource.DataSet.RecordCount > 0 then
    begin
      dm.cdsProduto.Last;
    end;
  PreencheCamposProduto;
end;

procedure TfrmCadastroProdutos.btnEditarClick(Sender: TObject);
begin
  inherited;
  FVerbo := rmPUT;
  HabilitaControles;
end;

procedure TfrmCadastroProdutos.btnGravarClick(Sender: TObject);
var
  erro: string;
  bResultado: boolean;
  sStatus, sPrecoUnitario: string;
begin
  inherited;
  if cmbStatus.Text = 'Ativo' then
    sStatus := '1';
  if cmbStatus.Text = 'Inativo' then
    sStatus := '0';

  sPrecoUnitario := StringReplace(edtPrecoUnitario.Text, '.', '', [rfIgnoreCase, rfReplaceAll]);

  bResultado := ProdutosPostPut(edtDescricao.Text, sPrecoUnitario, dbLookupComboBoxFornecedor.KeyValue, sStatus, erro);
  if not bResultado then
    Application.MessageBox(PChar(erro), 'Aviso', mb_Ok + mb_IconExclamation)
  else
    begin
      dm.ReqProdutoGet.Execute;
      StatusBar1.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgBaseCadastro.DataSource.DataSet.RecordCount);
      DesabilitaControles;
    end;
end;

procedure TfrmCadastroProdutos.btnApagarClick(Sender: TObject);
var
  erro: string;
  bResultado: boolean;
begin
  inherited;

  Case Application.MessageBox('Tem certeza que deseja apagar o Produto selecionado?','Aviso', MB_YesNo + MB_IconExclamation) of
  IdYes:
    begin
      try
        try
          bResultado := ProdutosDelete(dm.cdsProdutocodigo.AsString, erro);
          if not bResultado then
            Application.MessageBox(PChar(erro), 'Aviso', mb_Ok + mb_IconExclamation);

          dm.ReqProdutoGet.Execute;
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
end;

procedure TfrmCadastroProdutos.btnInserirClick(Sender: TObject);
begin
  if dm.cdsCliente.IsEmpty then
  begin
    Application.MessageBox('Ainda não há fornecedores cadastrados ' + #13 +
                           'Cadastre fornecedores para inserir produtos', 'Aviso', mb_Ok + mb_IconExclamation);
    exit;
  end;

  inherited;
  FVerbo := rmPOST;
  HabilitaControles;
  LimpaControles;
end;

procedure TfrmCadastroProdutos.btnPesquisarClick(Sender: TObject);
begin
  frmPesquisarProdutos.ShowModal;
end;

procedure TfrmCadastroProdutos.FormShow(Sender: TObject);
begin
  inherited;
  pnlCampos.Visible := false;
  if not dm.cdsProduto.IsEmpty then
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
  dm.ReqProdutoGet.Execute;
  dm.cdsProduto.Filtered := false;
end;

procedure TfrmCadastroProdutos.PreencheCamposProduto;
begin
  edtCodigo.Text := dm.cdsProdutocodigo.AsString;
  edtDescricao.Text := dm.cdsProdutodescricao.AsString;
  edtPrecoUnitario.Text := dm.cdsProdutoprecounitario.AsString;
  if dm.cdsProdutostatus.AsString = 'True' then
    cmbStatus.ItemIndex := 1
  else
    cmbStatus.ItemIndex := 0;
end;

function TfrmCadastroProdutos.ProdutosPostPut(pDescricao, pPrecoUnitario, pCodigoFornecedor, pStatus: string; out erro: string): boolean;
var
  jsonBody: TJSONObject;
begin
  jsonBody := TJSONObject.Create;
  result := false;
  erro := '';
  try
    try
      if FVerbo = rmPUT then
        jsonBody.AddPair('codigo', dm.cdsProdutocodigo.AsString);

      jsonBody.AddPair('descricao', pDescricao);
      jsonBody.AddPair('precounitario', pPrecoUnitario);
      jsonBody.AddPair('codigofornecedor', pCodigoFornecedor);
      jsonBody.AddPair('status', pStatus);

      dm.ReqProdutoPostPut.Params.Clear;
      dm.ReqProdutoPostPut.ClearBody;
      dm.ReqProdutoPostPut.Method := FVerbo;
      dm.ReqProdutoPostPut.AddBody(AnsiToUtf8(jsonBody.ToString), ContentTypeFromString('application/json'));
      dm.ReqProdutoPostPut.Execute;

      if (dm.ReqProdutoPostPut.Response.StatusCode <> 200) and
         (dm.ReqProdutoPostPut.Response.StatusCode <> 201) then
      begin
        erro := 'Erro ao gravar dados ' + dm.ReqProdutoPostPut.Response.StatusCode.ToString;
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

function TfrmCadastroProdutos.ProdutosDelete(pCodigo: string; out erro: string): boolean;
begin
  result := false;
  erro := '';
  try
    DM.ReqProdutoDelete.Resource := 'produto/' + pCodigo;
    DM.ReqProdutoDelete.Execute;

    if dm.ReqProdutoDelete.Response.StatusCode <> 200 then
    begin
      erro := 'Erro ao excluir dados ' + dm.ReqProdutoDelete.Response.StatusCode.ToString;
      exit;
    end;

    result := true;

  except on e: Exception do
    begin
      erro := 'Erro encontrado: ' + e.Message;
    end;
  end;
end;

procedure TfrmCadastroProdutos.dbgBaseCadastroCellClick(Column: TColumn);
begin
  PreencheCamposProduto;
end;

procedure TfrmCadastroProdutos.dbLookupComboBoxFornecedorCloseUp(Sender: TObject);
begin
  inherited;
  if dm.cdsFornecedorstatus.AsString = 'False' then
  begin
    Application.MessageBox('Não é permitido efetuar venda para fornecedor inativo', 'Aviso', mb_Ok + mb_IconExclamation);
    dbLookupComboBoxFornecedor.DropDown;
    exit;
  end;
end;

end.
