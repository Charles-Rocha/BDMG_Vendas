unit Controller.Produto;

interface

uses Horse, System.JSON, System.SysUtils, Model.Produto, FireDAC.Comp.Client, Data.DB, DataSet.Serialize;

procedure ListarProdutos(Req: THorseRequest; Res: THorseResponse);
procedure ListarProdutoId(Req: THorseRequest; Res: THorseResponse);
procedure InserirProduto(Req: THorseRequest; Res: THorseResponse);
procedure EditarProduto(Req: THorseRequest; Res: THorseResponse);
procedure ExcluirProduto(Req: THorseRequest; Res: THorseResponse);

implementation

procedure ListarProdutos(Req: THorseRequest; Res: THorseResponse);
var
  produtos: TProduto;
  qry: TFDQuery;
  sErro: string;
  arrayProdutos: TJSONArray;
begin
  try
    produtos := TProduto.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    qry := produtos.ListarProdutos('', sErro);
    arrayProdutos := qry.ToJSONArray();
    res.Send<TJSONArray>(arrayProdutos);
  finally
    produtos.Free;
  end;
end;

procedure ListarProdutoId(Req: THorseRequest; Res: THorseResponse);
var
  produtos: TProduto;
  qry: TFDQuery;
  sErro: string;
  objProdutos: TJSONObject;
begin
  try
    produtos := TProduto.Create;
    produtos.Codigo := Req.Params['codigo'].ToInteger;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    qry := produtos.ListarProdutos('', sErro);

    if qry.RecordCount > 0 then
    begin
      objProdutos := qry.ToJSONObject();
      res.Send<TJSONObject>(objProdutos);
    end
    else
    begin
      res.Send('Produto não encontrado').Status(404);
    end;

  finally
    produtos.Free;
  end;
end;

procedure InserirProduto(Req: THorseRequest; Res: THorseResponse);
var
  produtos: TProduto;
  erro: string;
  objProduto: TJSONObject;
  body: TJSONValue;
begin
  try
    produtos := TProduto.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    try
      body := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(req.Body), 0) as TJsonValue;

      produtos.Descricao := UTF8Decode(body.GetValue<string>('descricao', ''));
      produtos.PrecoUnitario := body.GetValue<double>('precounitario', 0);
      produtos.CodigoFornecedor := body.GetValue<integer>('codigofornecedor', 0);
      produtos.Status := body.GetValue<string>('status', '');
      produtos.InserirProduto(erro);

      body.Free;

      if erro <> '' then
        raise Exception.Create(erro);

    except on e: exception do
      begin
        res.Send(e.Message).Status(400);
        exit;
      end;
    end;

    objProduto := TJSONObject.Create;
    objProduto.AddPair('codigo', produtos.Codigo.ToString);

    res.Send<TJSONObject>(objProduto).Status(201);

  finally
    produtos.Free;
  end;
end;

procedure EditarProduto(Req: THorseRequest; Res: THorseResponse);
var
  produtos: TProduto;
  erro: string;
  objProduto: TJSONObject;
  body: TJSONValue;
begin
  try
    produtos := TProduto.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    try
      body := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(req.Body), 0) as TJsonValue;

      produtos.Codigo := body.GetValue<integer>('codigo', 0);
      produtos.Descricao := UTF8Decode(body.GetValue<string>('descricao', ''));
      produtos.PrecoUnitario := body.GetValue<double>('precounitario', 0);
      produtos.CodigoFornecedor := body.GetValue<integer>('codigofornecedor', 0);
      produtos.Status := body.GetValue<string>('status', '');
      produtos.EditarProduto(erro);

      body.Free;

      if erro <> '' then
        raise Exception.Create(erro);

    except on e: exception do
      begin
        res.Send(e.Message).Status(400);
        exit;
      end;
    end;

    objProduto := TJSONObject.Create;
    objProduto.AddPair('codigo', produtos.Codigo.ToString);

    res.Send<TJSONObject>(objProduto).Status(200);

  finally
    produtos.Free;
  end;
end;

procedure ExcluirProduto(Req: THorseRequest; Res: THorseResponse);
var
  produtos: TProduto;
  erro: string;
  objProduto: TJSONObject;
begin
  try
    produtos := TProduto.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    try
      produtos.Codigo := Req.Params['codigo'].ToInteger;

      if not produtos.ExcluirProduto(erro) then
        raise Exception.Create(erro);

    except on e: exception do
      begin
        res.Send(e.Message).Status(400);
        exit;
      end;
    end;

    objProduto := TJSONObject.Create;
    objProduto.AddPair('codigo', produtos.Codigo.ToString);

    res.Send<TJSONObject>(objProduto).Status(200);
  finally
    produtos.Free;
  end;
end;

end.

