unit untCadastroVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, untTelaBaseCRUD, Rest.Types, System.JSON, Vcl.Mask, Vcl.DBCtrls;

type
  TTipoCadastro = (eInserir, eEditar);

type
  TfrmCadastroVendas = class(TfrmTelaBaseCRUD)
    pnlCampos: TPanel;
    edtValorTotalVenda: TEdit;
    lblValorTotalVenda: TLabel;
    lblDataHoraVenda: TLabel;
    lblCliente: TLabel;
    edtNumeroVenda: TEdit;
    lblNumeroVenda: TLabel;
    pnlProdutosVendidos: TPanel;
    dbgProdutosVendidos: TDBGrid;
    lblStatus: TLabel;
    dbLookupComboBoxVenda: TDBLookupComboBox;
    cmbStatus: TComboBox;
    dtsClientes: TDataSource;
    btnAdicionarProdutos: TBitBtn;
    dstProdutosVendidos: TDataSource;
    stbProdutosVendidos: TStatusBar;
    stbVendas: TStatusBar;
    pnlProdutosAdicionadosParaVenda: TPanel;
    lblProdutosEfetivadaPendente: TLabel;
    btnEfetivarVenda: TBitBtn;
    edtDataHoraVenda: TEdit;

    procedure btnAdicionarProdutosClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgBaseCadastroCellClick(Column: TColumn);
    procedure dbLookupComboBoxVendaCloseUp(Sender: TObject);
    procedure btnEfetivarVendaClick(Sender: TObject);
  private
    { Private declarations }
    FVerbo: TRestRequestMethod;
    FTipoCadastro: TTipoCadastro;

    function VendasPostPut(pCodigoCliente, pDataHora, pValorTotal,
      pStatus: string; out erro: string): boolean;
    function ProdutosVendidosDelete(pCodigoCliente: string; out erro: string): boolean;
    function VendasDelete(pNumeroVenda: string; out erro: string): boolean;
    procedure HabilitaControles;
    procedure HabilitaBototes;
    procedure DesabilitaControles;
    procedure LimpaControles;
    procedure PreencheCamposVenda;
    function ProdutosVendidosPostPut(pCodigoCliente, pCodigoNumeroVenda: string; out erro: string): boolean;
    function ProdutosVendidosGetId(pCodigoCliente, pCodigoNumeroVenda: string; out erro: string): boolean;
    procedure ConfiguraCampos;
    function ValidaCamposObrigatorios: boolean;
  public
    { Public declarations }
    procedure ProcessaProdutosVendidosGetId;

    property TipoCadastro: TTipoCadastro read FTipoCadastro write FTipoCadastro;
  end;

var
  frmCadastroVendas: TfrmCadastroVendas;

implementation

{$R *.dfm}

uses untDM, untPesquisarVendas, untProdutos;

procedure TfrmCadastroVendas.HabilitaBototes;
begin
  btnInserir.Enabled := true;

  if dbgBaseCadastro.DataSource.DataSet.IsEmpty then
    begin
      btnEditar.Enabled := false;
      btnApagar.Enabled := false;
      btnPesquisar.Enabled := false;
      btnAtualizar.Enabled := false;
    end
  else
    begin
      btnEditar.Enabled := true;
      btnApagar.Enabled := true;
      btnPesquisar.Enabled := true;
      btnAtualizar.Enabled := true;
    end;

  btnCancelar.Enabled := false;
  btnGravar.Enabled := false;
end;

procedure TfrmCadastroVendas.HabilitaControles;
begin
  pnlCampos.Visible := true;
  btnAdicionarProdutos.Enabled := true;
  if FTipoCadastro = eInserir then
    dbLookupComboBoxVenda.SetFocus;
end;

procedure TfrmCadastroVendas.DesabilitaControles;
begin
  pnlCampos.Visible := false;
end;

