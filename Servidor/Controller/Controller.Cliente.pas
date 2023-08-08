unit Controller.Cliente;

interface

uses Horse, System.JSON, System.SysUtils, Model.Cliente, Model.Fornecedor, FireDAC.Comp.Client, Data.DB, DataSet.Serialize,
     Controller.Fornecedor;

procedure ListarClientes(Req: THorseRequest; Res: THorseResponse);
procedure ListarClienteId(Req: THorseRequest; Res: THorseResponse);
procedure InserirCliente(Req: THorseRequest; Res: THorseResponse);
procedure EditarCliente(Req: THorseRequest; Res: THorseResponse);
procedure ExcluirCliente(Req: THorseRequest; Res: THorseResponse);

implementation

procedure ListarClientes(Req: THorseRequest; Res: THorseResponse);
var
  clientes: TCliente;
  qry: TFDQuery;
  sErro: string;
  arrayClientes: TJSONArray;
begin
  try
    clientes := TCliente.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    qry := clientes.ListarClientes('', sErro);
    arrayClientes := qry.ToJSONArray();
    res.Send<TJSONArray>(arrayClientes);
  finally
    clientes.Free;
  end;
end;

procedure ListarClienteId(Req: THorseRequest; Res: THorseResponse);
var
  clientes: TCliente;
  qry: TFDQuery;
  sErro: string;
  objClientes: TJSONObject;
begin
  try
    clientes := TCliente.Create;
    clientes.Codigo := Req.Params['Codigo'].ToInteger;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    qry := clientes.ListarClientes('', sErro);

    if qry.RecordCount > 0 then
    begin
      objClientes := qry.ToJSONObject();
      res.Send<TJSONObject>(objClientes);
    end
    else
    begin
      res.Send('Cliente não encontrado').Status(404);
    end;

  finally
    clientes.Free;
  end;
end;

procedure InserirCliente(Req: THorseRequest; Res: THorseResponse);
var
  clientes: TCliente;
  erro: string;
  objCliente: TJSONObject;
  body: TJSONValue;
begin
  try
    clientes := TCliente.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    try
      body := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(req.Body), 0) as TJsonValue;

      clientes.Nome := UTF8Decode(body.GetValue<string>('nome', ''));
      clientes.CPF := body.GetValue<string>('cpf', '');
      clientes.Status := body.GetValue<string>('status', '');
      clientes.DataNascimento := body.GetValue<TDateTime>('datanascimento', 0);
      clientes.InserirCliente(erro);

      body.Free;

      if erro <> '' then
        raise Exception.Create(erro);

    except on e: exception do
      begin
        res.Send(e.Message).Status(400);
        exit;
      end;
    end;

    objCliente := TJSONObject.Create;
    objCliente.AddPair('Codigo', clientes.Codigo.ToString);

    res.Send<TJSONObject>(objCliente).Status(201);

  finally
    clientes.Free;
  end;
end;

procedure EditarCliente(Req: THorseRequest; Res: THorseResponse);
var
  clientes: TCliente;
  erro: string;
  objCliente: TJSONObject;
  body: TJSONValue;
begin
  try
    clientes := TCliente.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    try
      body := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(req.Body), 0) as TJsonValue;

      clientes.Codigo := body.GetValue<integer>('codigo', 0);
      clientes.Nome := UTF8Decode(body.GetValue<string>('nome', ''));
      clientes.CPF := body.GetValue<string>('cpf', '');
      clientes.Status := body.GetValue<string>('status', '');
      clientes.DataNascimento := body.GetValue<TDateTime>('datanascimento', 0);
      clientes.EditarCliente(erro);

      body.Free;

      if erro <> '' then
        raise Exception.Create(erro);

    except on e: exception do
      begin
        res.Send(e.Message).Status(400);
        exit;
      end;
    end;

    objCliente := TJSONObject.Create;
    objCliente.AddPair('Codigo', clientes.Codigo.ToString);

    res.Send<TJSONObject>(objCliente).Status(200);

  finally
    clientes.Free;
  end;
end;

procedure ExcluirCliente(Req: THorseRequest; Res: THorseResponse);
var
  clientes: TCliente;
  erro: string;
  objCliente: TJSONObject;
begin
  try
    clientes := TCliente.Create;
  except on e: exception do
    begin
     res.Send('Erro ao conectar com o banco de dados:' + e.Message).Status(500);
     exit;
    end;
  end;

  try
    try
      clientes.Codigo := Req.Params['Codigo'].ToInteger;

      if not clientes.ExcluirCliente(erro) then
        raise Exception.Create(erro);

    except on e: exception do
      begin
        res.Send(e.Message).Status(400);
        exit;
      end;
    end;

    objCliente := TJSONObject.Create;
    objCliente.AddPair('Codigo', clientes.Codigo.ToString);

    res.Send<TJSONObject>(objCliente).Status(200);
  finally
    clientes.Free;
  end;
end;

end.
