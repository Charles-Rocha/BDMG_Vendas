unit Model.Venda;

interface

uses
  System.SysUtils, Data.DB, FireDAC.Comp.Client, Model.Connection;

type
  TVenda = class
    private
      FNumeroVenda: Integer;
      FCodigoCliente: Integer;
      FDataHora: string;
      FValorTotal: Currency;
      FStatus: string;

    public
      Constructor Create;
      Destructor Destroy; override;

      property NumeroVenda: Integer read FNumeroVenda write FNumeroVenda;
      property CodigoCliente: Integer read FCodigoCliente write FCodigoCliente;
      property DataHora: string read FDataHora write FDataHora;
      property ValorTotal: Currency read FValorTotal write FValorTotal;
      property Status: string read FStatus write FStatus;

      function ListarVendas(order_by: string; out erro: string): TFDQuery;
      function InserirVenda(out erro: string): boolean;
      function EditarVenda(out erro: string): boolean;
      function ExcluirVenda(out erro: string): boolean;
  end;

implementation

{ TCliente }

constructor TVenda.Create;
begin
  Model.Connection.Conecta;
end;

destructor TVenda.Destroy;
begin
  Model.Connection.Desconecta;
end;

function TVenda.ListarVendas(order_by: string; out erro: string): TFDQuery;
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
      SQL.Add('SELECT V.NumeroVenda, CodigoCliente, C.Nome, FORMAT(V.DataHora , ''dd/MM/yyyy HH:mm:ss'') AS DataHora, ' +
              'V.ValorTotal, V.Status FROM Vendas V ' +
              'INNER JOIN Clientes C on C.Codigo = V.CodigoCliente');

      if FNumeroVenda > 0 then
      begin
        SQL.Add('AND NumeroVenda = :NumeroVenda');
        ParamByName('NumeroVenda').Value := FNumeroVenda;
      end;

      if order_by.IsEmpty then
        SQL.Add('ORDER BY NumeroVenda')
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

function TVenda.InserirVenda(out erro: string): boolean;
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
      SQL.Add('INSERT INTO Vendas(CodigoCliente, DataHora, ValorTotal, Status)');
      SQL.Add('VALUES(:CodigoCliente, :DataHora, :ValorTotal, :Status)');

      ParamByName('CodigoCliente').Value := FCodigoCliente;
      ParamByName('DataHora').Value := FDataHora;
      ParamByName('ValorTotal').Value := FValorTotal;
      ParamByName('Status').Value := FStatus;
      ExecSQL;
    end;

    qry.Free;
    erro := '';
    result := true;
  except on e: exception do
    begin
      erro := 'Erro ao inserir venda: ' + e.Message;
      result := false;
    end;
  end;
end;

function TVenda.EditarVenda(out erro: string): boolean;
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
      SQL.Add('UPDATE Vendas SET CodigoCliente=:CodigoCliente, DataHora=:DataHora, ' +
              'ValorTotal=:ValorTotal, Status=:Status');
      SQL.Add('WHERE NumeroVenda = :NumeroVenda');

      ParamByName('NumeroVenda').Value := FNumeroVenda;
      ParamByName('CodigoCliente').Value := FCodigoCliente;
      ParamByName('DataHora').Value := FDataHora;
      ParamByName('ValorTotal').Value := FValorTotal;
      ParamByName('Status').Value := FStatus;
      ExecSQL;
    end;

    qry.Free;
    erro := '';
    result := true;
  except on e: exception do
    begin
      erro := 'Erro ao editar venda: ' + e.Message;
      result := false;
    end;
  end;
end;

function TVenda.ExcluirVenda(out erro: string): boolean;
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
      SQL.Add('DELETE FROM Vendas WHERE NumeroVenda = :NumeroVenda');
      ParamByName('NumeroVenda').Value := FNumeroVenda;
      ExecSQL;

      qry.Free;
      erro := '';
      result := true;
    end;
  except on e: exception do
    begin
      erro := 'Erro ao excluir venda: ' + e.Message;
      result := false;
    end;
  end;
end;

end.