procedure TfrmCadastroVendas.LimpaControles;
begin
  edtNumeroVenda.Clear;
  dbLookupComboBoxVenda.KeyValue := 0;
  edtDataHoraVenda.Clear;
  edtValorTotalVenda.Clear;
  cmbStatus.ItemIndex := 0;
  lblProdutosEfetivadaPendente.Visible := false;
  btnEfetivarVenda.Visible := false;
end;

procedure TfrmCadastroVendas.btnAtualizarClick(Sender: TObject);
begin
  dm.cdsVenda.Filtered := false;
  ProcessaProdutosVendidosGetId;
end;

procedure TfrmCadastroVendas.btnCancelarClick(Sender: TObject);
begin
  inherited;
  DesabilitaControles;
  if dbgBaseCadastro.DataSource.DataSet.RecordCount > 0 then
    begin
      dm.cdsCliente.Last;
    end;
end;

procedure TfrmCadastroVendas.btnGravarClick(Sender: TObject);
var
  bResultadoVendas, bResultadoProdutosVendidos, bResultadoProdutosVendidosDelete: boolean;
  erro, sStatus, sValorTotalGeral, sDataHora, sCodigoCliente, sCodigoNumeroVenda, json: string;
  CurrentRecord: TBookMark;
  body: TJSONValue;
begin
  CurrentRecord := dbgBaseCadastro.DataSource.DataSet.GetBookmark;
  bResultadoProdutosVendidosDelete := false;
  if not ValidaCamposObrigatorios then
    exit;

  inherited;
  sCodigoCliente := dbLookupComboBoxVenda.KeyValue;
  sDataHora := DateTimeToStr(Now);
  if FTipoCadastro = eInserir then
    sValorTotalGeral := FloatToStr(frmProdutos.ValorTotalGeral);
  if FTipoCadastro = eEditar then
    sValorTotalGeral := dm.cdsVendavalortotal.AsString;
  if cmbStatus.Text = 'Efetivada' then
    sStatus := '1';
  if cmbStatus.Text = 'Pendente' then
    sStatus := '0';

  if TipoCadastro = eEditar then
  begin
    if frmProdutos.ProdutosExistentesAlterados then
      bResultadoProdutosVendidosDelete := ProdutosVendidosDelete(dm.cdsVendacodigocliente.AsString, erro);
  end;
  bResultadoVendas := VendasPostPut(sCodigoCliente, sDataHora, sValorTotalGeral, sStatus, erro);
  json := dm.ReqVendaGet.Response.JSONValue.ToString;
  body := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJsonValue;
  sCodigoNumeroVenda := IntToStr(body.GetValue<Integer>('NumeroVenda', 0));
  dm.ReqVendaGet.Execute;

  bResultadoProdutosVendidos := ProdutosVendidosPostPut(sCodigoCliente, sCodigoNumeroVenda, erro);
  if (not bResultadoVendas) and (not bResultadoProdutosVendidos) and (not bResultadoProdutosVendidosDelete) then
    Application.MessageBox(PChar(erro), 'Aviso', mb_Ok + mb_IconExclamation)
  else
    begin
      dm.ReqVendaGet.Execute;
      dm.ReqProdutosVendidosGet.Execute;
      StatusBar1.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgBaseCadastro.DataSource.DataSet.RecordCount);
      DesabilitaControles;
      frmProdutos.cdsProdutosAdicionados.EmptyDataSet;
      dbgBaseCadastro.DataSource.DataSet.GotoBookmark(CurrentRecord);
      dbgBaseCadastro.DataSource.DataSet.FreeBookmark(CurrentRecord);
      ProcessaProdutosVendidosGetId;
    end;
end;

procedure TfrmCadastroVendas.btnApagarClick(Sender: TObject);
var
  erro: string;
  bResultadoVendasDelete: boolean;
