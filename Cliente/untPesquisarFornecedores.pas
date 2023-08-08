unit untPesquisarFornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls;

type
  TfrmPesquisarFornecedores = class(TForm)
    pnlCampos: TPanel;
    lblCodigo: TLabel;
    lblNomeFantasia: TLabel;
    edtCodigo: TEdit;
    edtNomeFantasia: TEdit;
    pnlBotoes: TPanel;
    btnAceitar: TBitBtn;
    btnLimpar: TBitBtn;
    btnCancelar: TBitBtn;
    lblRazaoSocial: TLabel;
    edtRazaoSocial: TEdit;
    lblCNPJ: TLabel;
    edtCNPJ: TMaskEdit;
    lblStatus: TLabel;
    cmbStatus: TComboBox;
    procedure btnLimparClick(Sender: TObject);
    procedure btnAceitarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure LimpaCampos;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesquisarFornecedores: TfrmPesquisarFornecedores;

implementation

{$R *.dfm}

uses untDM, untCadastroFornecedores;

procedure TfrmPesquisarFornecedores.btnAceitarClick(Sender: TObject);
var
  sFiltro: string;
  sLista: TStringList;
  i: integer;
begin
  sFiltro := '';
  sLista := TStringList.Create;
  try
    if edtCodigo.Text <> '' then
      sLista.Add('codigo = ' + edtCodigo.Text);

    if edtNomeFantasia.Text <> '' then
      sLista.Add('nomefantasia like ' + QuotedStr('%' + edtNomeFantasia.Text + '%'));

    if edtRazaoSocial.Text <> '' then
      sLista.Add('razaosocial like ' + QuotedStr('%' + edtRazaoSocial.Text + '%'));

    if edtCNPJ.Text <> '' then
      sLista.Add('cnpj = ' + edtCNPJ.Text);

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

    dm.cdsFornecedor.Filtered := false;
    dm.cdsFornecedor.Filter := sFiltro;
    dm.cdsFornecedor.Filtered := true;

    frmCadastroFornecedores.StatusBar1.Panels[0].Text := 'Total de registros: ' +
      IntToStr(frmCadastroFornecedores.dbgBaseCadastro.DataSource.DataSet.RecordCount);
    Close;
  finally
    sLista.Free;
  end;
end;

procedure TfrmPesquisarFornecedores.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPesquisarFornecedores.btnLimparClick(Sender: TObject);
begin
  LimpaCampos;
end;

procedure TfrmPesquisarFornecedores.FormShow(Sender: TObject);
begin
  LimpaCampos;
end;

procedure TfrmPesquisarFornecedores.LimpaCampos;
begin
  edtCodigo.Clear;
  edtNomeFantasia.Clear;
  edtRazaoSocial.Clear;
  edtCNPJ.Clear;
  cmbStatus.ItemIndex := 0;
  edtCodigo.SetFocus;
end;

end.
