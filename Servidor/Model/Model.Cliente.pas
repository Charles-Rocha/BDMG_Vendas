unit Model.Cliente;

interface

uses
  System.SysUtils, Data.DB, FireDAC.Comp.Client, Model.Connection;

type
  TCliente = class
    private
      FCodigo: Integer;
      FNome: string;
      FCPF: string;
      FStatus: string;
      FDataNascimento: TDateTime;

    public
      Constructor Create;
      Destructor Destroy; override;

      property Codigo: Integer read FCodigo write FCodigo;
      property Nome: string read FNome write FNome;
      property CPF: string read FCPF write FCPF;
      property Status: string read FStatus write FStatus;
      property DataNascimento: TDateTime read FDataNascimento write FDataNascimento;

      function ListarClientes(order_by: string; out erro: string): TFDQuery;
      function InserirCliente(out erro: string): boolean;
      function EditarCliente(out erro: string): boolean;
      function ExcluirCliente(out erro: string): boolean;
  end;

implementation

{ TCliente }

constructor TCliente.Create;
begin
  Model.Connection.Conecta;
end;

destructor TCliente.Destroy;
begin
  Model.Connection.Desconecta;
end;

function TCliente.ListarClientes(order_by: string; out erro: string): TFDQuery;
var
  qry: TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := Model.Connection.FConnection;

    with qry do
    begin
      Active := false;
      SQL.Clear;
      SQL.Add('SELECT Codigo, Nome, CPF, Status, Convert(varchar(10), DataNascimento, 103) ' +
              'AS DataNascimento FROM Clientes WHERE 1 = 1');

      if FCodigo > 0 then
      begin
        SQL.Add('AND Codigo = :Codigo');
        ParamByName('Codigo').Value := FCodigo;
      end;

      if order_by.IsEmpty then
        SQL.Add('ORDER BY Nome')
      else
        SQL.Add('ORDER BY ' + order_by);

      Active := true;
    end;

    erro := '';
    result := qry;
  except on e: exception do
    begin
      erro := 'Erro na consulta: ' + e.Message;
      result := nil;
    end;
  end;
end;

function TCliente.InserirCliente(out erro: string): boolean;
var
  qry: TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := Model.Connection.FConnection;

    with qry do
    begin
      Active := false;
      SQL.Clear;
      SQL.Add('INSERT INTO Clientes(Nome, CPF, Status, DataNascimento)');
      SQL.Add('VALUES(:Nome, :CPF, :Status, :DataNascimento)');

      ParamByName('Nome').Value := FNome;
      ParamByName('CPF').Value := FCPF;
      ParamByName('Status').Value := FStatus;
      ParamByName('DataNascimento').Value := FDataNascimento;
      ExecSQL;
    end;

    qry.Free;
    erro := '';
    result := true;
  except on e: exception do
    begin
      erro := 'Erro ao inserir cliente: ' + e.Message;
      result := false;
    end;
  end;
end;

function TCliente.EditarCliente(out erro: string): boolean;
var
  qry: TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := Model.Connection.FConnection;

    with qry do
    begin
      Active := false;
      SQL.Clear;
      SQL.Add('UPDATE Clientes SET Nome=:Nome, CPF=:CPF, Status=:Status, DataNascimento=:DataNascimento');
      SQL.Add('WHERE Codigo = :Codigo');

      ParamByName('Codigo').Value := FCodigo;
      ParamByName('Nome').Value := FNome;
      ParamByName('CPF').Value := FCPF;
      ParamByName('Status').Value := FStatus;
      ParamByName('DataNascimento').Value := FDataNascimento;
      ExecSQL;
    end;

    qry.Free;
    erro := '';
    result := true;
  except on e: exception do
    begin
      erro := 'Erro ao editar cliente: ' + e.Message;
      result := false;
    end;
  end;
end;

function TCliente.ExcluirCliente(out erro: string): boolean;
var
  qry: TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := Model.Connection.FConnection;

    with qry do
    begin
      Active := false;
      SQL.Clear;
      SQL.Add('DELETE FROM Clientes WHERE Codigo = :Codigo');
      ParamByName('Codigo').Value := FCodigo;
      ExecSQL;

      qry.Free;
      erro := '';
      result := true;
    end;
  except on e: exception do
    begin
      erro := 'Erro ao excluir cliente: ' + e.Message;
      result := false;
    end;
  end;
end;

end.