begin
  inherited;

  if dm.cdsVendastatus.AsString = 'True' then
  begin
    Application.MessageBox('N�o � permitido excluir uma venda j� efetivada', 'Aviso', mb_Ok + mb_IconExclamation);
    exit;
  end;

  Case Application.MessageBox('Tem certeza que deseja apagar a Venda selecionada?','Aviso', MB_YesNo + MB_IconExclamation) of
  IdYes:
    begin
      try
        try
          bResultadoVendasDelete := VendasDelete(dm.cdsVendanumerovenda.AsString, erro);
          if not bResultadoVendasDelete then
            Application.MessageBox(PChar(erro), 'Aviso', mb_Ok + mb_IconExclamation)
          else
          begin
            dm.ReqVendaGet.Execute;
            dm.ReqProdutosVendidosGet.Resource := 'produtosvendidos/';
            dm.ReqProdutosVendidosGet.Execute;
            stbVendas.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgBaseCadastro.DataSource.DataSet.RecordCount);
          end;
        except
          on E : Exception do
            Application.MessageBox(PChar('Erro encontrado! ' + E.Message),'Aviso',mb_Ok+mb_IconExclamation);
        end;
      finally
        begin
          LimpaControles;
          ProcessaProdutosVendidosGetId;
        end;
      end;
    end;
  IdNo:
    begin
      DesabilitaControles;
    end;
  end;
end;

procedure TfrmCadastroVendas.btnInserirClick(Sender: TObject);
begin
  if dm.cdsCliente.IsEmpty then
  begin
    Application.MessageBox('Ainda n�o h� clientes cadastrados ' + #13 +
                           'Cadastre clientes para realizar uma venda', 'Aviso', mb_Ok + mb_IconExclamation);
    exit;
  end;

  inherited;
  FTipoCadastro := eInserir;
  ConfiguraCampos;
end;

procedure TfrmCadastroVendas.btnEditarClick(Sender: TObject);
begin
  if dm.cdsVendastatus.AsString = 'True' then
  begin
    Application.MessageBox('N�o � permitido editar uma venda j� efetivada', 'Aviso', mb_Ok + mb_IconExclamation);
    exit;
  end;

  inherited;
  FTipoCadastro := eEditar;
  ConfiguraCampos;
end;

procedure TfrmCadastroVendas.btnEfetivarVendaClick(Sender: TObject);
var
  CurrentRecord: TBookMark;
  bResultadoVendas: boolean;
  erro: string;
begin
  inherited;
  CurrentRecord := dbgBaseCadastro.DataSource.DataSet.GetBookmark;
  FVerbo := rmPUT;

  Case Application.MessageBox('Tem certeza que deseja efetivar a Venda selecionada?','Aviso', MB_YesNo + MB_IconExclamation) of
  IdYes:
    begin
      try
        try
          bResultadoVendas := VendasPostPut(IntToStr(dbLookupComboBoxVenda.KeyValue),
                                            dm.cdsVendadatahora.AsString, dm.cdsVendavalortotal.AsString, '1', erro);
          if not bResultadoVendas then
            Application.MessageBox(PChar(erro), 'Aviso', mb_Ok + mb_IconExclamation)
          else
          begin
            dm.ReqVendaGet.Execute;
            dm.ReqProdutosVendidosGet.Execute;
            DesabilitaControles;
          end;
        except
          on E : Exception do
            Application.MessageBox(PChar('Erro encontrado! ' + E.Message),'Aviso',mb_Ok+mb_IconExclamation);
        end;
      finally
        begin
          dbgBaseCadastro.DataSource.DataSet.GotoBookmark(CurrentRecord);
          dbgBaseCadastro.DataSource.DataSet.FreeBookmark(CurrentRecord);

          LimpaControles;
          HabilitaBototes;
          ProcessaProdutosVendidosGetId;
        end;
      end;
    end;
  IdNo:
    begin
      DesabilitaControles;
    end;
  end;
end;

procedure TfrmCadastroVendas.btnPesquisarClick(Sender: TObject);
begin
  frmPesquisarVendas.ShowModal;
end;

