unit untPesquisarClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls;

type
  TfrmPesquisarClientes = class(TForm)
    pnlCampos: TPanel;
    lblCodigo: TLabel;
    lblNome: TLabel;
    lblCPF: TLabel;
    lblStatus: TLabel;
    lblDataNascimento: TLabel;
    edtCodigo: TEdit;
    edtNome: TEdit;
    edtCPF: TMaskEdit;
    edtDataNascimento: TMaskEdit;
    cmbStatus: TComboBox;
    pnlBotoes: TPanel;
    btnAceitar: TBitBtn;
    btnLimpar: TBitBtn;
    btnCancelar: TBitBtn;
    procedure btnAceitarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure LimpaCampos;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesquisarClientes: TfrmPesquisarClientes;

implementation

{$R *.dfm}

uses untDM, untCadastroClientes;

procedure TfrmPesquisarClientes.btnAceitarClick(Sender: TObject);
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

    if edtNome.Text <> '' then
      sLista.Add('nome like ' + QuotedStr('%' + edtNome.Text + '%'));

    if edtCPF.Text <> '' then
      sLista.Add('cpf = ' + edtCPF.Text);

    if cmbStatus.Text = 'Ativo' then
      sLista.Add('status = ' + QuotedStr('True'));
    if cmbStatus.Text = 'Inativo' then
      sLista.Add('status = ' + QuotedStr('False'));

    if edtDataNascimento.Text <> '' then
      sLista.Add('dataNascimento = ' + QuotedStr(edtDataNascimento.EditText));

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

    dm.cdsCliente.Filtered := false;
    dm.cdsCliente.Filter := sFiltro;
    dm.cdsCliente.Filtered := true;
    Close;
  finally
    sLista.Free;
  end;
end;

procedure TfrmPesquisarClientes.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPesquisarClientes.btnLimparClick(Sender: TObject);
begin
  LimpaCampos;
end;

procedure TfrmPesquisarClientes.FormShow(Sender: TObject);
begin
  LimpaCampos;
end;

procedure TfrmPesquisarClientes.LimpaCampos;
begin
  edtCodigo.Clear;
  edtNome.Clear;
  edtCPF.Clear;
  cmbStatus.ItemIndex := 0;
  edtDataNascimento.Clear;
  edtCodigo.SetFocus;
end;

end.
