unit Controller.Principal;

interface

uses Horse, System.JSON, System.SysUtils, FireDAC.Comp.Client, Data.DB, DataSet.Serialize,
     Controller.Cliente, Controller.Fornecedor, Controller.Produto, Controller.Venda, Controller.ProdutosVendidos;

procedure Registry;

implementation

procedure Registry;
begin
  //Cliente
  THorse.Get('/cliente', ListarClientes);
  THorse.Get('/cliente/:codigo', ListarClienteId);
  THorse.Post('/cliente', InserirCliente);
  THorse.Put('/cliente', EditarCliente);
  THorse.Delete('/cliente/:codigo', ExcluirCliente);

  //Fornecedor
  THorse.Get('/fornecedor', ListarFornecedores);
  THorse.Get('/fornecedor/:codigo', ListarFornecedorId);
  THorse.Post('/fornecedor', InserirFornecedor);
  THorse.Put('/fornecedor', EditarFornecedor);
  THorse.Delete('/fornecedor/:codigo', ExcluirFornecedor);

  //Produto
  THorse.Get('/produto', ListarProdutos);
  THorse.Get('/produto/:codigo', ListarProdutoId);
  THorse.Post('/produto', InserirProduto);
  THorse.Put('/produto', EditarProduto);
  THorse.Delete('/produto/:codigo', ExcluirProduto);

  //Venda
  THorse.Get('/venda', ListarVendas);
  THorse.Get('/venda/:numerovenda', ListarVendaId);
  THorse.Post('/venda', InserirVenda);
  THorse.Put('/venda', EditarVenda);
  THorse.Delete('/venda/:numerovenda', ExcluirVenda);

  //Produtos Vendidos
  THorse.Get('/produtosvendidos', ListarProdutosVendidos);
  THorse.Get('/produtosvendidos/:codigocliente', ListarProdutosVendidosId);
  THorse.Post('/produtosvendidos', InserirProdutosVendidos);
  THorse.Put('/produtosvendidos', EditarProdutosVendidos);
  THorse.Delete('/produtosvendidos/:codigocliente', ExcluirProdutosVendidos);

  THorse.Listen(9000);
end;

end.

