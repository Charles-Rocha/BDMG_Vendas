unit untProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, untTelaBaseCRUD, Rest.Types, System.JSON, Vcl.Mask, Vcl.DBCtrls, Datasnap.DBClient;

type
  TfrmProdutos = class(TForm)
    pnlBotoes: TPanel;
    btnInserir: TBitBtn;
    btnCancelar: TBitBtn;
    btnAceitar: TBitBtn;
    pnlProdutosAdicionados: TPanel;
    dbgProdutosAdicionados: TDBGrid;
    dtsProdutosAdicionados: TDataSource;
    dtsFornecedores: TDataSource;
    dtsProdutos: TDataSource;
    pnlProdutos: TPanel;
    dbgProdutos: TDBGrid;
    cdsProdutosAdicionados: TClientDataSet;
    cdsProdutosAdicionadosCodigo: TIntegerField;
    cdsProdutosAdicionadosDescricao: TStringField;
    cdsProdutosAdicionadosPrecoUnitario: TFloatField;
    cdsProdutosAdicionadosQuantidade: TIntegerField;
    cdsProdutosAdicionadosValorTotal: TFloatField;
    cdsProdutosAdicionadosCodigoProduto: TIntegerField;
    pnlProdutosAdicionadosParaVenda: TPanel;
    lblProdutosAdicionadosParaVenda: TLabel;
    StatusBar1: TStatusBar;
    StatusBar2: TStatusBar;
    procedure btnInserirClick(Sender: TObject);
    procedure btnAceitarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    FValorTotalGeral: Currency;

  public
    { Public declarations }
    property ValorTotalGeral: Currency read FValorTotalGeral write FValorTotalGeral;
  end;

var
  frmProdutos: TfrmProdutos;

implementation

{$R *.dfm}

uses untDM;

procedure TfrmProdutos.btnCancelarClick(Sender: TObject);
begin
  cdsProdutosAdicionados.EmptyDataSet;
  Close;
end;

procedure TfrmProdutos.btnAceitarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmProdutos.btnInserirClick(Sender: TObject);
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

  cdsProdutosAdicionados.First;
  while not cdsProdutosAdicionados.Eof do
  begin
    if cdsProdutosAdicionadosCodigo.AsInteger = dm.cdsProdutocodigo.AsInteger then
    begin
      iQuantidade := iQuantidade + 1 + cdsProdutosAdicionadosQuantidade.AsInteger;
      cValorTotal := cValorTotal + cdsProdutosAdicionadosValorTotal.AsCurrency + dm.cdsProdutoprecounitario.AsCurrency;
      FValorTotalGeral := FValorTotalGeral + dm.cdsProdutoprecounitario.AsCurrency;

      cdsProdutosAdicionados.Edit;
      cdsProdutosAdicionadosCodigo.AsString := dm.cdsProdutocodigo.AsString;
      cdsProdutosAdicionadosDescricao.AsString := dm.cdsProdutodescricao.AsString;
      cdsProdutosAdicionadosPrecoUnitario.AsCurrency := dm.cdsProdutoprecounitario.AsCurrency;
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
    cdsProdutosAdicionadosCodigo.AsString := dm.cdsProdutocodigo.AsString;
    cdsProdutosAdicionadosDescricao.AsString := dm.cdsProdutodescricao.AsString;
    cdsProdutosAdicionadosPrecoUnitario.AsString := dm.cdsProdutoprecounitario.AsString;
    cdsProdutosAdicionadosQuantidade.AsInteger := 1;
    cdsProdutosAdicionadosValorTotal.AsCurrency := dm.cdsProdutoprecounitario.AsCurrency;
    FValorTotalGeral := FValorTotalGeral + dm.cdsProdutoprecounitario.AsCurrency;
    cdsProdutosAdicionados.Post;
    StatusBar2.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgProdutosAdicionados.DataSource.DataSet.RecordCount);
  end;
end;

procedure TfrmProdutos.FormShow(Sender: TObject);
begin
  FValorTotalGeral := 0;
  StatusBar1.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgProdutos.DataSource.DataSet.RecordCount);
  StatusBar2.Panels[0].Text := 'Total de registros: ' + IntToStr(dbgProdutosAdicionados.DataSource.DataSet.RecordCount);
end;

end.
