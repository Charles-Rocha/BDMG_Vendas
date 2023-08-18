unit Controller.ProdutosVendidos;

interface

uses Horse, System.JSON, System.SysUtils, Model.Cliente, Model.ProdutosVendidos,
     FireDAC.Comp.Client, Data.DB, DataSet.Serialize, Controller.Fornecedor;

procedure ListarProdutosVendidos(Req: THorseRequest; Res: THorseResponse);
procedure ListarProdutosVendidosId(Req: THorseRequest; Res: THorseResponse);
procedure InserirProdutosVendidos(Req: THorseRequest; Res: THorseResponse);
procedure EditarProdutosVendidos(Req: THorseRequest; Res: THorseResponse);
procedure ExcluirProdutosVendidos(Req: THorseRequest; Res: THorseResponse);

implementation

procedure ListarProdutosVendidos(Req: THorseRequest; Res: THorseResponse);
var
  produtosvendidos: TProdutosVendidos;
  qry: TFDQuery;
  sErro: string;
  arrayProdutosVendidos: TJSONArray;
begin
  try
    produtosvendidos := TProdutosVendidos.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    qry := produtosvendidos.ListarProdutosVendidos('', sErro);
    arrayProdutosVendidos := qry.ToJSONArray();
    res.Send<TJSONArray>(arrayProdutosVendidos);
  finally
    produtosvendidos.Free;
  end;
end;

procedure ListarProdutosVendidosId(Req: THorseRequest; Res: THorseResponse);
var
  produtosvendidos: TProdutosVendidos;
  qry: TFDQuery;
  sErro: string;
  objProdutosVendidos: TJSONObject;
  arrayProdutosVendidos: TJSONArray;
begin
  try
    produtosvendidos := TProdutosVendidos.Create;
    produtosvendidos.CodigoCliente := Req.Params['CodigoCliente'].ToInteger;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    qry := produtosvendidos.ListarProdutosVendidos('', sErro);

    if qry.RecordCount > 0 then
    begin
      arrayProdutosVendidos := qry.ToJSONArray();
      res.Send<TJSONArray>(arrayProdutosVendidos);
    end
    else
    begin
      res.Send('Produtos Vendidos não encontrado').Status(404);
    end;

  finally
    produtosvendidos.Free;
  end;
end;

procedure InserirProdutosVendidos(Req: THorseRequest; Res: THorseResponse);
var
  produtosvendidos: TProdutosVendidos;
  erro: string;
  objProdutosVendidos: TJSONObject;
  body: TJSONValue;
begin
  try
    produtosvendidos := TProdutosVendidos.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    try
      body := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(req.Body), 0) as TJsonValue;

      produtosvendidos.Descricao := UTF8Decode(body.GetValue<string>('descricao', ''));
      produtosvendidos.PrecoUnitario := body.GetValue<double>('precounitario', 0);
      produtosvendidos.QuantidadeVendida := body.GetValue<integer>('quantidadevendida', 0);
      produtosvendidos.ValorTotal := body.GetValue<double>('valortotal', 0);
      produtosvendidos.CodigoCliente := body.GetValue<integer>('codigocliente', 0);
      produtosvendidos.CodigoProduto := body.GetValue<integer>('codigoproduto', 0);
      produtosvendidos.CodigoNumeroVenda := body.GetValue<integer>('codigonumerovenda', 0);
      produtosvendidos.InserirProdutosVendidos(erro);

      body.Free;

      if erro <> '' then
        raise Exception.Create(erro);

    except on e: exception do
      begin
        res.Send(e.Message).Status(400);
        exit;
      end;
    end;

    objProdutosVendidos := TJSONObject.Create;
    objProdutosVendidos.AddPair('Codigo', produtosvendidos.Codigo.ToString);

    res.Send<TJSONObject>(objProdutosVendidos).Status(201);

  finally
    produtosvendidos.Free;
  end;
end;

procedure EditarProdutosVendidos(Req: THorseRequest; Res: THorseResponse);
var
  produtosvendidos: TProdutosVendidos;
  erro: string;
  objProdutosVendidos: TJSONObject;
  body: TJSONValue;
begin
  try
    produtosvendidos := TProdutosVendidos.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    try
      body := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(req.Body), 0) as TJsonValue;

      produtosvendidos.Codigo := body.GetValue<integer>('codigo', 0);
      produtosvendidos.Descricao := UTF8Decode(body.GetValue<string>('descricao', ''));
      produtosvendidos.PrecoUnitario := body.GetValue<double>('precounitario', 0);
      produtosvendidos.QuantidadeVendida := body.GetValue<integer>('quantidadevendida', 0);
      produtosvendidos.ValorTotal := body.GetValue<double>('valortotal', 0);
      produtosvendidos.CodigoCliente := body.GetValue<integer>('codigocliente', 0);
      produtosvendidos.CodigoProduto := body.GetValue<integer>('codigoproduto', 0);
      produtosvendidos.CodigoNumeroVenda := body.GetValue<integer>('codigonumerovenda', 0);
      produtosvendidos.EditarProdutosVendidos(erro);

      body.Free;

      if erro <> '' then
        raise Exception.Create(erro);

    except on e: exception do
      begin
        res.Send(e.Message).Status(400);
        exit;
      end;
    end;

    objProdutosVendidos := TJSONObject.Create;
    objProdutosVendidos.AddPair('Codigo', produtosvendidos.Codigo.ToString);

    res.Send<TJSONObject>(objProdutosVendidos).Status(200);

  finally
    produtosvendidos.Free;
  end;
end;

procedure ExcluirProdutosVendidos(Req: THorseRequest; Res: THorseResponse);
var
  produtosvendidos: TProdutosVendidos;
  erro: string;
  objProdutosVendidos: TJSONObject;
begin
  try
    produtosvendidos := TProdutosVendidos.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    try
      produtosvendidos.CodigoCliente := Req.Params['CodigoCliente'].ToInteger;

      if not produtosvendidos.ExcluirProdutosVendidos(erro) then
        raise Exception.Create(erro);

    except on e: exception do
      begin
        res.Send(e.Message).Status(400);
        exit;
      end;
    end;

    objProdutosVendidos := TJSONObject.Create;
    objProdutosVendidos.AddPair('Codigo', produtosvendidos.Codigo.ToString);

    res.Send<TJSONObject>(objProdutosVendidos).Status(200);
  finally
    produtosvendidos.Free;
  end;
end;

end.