procedure TfrmCadastroVendas.ConfiguraCampos;
begin
  if FTipoCadastro = eInserir then
  begin
    FVerbo := rmPOST;
    LimpaControles;
    dbLookupComboBoxVenda.Enabled := true;
  end;

  if FTipoCadastro = eEditar then
  begin
    FVerbo := rmPUT;
    PreencheCamposVenda;
    dbLookupComboBoxVenda.Enabled := false;
  end;

  HabilitaControles;
end;

procedure TfrmCadastroVendas.FormShow(Sender: TObject);
begin
  inherited;
  pnlCampos.Visible := false;
  if not dm.cdsVenda.IsEmpty then
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

  stbVendas.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgBaseCadastro.DataSource.DataSet.RecordCount);
  stbProdutosVendidos.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgProdutosVendidos.DataSource.DataSet.RecordCount);

  if not dm.cdsVenda.IsEmpty then
  begin
    dm.cdsVenda.Filtered := false;
    dm.ReqVendaGet.Execute;
  end;

  if not dm.cdsProdutosVendidos.IsEmpty then
    begin
      lblProdutosEfetivadaPendente.Visible := true;
      btnEfetivarVenda.Visible := true;
      ProcessaProdutosVendidosGetId;
    end
  else
    begin
      lblProdutosEfetivadaPendente.Visible := false;
      btnEfetivarVenda.Visible := false;
    end;
end;

procedure TfrmCadastroVendas.PreencheCamposVenda;
begin
  edtNumeroVenda.Text := dm.cdsVendanumerovenda.AsString;
  dbLookupComboBoxVenda.KeyValue := dm.cdsVendacodigocliente.AsInteger;
  edtDataHoraVenda.Text := dm.cdsVendadatahora.AsString;
  edtValorTotalVenda.Text := dm.cdsVendavalortotal.AsString;
  if dm.cdsVendastatus.AsString = 'True' then
    cmbStatus.ItemIndex := 1
  else
    cmbStatus.ItemIndex := 0;
end;

function TfrmCadastroVendas.ProdutosVendidosPostPut(pCodigoCliente, pCodigoNumeroVenda: string; out erro: string): boolean;
var
  jsonBody: TJSONObject;
begin
  result := false;
  erro := '';
  try
    with frmProdutos do
    begin
      cdsProdutosAdicionados.First;
      while not cdsProdutosAdicionados.Eof do
      begin
        jsonBody := TJSONObject.Create;

        jsonBody.AddPair('descricao', cdsProdutosAdicionadosDescricao.AsString);
        jsonBody.AddPair('precounitario', cdsProdutosAdicionadosPrecoUnitario.AsString);
        jsonBody.AddPair('quantidadevendida', cdsProdutosAdicionadosQuantidade.AsString);
        jsonBody.AddPair('valortotal', cdsProdutosAdicionadosValorTotal.AsString);
        jsonBody.AddPair('codigocliente', pCodigoCliente);
        jsonBody.AddPair('codigoproduto', cdsProdutosAdicionadosCodigoProduto.AsString);
        jsonBody.AddPair('codigonumerovenda', pCodigoNumeroVenda);

        dm.ReqProdutosVendidosPostPut.Params.Clear;
        dm.ReqProdutosVendidosPostPut.ClearBody;
        dm.ReqProdutosVendidosPostPut.Method := rmPOST;
        dm.ReqProdutosVendidosPostPut.AddBody(AnsiToUtf8(jsonBody.ToString), ContentTypeFromString('application/json'));
        dm.ReqProdutosVendidosPostPut.Execute;

        if (dm.ReqProdutosVendidosPostPut.Response.StatusCode <> 200) and
           (dm.ReqProdutosVendidosPostPut.Response.StatusCode <> 201) then
        begin
          erro := 'Erro ao gravar dados ' + dm.ReqProdutosVendidosPostPut.Response.StatusCode.ToString;
          exit;
        end;

        jsonBody.Free;

        cdsProdutosAdicionados.Next;
      end;
    end;

    result := true;

  except on e: Exception do
    begin
      erro := 'Erro encontrado: ' + e.Message;
    end;
  end;
