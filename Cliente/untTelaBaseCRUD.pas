unit untTelaBaseCRUD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ExtCtrls, Data.DB,
  Datasnap.DBClient;

type
  TfrmTelaBaseCRUD = class(TForm)
    pnlBotoes: TPanel;
    pnlDBGrid: TPanel;
    StatusBar1: TStatusBar;
    dbgBaseCadastro: TDBGrid;
    btnInserir: TBitBtn;
    btnEditar: TBitBtn;
    btnApagar: TBitBtn;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    DataSource1: TDataSource;
    btnPesquisar: TBitBtn;
    btnAtualizar: TBitBtn;
    procedure btnInserirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure HabilitaBotoes;
    procedure DesabilitaBotoes;
  public
    { Public declarations }
  end;

var
  frmTelaBaseCRUD: TfrmTelaBaseCRUD;

implementation

{$R *.dfm}

procedure TfrmTelaBaseCRUD.btnCancelarClick(Sender: TObject);
begin
  HabilitaBotoes;
end;

procedure TfrmTelaBaseCRUD.btnEditarClick(Sender: TObject);
begin
  DesabilitaBotoes;
end;

procedure TfrmTelaBaseCRUD.btnGravarClick(Sender: TObject);
begin
  HabilitaBotoes;
end;

procedure TfrmTelaBaseCRUD.btnApagarClick(Sender: TObject);
begin
  if not dbgBaseCadastro.DataSource.DataSet.IsEmpty then
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
end;

procedure TfrmTelaBaseCRUD.btnInserirClick(Sender: TObject);
begin
  DesabilitaBotoes;
end;

procedure TfrmTelaBaseCRUD.DesabilitaBotoes;
begin
  btnInserir.Enabled := false;
  btnEditar.Enabled := false;
  btnApagar.Enabled := false;
  btnPesquisar.Enabled := false;
  btnAtualizar.Enabled := false;
  btnCancelar.Enabled := true;
  btnGravar.Enabled := true;
end;

procedure TfrmTelaBaseCRUD.FormShow(Sender: TObject);
begin
  btnCancelar.Enabled := false;
  btnGravar.Enabled := false;
end;

procedure TfrmTelaBaseCRUD.HabilitaBotoes;
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

end.
