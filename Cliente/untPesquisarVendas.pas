unit untPesquisarVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmPesquisarVendas = class(TForm)
    pnlBotoes: TPanel;
    btnAceitar: TBitBtn;
    btnLimpar: TBitBtn;
    btnCancelar: TBitBtn;
    pnlCampos: TPanel;
    lblValorTotalVenda: TLabel;
    lblDataHoraVenda: TLabel;
    lblCliente: TLabel;
    lblNumeroVenda: TLabel;
    lblStatus: TLabel;
    edtValorTotalVenda: TEdit;
    edtNumeroVenda: TEdit;
    cmbStatus: TComboBox;
    edtDataHoraVenda: TMaskEdit;
    edtNomeCliente: TEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAceitarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure LimpaCampos;
    procedure FormShow(Sender: TObject);
    procedure edtValorTotalVendaChange(Sender: TObject);
    procedure edtValorTotalVendaEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesquisarVendas: TfrmPesquisarVendas;

implementation

{$R *.dfm}

uses untDM, untCadastroProdutos, untCadastroVendas;

procedure TfrmPesquisarVendas.btnAceitarClick(Sender: TObject);
var
  sFiltro, sValorTotalVenda: string;
  sLista: TStringList;
  i: integer;
begin
  sFiltro := '';
  sValorTotalVenda := StringReplace(edtValorTotalVenda.Text, '.', '', [rfIgnoreCase, rfReplaceAll]);
  sLista := TStringList.Create;
  try
    if edtNumeroVenda.Text <> '' then
      sLista.Add('numerovenda = ' + edtNumeroVenda.Text);

    if edtNomeCliente.Text <> '' then
      sLista.Add('nome like ' + QuotedStr('%' + edtNomeCliente.Text + '%'));

    if edtDataHoraVenda.Text <> '' then
      sLista.Add('datahora like ' + QuotedStr('%' +edtDataHoraVenda.EditText + '%'));

    if edtValorTotalVenda.Text <> '0,00' then
      sLista.Add('valortotal = ' + sValorTotalVenda);

    if cmbStatus.Text = 'Efetivada' then
      sLista.Add('status = ' + QuotedStr('True'));
    if cmbStatus.Text = 'Pendente' then
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

    dm.cdsVenda.Filtered := false;
    dm.cdsVenda.Filter := sFiltro;
    dm.cdsVenda.Filtered := true;
    frmCadastroVendas.ProcessaProdutosVendidosGetId;
    Close;
  finally
    sLista.Free;
  end;
end;

procedure TfrmPesquisarVendas.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPesquisarVendas.btnLimparClick(Sender: TObject);
begin
  LimpaCampos;
end;

procedure TfrmPesquisarVendas.edtValorTotalVendaChange(Sender: TObject);
begin
  edtValorTotalVenda.Text := frmCadastroProdutos.FormatarMoeda(edtValorTotalVenda.Text);
  edtValorTotalVenda.SelStart := Length(edtValorTotalVenda.Text);
end;

procedure TfrmPesquisarVendas.edtValorTotalVendaEnter(Sender: TObject);
begin
  edtValorTotalVenda.SelectAll;
end;

procedure TfrmPesquisarVendas.FormShow(Sender: TObject);
begin
  edtValorTotalVenda.Text := '0,00';
  LimpaCampos;
end;

procedure TfrmPesquisarVendas.LimpaCampos;
begin
  edtNumeroVenda.Clear;
  edtNomeCliente.Clear;
  edtDataHoraVenda.Clear;
  edtValorTotalVenda.Clear;
  cmbStatus.ItemIndex := 0;
end;

end.