end;

function TfrmCadastroVendas.VendasPostPut(pCodigoCliente, pDataHora, pValorTotal,
  pStatus: string; out erro: string): boolean;
var
  jsonBody: TJSONObject;
begin
  jsonBody := TJSONObject.Create;
  result := false;
  erro := '';
  try
    try
      if FVerbo = rmPUT then
        jsonBody.AddPair('numerovenda', dm.cdsVendanumerovenda.AsString);

      jsonBody.AddPair('numerovenda', dm.cdsVendanumerovenda.AsString);
      jsonBody.AddPair('codigocliente', pCodigoCliente);
      jsonBody.AddPair('datahora', pDataHora);
      jsonBody.AddPair('valortotal', pValorTotal);
      jsonBody.AddPair('status', pStatus);

      dm.ReqVendaPostPut.Params.Clear;
      dm.ReqVendaPostPut.ClearBody;
      dm.ReqVendaPostPut.Method := FVerbo;
      dm.ReqVendaPostPut.AddBody(jsonBody.ToString, ContentTypeFromString('application/json'));
      dm.ReqVendaPostPut.Execute;

      if (dm.ReqVendaPostPut.Response.StatusCode <> 200) and
         (dm.ReqVendaPostPut.Response.StatusCode <> 201) then
      begin
        erro := 'Erro ao gravar dados ' + dm.ReqVendaPostPut.Response.StatusCode.ToString;
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

procedure TfrmCadastroVendas.btnAdicionarProdutosClick(Sender: TObject);
begin
  if dm.cdsProduto.IsEmpty then
  begin
    Application.MessageBox('Ainda n�o h� produtos cadastrados ' + #13 +
                           'Cadastre produtos para realizar uma venda', 'Aviso', mb_Ok + mb_IconExclamation);
    exit;
  end;

  frmProdutos.ShowModal;
end;

function TfrmCadastroVendas.ProdutosVendidosDelete(pCodigoCliente: string; out erro: string): boolean;
begin
  result := false;
  erro := '';
  try
    DM.ReqProdutosVendidosDelete.Resource := 'produtosvendidos/' + pCodigoCliente;
    DM.ReqProdutosVendidosDelete.Execute;

    if dm.ReqProdutosVendidosDelete.Response.StatusCode <> 200 then
    begin
      erro := 'Erro ao excluir dados ' + dm.ReqProdutosVendidosDelete.Response.StatusCode.ToString;
      exit;
    end;

    result := true;

  except on e: Exception do
    begin
      erro := 'Erro encontrado: ' + e.Message;
    end;
  end;
end;

function TfrmCadastroVendas.VendasDelete(pNumeroVenda: string; out erro: string): boolean;
begin
  result := false;
  erro := '';
  try
    dm.ReqVendaDelete.Resource := 'venda/' + pNumeroVenda;
    dm.ReqVendaDelete.Execute;

    if dm.ReqVendaDelete.Response.StatusCode <> 200 then
    begin
      erro := 'Erro ao excluir dados ' + dm.ReqVendaDelete.Response.StatusCode.ToString;
      exit;
    end;

    result := true;

  except on e: Exception do
    begin
      erro := 'Erro encontrado: ' + e.Message;
    end;
  end;
end;

procedure TfrmCadastroVendas.dbgBaseCadastroCellClick(Column: TColumn);
begin
  ProcessaProdutosVendidosGetId;
end;

procedure TfrmCadastroVendas.dbLookupComboBoxVendaCloseUp(Sender: TObject);
begin
  inherited;
  if dm.cdsClientestatus.AsString = 'False' then
  begin
    Application.MessageBox('N�o � permitido efetuar venda para cliente inativo', 'Aviso', mb_Ok + mb_IconExclamation);
    dbLookupComboBoxVenda.DropDown;
    exit;
  end;
end;

