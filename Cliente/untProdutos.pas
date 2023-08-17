unit untProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, untTelaBaseCRUD, Rest.Types, System.JSON, Vcl.Mask, Vcl.DBCtrls, Datasnap.DBClient;

type
  TTipoAcaoProduto = (eAdicionar, eExcluir);

type
  TfrmProdutos = class(TForm)
    pnlBotoes: TPanel;
    btnCancelar: TBitBtn;
    btnAceitar: TBitBtn;
    pnlProdutosAdicionados: TPanel;
    dbgProdutosAdicionados: TDBGrid;
    dtsProdutosAdicionados: TDataSource;
    dtsFornecedores: TDataSource;
    dtsProdutos: TDataSource;
    pnlProdutos: TPanel;
    dbgProdutos: TDBGrid;
    pnlProdutosAdicionadosParaVenda: TPanel;
    lblProdutosAdicionadosParaVenda: TLabel;
    StatusBar1: TStatusBar;
    StatusBar2: TStatusBar;
    btnLimpar: TBitBtn;
    btnExcluir: TBitBtn;
    btnInserir: TBitBtn;
    cdsProdutosAdicionados: TClientDataSet;
    cdsProdutosAdicionadosCodigo: TIntegerField;
    cdsProdutosAdicionadosDescricao: TStringField;
    cdsProdutosAdicionadosPrecoUnitario: TCurrencyField;
    cdsProdutosAdicionadosQuantidade: TIntegerField;
    cdsProdutosAdicionadosValorTotal: TCurrencyField;
    cdsProdutosAdicionadosCodigoProduto: TIntegerField;
    procedure btnInserirClick(Sender: TObject);
    procedure btnAceitarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure CarregaProdutosAdicionadosJaGravados;
    procedure btnExcluirClick(Sender: TObject);
    procedure cdsProdutosAdicionadosPrecoUnitarioGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure cdsProdutosAdicionadosValorTotalGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
    FCodigoClienteAtual: Integer;
    FValorTotalGeral: Currency;
    FProdutosExistentesAlterados: boolean;

    procedure AdicionaProdutosOuExcluiAdicionados(TipoAcaoProduto: TTipoAcaoProduto);
  public
    { Public declarations }
    property ValorTotalGeral: Currency read FValorTotalGeral write FValorTotalGeral;
    property ProdutosExistentesAlterados: boolean read FProdutosExistentesAlterados write FProdutosExistentesAlterados;
  end;

var
  frmProdutos: TfrmProdutos;

implementation

{$R *.dfm}

uses untDM, untCadastroVendas;

procedure TfrmProdutos.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmProdutos.btnExcluirClick(Sender: TObject);
begin
  if cdsProdutosAdicionadosQuantidade.AsInteger = 1 then
  begin
    cdsProdutosAdicionados.Delete;
  end;

  if cdsProdutosAdicionadosQuantidade.AsInteger > 1 then
  begin
    AdicionaProdutosOuExcluiAdicionados(eExcluir);
  end;
end;

procedure TfrmProdutos.btnAceitarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmProdutos.btnInserirClick(Sender: TObject);
var
  CurrentRecord: TBookMark;
begin
  CurrentRecord := dbgProdutosAdicionados.DataSource.DataSet.GetBookmark;
  AdicionaProdutosOuExcluiAdicionados(eAdicionar);
  dbgProdutosAdicionados.DataSource.DataSet.GotoBookmark(CurrentRecord);
  dbgProdutosAdicionados.DataSource.DataSet.FreeBookmark(CurrentRecord);
end;

procedure TfrmProdutos.btnLimparClick(Sender: TObject);
begin
  cdsProdutosAdicionados.EmptyDataSet;
end;

procedure TfrmProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FCodigoClienteAtual := dm.cdsVendacodigocliente.AsInteger;
  if ActiveControl = btnAceitar then
  begin
    if cdsProdutosAdicionados.ChangeCount > 0 then
      FProdutosExistentesAlterados := true
    else
      FProdutosExistentesAlterados := false;
  end;
end;

procedure TfrmProdutos.FormShow(Sender: TObject);
begin
  cdsProdutosAdicionados.LogChanges := false;
  CarregaProdutosAdicionadosJaGravados;
  cdsProdutosAdicionados.LogChanges := true;
end;

