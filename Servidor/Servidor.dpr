program Servidor;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  System.SysUtils,
  Controller.Cliente in 'Controller\Controller.Cliente.pas',
  Model.Connection in 'Model\Model.Connection.pas',
  Model.Cliente in 'Model\Model.Cliente.pas',
  Controller.Fornecedor in 'Controller\Controller.Fornecedor.pas',
  Model.Fornecedor in 'Model\Model.Fornecedor.pas',
  Controller.Produto in 'Controller\Controller.Produto.pas',
  Controller.Venda in 'Controller\Controller.Venda.pas',
  Model.Produto in 'Model\Model.Produto.pas',
  Model.Venda in 'Model\Model.Venda.pas',
  Controller.Principal in 'Controller\Controller.Principal.pas',
  Controller.ProdutosVendidos in 'Controller\Controller.ProdutosVendidos.pas',
  Model.ProdutosVendidos in 'Model\Model.ProdutosVendidos.pas';

begin
  THorse.Use(Jhonson());
  Controller.Principal.Registry;
  THorse.Listen(9000);
end.
