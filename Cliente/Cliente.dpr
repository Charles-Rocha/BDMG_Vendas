program Cliente;

uses
  Vcl.Forms,
  untPrincipal in 'untPrincipal.pas' {frmBDMGVendas},
  untTelaBaseCRUD in 'untTelaBaseCRUD.pas' {frmTelaBaseCRUD},
  untSobre in 'untSobre.pas' {frmSobre},
  untConfigurarBancoDados in 'untConfigurarBancoDados.pas' {frmConfigurarBancoDados},
  untDM in 'untDM.pas' {dm: TDataModule},
  untCadastroClientes in 'untCadastroClientes.pas' {frmCadastroClientes},
  untCadastroFornecedores in 'untCadastroFornecedores.pas' {frmCadastroFornecedores},
  untCadastroProdutos in 'untCadastroProdutos.pas' {frmCadastroProdutos},
  untCadastroVendas in 'untCadastroVendas.pas' {frmCadastroVendas},
  untPesquisarClientes in 'untPesquisarClientes.pas' {frmPesquisarClientes},
  untPesquisarFornecedores in 'untPesquisarFornecedores.pas' {frmPesquisarFornecedores},
  untPesquisarProdutos in 'untPesquisarProdutos.pas' {frmPesquisarProdutos},
  untPesquisarVendas in 'untPesquisarVendas.pas' {frmPesquisarVendas},
  untProdutos in 'untProdutos.pas' {frmProdutos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmBDMGVendas, frmBDMGVendas);
  Application.CreateForm(TfrmTelaBaseCRUD, frmTelaBaseCRUD);
  Application.CreateForm(TfrmSobre, frmSobre);
  Application.CreateForm(TfrmConfigurarBancoDados, frmConfigurarBancoDados);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmCadastroClientes, frmCadastroClientes);
  Application.CreateForm(TfrmCadastroFornecedores, frmCadastroFornecedores);
  Application.CreateForm(TfrmCadastroProdutos, frmCadastroProdutos);
  Application.CreateForm(TfrmCadastroVendas, frmCadastroVendas);
  Application.CreateForm(TfrmPesquisarClientes, frmPesquisarClientes);
  Application.CreateForm(TfrmPesquisarFornecedores, frmPesquisarFornecedores);
  Application.CreateForm(TfrmPesquisarProdutos, frmPesquisarProdutos);
  Application.CreateForm(TfrmPesquisarVendas, frmPesquisarVendas);
  Application.CreateForm(TfrmProdutos, frmProdutos);
  Application.Run;
end.
