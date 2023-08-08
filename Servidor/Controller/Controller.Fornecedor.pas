unit Controller.Fornecedor;

interface

uses Horse, System.JSON, System.SysUtils, Model.Fornecedor, FireDAC.Comp.Client, Data.DB, DataSet.Serialize;

procedure ListarFornecedores(Req: THorseRequest; Res: THorseResponse);
procedure ListarFornecedorId(Req: THorseRequest; Res: THorseResponse);
procedure InserirFornecedor(Req: THorseRequest; Res: THorseResponse);
procedure EditarFornecedor(Req: THorseRequest; Res: THorseResponse);
procedure ExcluirFornecedor(Req: THorseRequest; Res: THorseResponse);

implementation

procedure ListarFornecedores(Req: THorseRequest; Res: THorseResponse);
var
  fornecedores: TFornecedor;
  qry: TFDQuery;
  sErro: string;
  arrayFornecedores: TJSONArray;
begin
  try
    fornecedores := TFornecedor.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    qry := fornecedores.ListarFornecedores('', sErro);
    arrayFornecedores := qry.ToJSONArray();
    res.Send<TJSONArray>(arrayFornecedores);
  finally
    fornecedores.Free;
  end;
end;

procedure ListarFornecedorId(Req: THorseRequest; Res: THorseResponse);
var
  fornecedores: TFornecedor;
  qry: TFDQuery;
  sErro: string;
  objFornecedor: TJSONObject;
begin
  try
    fornecedores := TFornecedor.Create;
    fornecedores.Codigo := Req.Params['Codigo'].ToInteger;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    qry := fornecedores.ListarFornecedores('', sErro);

    if qry.RecordCount > 0 then
    begin
      objFornecedor := qry.ToJSONObject();
      res.Send<TJSONObject>(objFornecedor);
    end
    else
    begin
      res.Send('Fornecedor não encontrado').Status(404);
    end;

  finally
    fornecedores.Free;
  end;
end;

procedure InserirFornecedor(Req: THorseRequest; Res: THorseResponse);
var
  fornecedores: TFornecedor;
  erro: string;
  objFornecedor: TJSONObject;
  body: TJSONValue;
begin
  try
    fornecedores := TFornecedor.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    try
      body := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(req.Body), 0) as TJsonValue;

      fornecedores.NomeFantasia := UTF8Decode(body.GetValue<string>('nomefantasia', ''));
      fornecedores.RazaoSocial := UTF8Decode(body.GetValue<string>('razaosocial', ''));
      fornecedores.CNPJ := body.GetValue<string>('cnpj', '');
      fornecedores.Status := body.GetValue<string>('status', '');
      fornecedores.InserirFornecedor(erro);

      body.Free;

      if erro <> '' then
        raise Exception.Create(erro);

    except on e: exception do
      begin
        res.Send(e.Message).Status(400);
        exit;
      end;
    end;

    objFornecedor := TJSONObject.Create;
    objFornecedor.AddPair('Codigo', fornecedores.Codigo.ToString);

    res.Send<TJSONObject>(objFornecedor).Status(201);

  finally
    fornecedores.Free;
  end;
end;

procedure EditarFornecedor(Req: THorseRequest; Res: THorseResponse);
var
  fornecedores: TFornecedor;
  erro: string;
  objFornecedor: TJSONObject;
  body: TJSONValue;
begin
  try
    fornecedores := TFornecedor.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    try
      body := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(req.Body), 0) as TJsonValue;

      fornecedores.Codigo := body.GetValue<integer>('codigo', 0);
      fornecedores.NomeFantasia := UTF8Decode(body.GetValue<string>('nomefantasia', ''));
      fornecedores.RazaoSocial := UTF8Decode(body.GetValue<string>('razaosocial', ''));
      fornecedores.CNPJ := body.GetValue<string>('cnpj', '');
      fornecedores.Status := body.GetValue<string>('status', '');
      fornecedores.EditarFornecedor(erro);

      body.Free;

      if erro <> '' then
        raise Exception.Create(erro);

    except on e: exception do
      begin
        res.Send(e.Message).Status(400);
        exit;
      end;
    end;

    objFornecedor := TJSONObject.Create;
    objFornecedor.AddPair('Codigo', fornecedores.Codigo.ToString);

    res.Send<TJSONObject>(objFornecedor).Status(200);

  finally
    fornecedores.Free;
  end;
end;

procedure ExcluirFornecedor(Req: THorseRequest; Res: THorseResponse);
var
  fornecedores: TFornecedor;
  erro: string;
  objFornecedor: TJSONObject;
begin
  try
    fornecedores := TFornecedor.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    try
      fornecedores.Codigo := Req.Params['Codigo'].ToInteger;

      if not fornecedores.ExcluirFornecedor(erro) then
        raise Exception.Create(erro);

    except on e: exception do
      begin
        res.Send(e.Message).Status(400);
        exit;
      end;
    end;

    objFornecedor := TJSONObject.Create;
    objFornecedor.AddPair('Codigo', fornecedores.Codigo.ToString);

    res.Send<TJSONObject>(objFornecedor).Status(200);
  finally
    fornecedores.Free;
  end;
end;

end.