procedure TfrmProdutos.CarregaProdutosAdicionadosJaGravados;
begin
  if cdsProdutosAdicionados.IsEmpty then
    FCodigoClienteAtual := 0;

  if frmCadastroVendas.TipoCadastro = eInserir then
  begin
    if (FCodigoClienteAtual <> dm.cdsVendacodigocliente.AsInteger) then
    begin
      cdsProdutosAdicionados.EmptyDataSet;
      FValorTotalGeral := 0;
    end;
  end;

  if frmCadastroVendas.TipoCadastro = eEditar then
  begin
    if (FCodigoClienteAtual <> dm.cdsVendacodigocliente.AsInteger) then
    begin
      cdsProdutosAdicionados.EmptyDataSet;
      dm.cdsProdutosVendidos.First;
      while not dm.cdsProdutosVendidos.Eof do
      begin
        cdsProdutosAdicionados.Append;
        cdsProdutosAdicionadosCodigo.AsInteger := dm.cdsProdutosVendidoscodigoproduto.AsInteger;
        cdsProdutosAdicionadosDescricao.AsString := dm.cdsProdutosVendidosdescricao.AsString;
        cdsProdutosAdicionadosPrecoUnitario.AsCurrency := dm.cdsProdutosVendidosprecounitario.AsCurrency;
        cdsProdutosAdicionadosQuantidade.AsInteger := dm.cdsProdutosVendidosquantidadevendida.AsInteger;
        cdsProdutosAdicionadosValorTotal.AsCurrency := dm.cdsProdutosVendidosvalortotal.AsCurrency;
        cdsProdutosAdicionadosCodigoProduto.AsInteger := dm.cdsProdutosVendidoscodigoproduto.AsInteger;
        cdsProdutosAdicionados.Post;

        dm.cdsProdutosVendidos.Next;
      end;

      cdsProdutosAdicionados.First;
    end;
  end;
  StatusBar1.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgProdutos.DataSource.DataSet.RecordCount);
  StatusBar2.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgProdutosAdicionados.DataSource.DataSet.RecordCount);
end;

procedure TfrmProdutos.cdsProdutosAdicionadosPrecoUnitarioGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if not cdsProdutosAdicionados.IsEmpty then
  begin
    if cdsProdutosAdicionadosPrecoUnitario.AsString <> '' then
      Text := FormatFloat('#,##0.00', cdsProdutosAdicionadosPrecoUnitario.AsCurrency);
  end;
end;

procedure TfrmProdutos.cdsProdutosAdicionadosValorTotalGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if not cdsProdutosAdicionados.IsEmpty then
  begin
    if cdsProdutosAdicionadosValorTotal.AsString <> '' then
      Text := FormatFloat('#,##0.00', cdsProdutosAdicionadosValorTotal.AsCurrency);
  end;
end;

procedure TfrmProdutos.AdicionaProdutosOuExcluiAdicionados(TipoAcaoProduto: TTipoAcaoProduto);
var
  iQuantidade: integer;
  cValorTotal: Currency;
  bRepetido: boolean;
begin
  iQuantidade := 0;
  cValorTotal := 0;
  bRepetido := false;

  if dm.cdsProdutostatus.AsString = 'False' then
  begin
    Application.MessageBox('Não é permitido adicionar um produto Inativo', 'Aviso', mb_Ok + mb_IconExclamation);
    exit;
  end;

  if TipoAcaoProduto = eAdicionar then
  begin
    cdsProdutosAdicionados.First;
    while not cdsProdutosAdicionados.Eof do
    begin
      if cdsProdutosAdicionadosCodigoProduto.AsInteger = dm.cdsProdutocodigo.AsInteger then
      begin
        iQuantidade := iQuantidade + 1 + cdsProdutosAdicionadosQuantidade.AsInteger;
        cValorTotal := cValorTotal + cdsProdutosAdicionadosValorTotal.AsCurrency + dm.cdsProdutoprecounitario.AsCurrency;
        FValorTotalGeral := FValorTotalGeral + dm.cdsProdutoprecounitario.AsCurrency;

        cdsProdutosAdicionados.Edit;
        cdsProdutosAdicionadosQuantidade.AsInteger := iQuantidade;
        cdsProdutosAdicionadosValorTotal.AsCurrency := cValorTotal;
        cdsProdutosAdicionados.Post;
        bRepetido := true;
      end;

      cdsProdutosAdicionados.Next;
    end;

    if not bRepetido then
    begin
      cdsProdutosAdicionados.Append;
      cdsProdutosAdicionadosCodigo.AsInteger := dm.cdsProdutocodigo.AsInteger;
      cdsProdutosAdicionadosDescricao.AsString := dm.cdsProdutodescricao.AsString;
      cdsProdutosAdicionadosPrecoUnitario.AsCurrency := dm.cdsProdutoprecounitario.AsCurrency;
      cdsProdutosAdicionadosQuantidade.AsInteger := 1;
      cdsProdutosAdicionadosValorTotal.AsCurrency := dm.cdsProdutoprecounitario.AsCurrency;
      cdsProdutosAdicionadosCodigoProduto.AsInteger := dm.cdsProdutocodigo.AsInteger;
      FValorTotalGeral := FValorTotalGeral + dm.cdsProdutoprecounitario.AsCurrency;
      cdsProdutosAdicionados.Post;
      StatusBar2.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgProdutosAdicionados.DataSource.DataSet.RecordCount);
    end;
  end;

  if TipoAcaoProduto = eExcluir then
  begin
    cValorTotal := cdsProdutosAdicionadosValorTotal.AsCurrency - cdsProdutosAdicionadosPrecoUnitario.AsCurrency;
    cdsProdutosAdicionados.Edit;
    cdsProdutosAdicionadosQuantidade.AsInteger := cdsProdutosAdicionadosQuantidade.AsInteger - 1;
    cdsProdutosAdicionadosValorTotal.AsCurrency := cValorTotal;
    cdsProdutosAdicionados.Post;
  end;
end;

end.
