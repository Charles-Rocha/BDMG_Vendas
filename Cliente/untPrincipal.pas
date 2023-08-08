unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Rest.Types, System.JSON,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, Vcl.Menus, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmBDMGVendas = class(TForm)
    FDConnection1: TFDConnection;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    MainMenu1: TMainMenu;
    BancodeDados1: TMenuItem;
    Cadastro1: TMenuItem;
    Ajuda1: TMenuItem;
    Sobre1: TMenuItem;
    Configurar1: TMenuItem;
    CadastrodeClientes1: TMenuItem;
    CadastrodeFornecedores1: TMenuItem;
    CadastrodeProdutos1: TMenuItem;
    Image1: TImage;
    Image2: TImage;
    edtTelefones: TEdit;
    N1: TMenuItem;
    Vendas2: TMenuItem;
    procedure Sobre1Click(Sender: TObject);
    procedure Configurar1Click(Sender: TObject);
    procedure CadastrodeClientes1Click(Sender: TObject);
    procedure CadastrodeFornecedores1Click(Sender: TObject);
    procedure CadastrodeProdutos1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Vendas2Click(Sender: TObject);
    procedure InicializarGetRequests;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBDMGVendas: TfrmBDMGVendas;

implementation

{$R *.dfm}

uses untSobre, untConfigurarBancoDados, untDM, untCadastroClientes, untCadastroFornecedores, untCadastroProdutos, untCadastroVendas;

procedure TfrmBDMGVendas.CadastrodeClientes1Click(Sender: TObject);
begin
  frmCadastroClientes.ShowModal;
end;

procedure TfrmBDMGVendas.CadastrodeFornecedores1Click(Sender: TObject);
begin
  frmCadastroFornecedores.ShowModal;
end;

procedure TfrmBDMGVendas.CadastrodeProdutos1Click(Sender: TObject);
begin
  frmCadastroProdutos.ShowModal;
end;

procedure TfrmBDMGVendas.Configurar1Click(Sender: TObject);
begin
  frmConfigurarBancoDados.ShowModal;
end;

procedure TfrmBDMGVendas.FormShow(Sender: TObject);
begin
  InicializarGetRequests;
end;

procedure TfrmBDMGVendas.InicializarGetRequests;
begin
  dm.ReqClienteGet.Execute;
  dm.ReqFornecedorGet.Execute;
  dm.ReqProdutoGet.Execute;
  dm.ReqVendaGet.Execute;
  dm.ReqProdutosVendidosGet.Execute;
end;

procedure TfrmBDMGVendas.Sobre1Click(Sender: TObject);
begin
  frmSobre.ShowModal;
end;

procedure TfrmBDMGVendas.Vendas2Click(Sender: TObject);
begin
  frmCadastroVendas.ShowModal;
end;

end.