procedure TfrmCadastroVendas.ProcessaProdutosVendidosGetId;
var
 erro: string;
 bResultado: boolean;
begin
  try
    try
      if not dm.cdsVenda.IsEmpty then
      begin
        bResultado := ProdutosVendidosGetId(dm.cdsVendacodigocliente.AsString, dm.cdsVendanumerovenda.AsString, erro);
        if not bResultado then
          Application.MessageBox(PChar(erro), 'Aviso', mb_Ok + mb_IconExclamation);

        lblProdutosEfetivadaPendente.Visible := true;
        btnEfetivarVenda.Visible := true;

        if dm.cdsVendastatus.AsString = 'True' then
        begin
          lblProdutosEfetivadaPendente.Caption := 'Produtos com venda efetivada';
          lblProdutosEfetivadaPendente.Font.Color := clMenuHighlight;
          btnAdicionarProdutos.Enabled := false;
          cmbStatus.Enabled := false;
          btnEfetivarVenda.Enabled := false;
        end;

        if dm.cdsVendastatus.AsString = 'False' then
        begin
          lblProdutosEfetivadaPendente.Caption := 'Produtos com venda pendente';
          lblProdutosEfetivadaPendente.Font.Color := clRed;
          btnAdicionarProdutos.Enabled := true;
          cmbStatus.Enabled := true;
          btnEfetivarVenda.Enabled := true;
        end;

        PreencheCamposVenda;
      end;
    except
      on E : Exception do
        Application.MessageBox(PChar('Erro encontrado! ' + E.Message),'Aviso',mb_Ok+mb_IconExclamation);
    end;
  finally
    stbVendas.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgBaseCadastro.DataSource.DataSet.RecordCount);
    stbProdutosVendidos.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgProdutosVendidos.DataSource.DataSet.RecordCount);
  end;
end;

function TfrmCadastroVendas.ProdutosVendidosGetId(pCodigoCliente, pCodigoNumeroVenda: string; out erro: string): boolean;
begin
  result := false;
  erro := '';
  try
    dm.ReqProdutosVendidosGet.Resource := 'produtosvendidos/' + pCodigoCliente + '/' + pCodigoNumeroVenda;
    dm.ReqProdutosVendidosGet.Execute;

    if dm.ReqProdutosVendidosGet.Response.StatusCode <> 200 then
    begin
      erro := 'Erro ao consultar produtos vendidos ' + dm.ReqProdutosVendidosGet.Response.StatusCode.ToString;
      exit;
    end;

    result := true;

  except on e: Exception do
    begin
      erro := 'Erro encontrado: ' + e.Message;
    end;
  end;
end;

function TfrmCadastroVendas.ValidaCamposObrigatorios: boolean;
begin
  result := true;
  if dbLookupComboBoxVenda.KeyValue = 0 then
  begin
    Application.MessageBox('� necess�rio selecionar um cliente para concluir essa opera��o', 'Aviso', mb_Ok + mb_IconExclamation);
    result := false;
    dbLookupComboBoxVenda.SetFocus;
    exit;
  end;

  if (FTipoCadastro = eInserir) and (frmProdutos.cdsProdutosAdicionados.IsEmpty) then
  begin
    Application.MessageBox('� necess�rio adicionar produtos para concluir essa opera��o', 'Aviso', mb_Ok + mb_IconExclamation);
    result := false;
    btnAdicionarProdutos.SetFocus;
    exit;
  end;

  if (FTipoCadastro = eEditar) and (frmProdutos.cdsProdutosAdicionados.IsEmpty) then
  begin
    Application.MessageBox('Ao editar, voc� deixou a lista de produtos adicionados para venda vazia' + #13#13 +
                           '� necess�rio deixar ao menos 1 produto nessa lista para concluir essa opera��o', 'Aviso', mb_Ok + mb_IconExclamation);
    result := false;
    btnAdicionarProdutos.SetFocus;
    exit;
  end;
end;

end.
