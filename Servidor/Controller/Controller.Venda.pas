unit Controller.Venda;

interface

uses Horse, System.JSON, System.SysUtils, Model.Venda, FireDAC.Comp.Client, Data.DB, DataSet.Serialize;

procedure ListarVendas(Req: THorseRequest; Res: THorseResponse);
procedure ListarVendaId(Req: THorseRequest; Res: THorseResponse);
procedure InserirVenda(Req: THorseRequest; Res: THorseResponse);
procedure EditarVenda(Req: THorseRequest; Res: THorseResponse);
procedure ExcluirVenda(Req: THorseRequest; Res: THorseResponse);

implementation

procedure ListarVendas(Req: THorseRequest; Res: THorseResponse);
var
  vendas: TVenda;
  qry: TFDQuery;
  sErro: string;
  arrayVendas: TJSONArray;
begin
  try
    vendas := TVenda.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    qry := vendas.ListarVendas('', sErro);
    arrayVendas := qry.ToJSONArray();
    res.Send<TJSONArray>(arrayVendas);
  finally
    vendas.Free;
  end;
end;

procedure ListarVendaId(Req: THorseRequest; Res: THorseResponse);
var
  vendas: TVenda;
  qry: TFDQuery;
  sErro: string;
  objVendas: TJSONObject;
begin
  try
    vendas := TVenda.Create;
    vendas.NumeroVenda := Req.Params['NumeroVenda'].ToInteger;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    qry := vendas.ListarVendas('', sErro);

    if qry.RecordCount > 0 then
    begin
      objVendas := qry.ToJSONObject();
      res.Send<TJSONObject>(objVendas);
    end
    else
    begin
      res.Send('Venda não encontrado').Status(404);
    end;

  finally
    vendas.Free;
  end;
end;

procedure InserirVenda(Req: THorseRequest; Res: THorseResponse);
var
  vendas: TVenda;
  erro: string;
  objVenda: TJSONObject;
  body: TJSONValue;
begin
  try
    vendas := TVenda.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    try
      body := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(req.Body), 0) as TJsonValue;

      vendas.CodigoCliente := body.GetValue<Integer>('codigocliente', 0);
      vendas.DataHora := body. GetValue<string>('datahora', '');
      vendas.ValorTotal := body.GetValue<Currency>('valortotal', 0);
      vendas.Status := body.GetValue<string>('status', '');
      vendas.InserirVenda(erro);

      body.Free;

      if erro <> '' then
        raise Exception.Create(erro);

    except on e: exception do
      begin
        res.Send(e.Message).Status(400);
        exit;
      end;
    end;

    objVenda := TJSONObject.Create;
    objVenda.AddPair('NumeroVenda', vendas.NumeroVenda.ToString);

    res.Send<TJSONObject>(objVenda).Status(201);

  finally
    vendas.Free;
  end;
end;

procedure EditarVenda(Req: THorseRequest; Res: THorseResponse);
var
  vendas: TVenda;
  erro: string;
  objVenda: TJSONObject;
  body: TJSONValue;
begin
  try
    vendas := TVenda.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    try
      body := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(req.Body), 0) as TJsonValue;

      vendas.NumeroVenda := body.GetValue<Integer>('numerovenda', 0);
      vendas.CodigoCliente := body.GetValue<Integer>('codigocliente', 0);
      vendas.DataHora := body.GetValue<string>('datahora', '');
      vendas.ValorTotal := body.GetValue<Currency>('valortotal', 0);
      vendas.Status := body.GetValue<string>('status', '');
      vendas.EditarVenda(erro);

      body.Free;

      if erro <> '' then
        raise Exception.Create(erro);

    except on e: exception do
      begin
        res.Send(e.Message).Status(400);
        exit;
      end;
    end;

    objVenda := TJSONObject.Create;
    objVenda.AddPair('NumeroVenda', vendas.NumeroVenda.ToString);

    res.Send<TJSONObject>(objVenda).Status(200);

  finally
    vendas.Free;
  end;
end;

procedure ExcluirVenda(Req: THorseRequest; Res: THorseResponse);
var
  vendas: TVenda;
  erro: string;
  objVenda: TJSONObject;
begin
  try
    vendas := TVenda.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    try
      vendas.NumeroVenda := Req.Params['NumeroVenda'].ToInteger;

      if not vendas.ExcluirVenda(erro) then
        raise Exception.Create(erro);

    except on e: exception do
      begin
        res.Send(e.Message).Status(400);
        exit;
      end;
    end;

    objVenda := TJSONObject.Create;
    objVenda.AddPair('NumeroVenda', vendas.NumeroVenda.ToString);

    res.Send<TJSONObject>(objVenda).Status(200);
  finally
    vendas.Free;
  end;
end;

end.

