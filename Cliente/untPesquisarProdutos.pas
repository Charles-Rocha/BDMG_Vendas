unit untPesquisarProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmPesquisarProdutos = class(TForm)
    pnlBotoes: TPanel;
    btnAceitar: TBitBtn;
    btnLimpar: TBitBtn;
    btnCancelar: TBitBtn;
    pnlCampos: TPanel;
    lblFornecedor: TLabel;
    lblStatus: TLabel;
    lblPrecoUnitario: TLabel;
    lblDescricao: TLabel;
    lblCodigo: TLabel;
    edtDescricao: TEdit;
    edtCodigo: TEdit;
    cmbStatus: TComboBox;
    edtPrecoUnitario: TMaskEdit;
    edtFornecedor: TEdit;
    procedure btnAceitarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtPrecoUnitarioChange(Sender: TObject);
    procedure edtPrecoUnitarioEnter(Sender: TObject);
  private
    { Private declarations }
    procedure LimpaCampos;
  public
    { Public declarations }
  end;

var
  frmPesquisarProdutos: TfrmPesquisarProdutos;

implementation

{$R *.dfm}

uses untCadastroProdutos, untDM;

procedure TfrmPesquisarProdutos.btnAceitarClick(Sender: TObject);
var
  sFiltro, sPrecoUnitario: string;
  sLista: TStringList;
  i: integer;
begin
  sFiltro := '';
  sPrecoUnitario := StringReplace(edtPrecoUnitario.Text, '.', '', [rfIgnoreCase, rfReplaceAll]);
  sLista := TStringList.Create;
  try
    if edtCodigo.Text <> '' then
      sLista.Add('codigo = ' + edtCodigo.Text);

    if edtDescricao.Text <> '' then
      sLista.Add('descricao like ' + QuotedStr('%' + edtDescricao.Text + '%'));

    if edtPrecoUnitario.Text <> '0,00' then
      sLista.Add('precounitario like ' + QuotedStr('%' + sPrecoUnitario + '%'));

    if edtFornecedor.Text <> '' then
      sLista.Add('nomefantasia like ' + QuotedStr('%' + edtFornecedor.Text + '%'));

    if cmbStatus.Text = 'Ativo' then
      sLista.Add('status = ' + QuotedStr('True'));
    if cmbStatus.Text = 'Inativo' then
      sLista.Add('status = ' + QuotedStr('False'));

    for i := 0 to sLista.Count-1 do
    begin
      if sLista.Count = 1 then
        sFiltro := sLista.Strings[i];

      if sLista.Count = 2 then
      begin
        if i = 0 then
          sFiltro := sFiltro + sLista.Strings[i] + ' and ';
        if i = 1 then
          sFiltro := sFiltro + sLista.Strings[i];
      end;

      if sLista.Count = 3 then
      begin
        if (i = 0) or (i = 1) then
          sFiltro := sFiltro + sLista.Strings[i] + ' and ';
        if i = 2 then
          sFiltro := sFiltro + sLista.Strings[i];
      end;

      if sLista.Count = 4 then
      begin
        if (i = 0) or (i = 1) or (i = 2) then
          sFiltro := sFiltro + sLista.Strings[i] + ' and ';
        if i = 3 then
          sFiltro := sFiltro + sLista.Strings[i];
      end;

      if sLista.Count = 5 then
      begin
        if (i = 0) or (i = 1) or (i = 2) or (i = 3) then
          sFiltro := sFiltro + sLista.Strings[i] + ' and ';
        if i = 4 then
          sFiltro := sFiltro + sLista.Strings[i];
      end;
    end;

    dm.cdsProduto.Filtered := false;
    dm.cdsProduto.Filter := sFiltro;
    dm.cdsProduto.Filtered := true;

    frmCadastroProdutos.StatusBar1.Panels[0].Text := 'Total de registros: ' +
      IntToStr(frmCadastroProdutos.dbgBaseCadastro.DataSource.DataSet.RecordCount);
  finally
    sLista.Free;
    Close;
  end;
end;

procedure TfrmPesquisarProdutos.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPesquisarProdutos.btnLimparClick(Sender: TObject);
begin
  LimpaCampos;
end;

procedure TfrmPesquisarProdutos.edtPrecoUnitarioChange(Sender: TObject);
begin
  edtPrecoUnitario.Text := frmCadastroProdutos.FormatarMoeda(edtPrecoUnitario.Text);
  edtPrecoUnitario.SelStart := Length(edtPrecoUnitario.Text);
end;

procedure TfrmPesquisarProdutos.edtPrecoUnitarioEnter(Sender: TObject);
begin
  edtPrecoUnitario.SelectAll;
end;

procedure TfrmPesquisarProdutos.FormShow(Sender: TObject);
begin
  edtPrecoUnitario.Text := '0,00';
  LimpaCampos;
end;

procedure TfrmPesquisarProdutos.LimpaCampos;
begin
  edtCodigo.Clear;
  edtDescricao.Clear;
  edtPrecoUnitario.Clear;
  edtFornecedor.Clear;
  cmbStatus.ItemIndex := 0;
  edtCodigo.SetFocus;
end;

end.
