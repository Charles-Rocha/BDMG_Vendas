unit Model.Produto;

interface

uses
  System.SysUtils, Data.DB, FireDAC.Comp.Client, Model.Connection;

type
  TProduto = class
    private
      FCodigo: Integer;
      FDescricao: string;
      FPrecoUnitario: Currency;
      FCodigoFornecedor: Integer;
      FStatus: string;

    public
      Constructor Create;
      Destructor Destroy; override;

      property Codigo: Integer read FCodigo write FCodigo;
      property Descricao: string read FDescricao write FDescricao;
      property PrecoUnitario: Currency read FPrecoUnitario write FPrecoUnitario;
      property CodigoFornecedor: Integer read FCodigoFornecedor write FCodigoFornecedor;
      property Status: string read FStatus write FStatus;

      function ListarProdutos(order_by: string; out erro: string): TFDQuery;
      function InserirProduto(out erro: string): boolean;
      function EditarProduto(out erro: string): boolean;
      function ExcluirProduto(out erro: string): boolean;
  end;


implementation

{ TCliente }

constructor TProduto.Create;
begin
  Model.Connection.Conecta;
end;

destructor TProduto.Destroy;
begin
  Model.Connection.Desconecta;
end;

function TProduto.ListarProdutos(order_by: string; out erro: string): TFDQuery;
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
      SQL.Add('SELECT P.Codigo, P.Descricao, P.PrecoUnitario, P.CodigoFornecedor, F.NomeFantasia, P.Status FROM Produtos P');
      SQL.Add('INNER JOIN Fornecedores F on F.Codigo = P.CodigoFornecedor');

      if FCodigo > 0 then
      begin
        SQL.Add('AND Codigo = :Codigo');
        ParamByName('Codigo').Value := FCodigo;
      end;

      if order_by.IsEmpty then
        SQL.Add('ORDER BY Descricao')
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

function TProduto.InserirProduto(out erro: string): boolean;
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
      SQL.Add('INSERT INTO Produtos(Descricao, PrecoUnitario, CodigoFornecedor, Status)');
      SQL.Add('VALUES(:Descricao, :PrecoUnitario, :CodigoFornecedor, :Status)');

      ParamByName('Descricao').Value := FDescricao;
      ParamByName('PrecoUnitario').Value := FPrecoUnitario;
      ParamByName('CodigoFornecedor').Value := FCodigoFornecedor;
      ParamByName('Status').Value := FStatus;
      ExecSQL;
    end;

    qry.Free;
    erro := '';
    result := true;
  except on e: exception do
    begin
      erro := 'Erro ao inserir produto: ' + e.Message;
      result := false;
    end;
  end;
end;

function TProduto.EditarProduto(out erro: string): boolean;
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
      SQL.Add('UPDATE Produtos SET Descricao=:Descricao, PrecoUnitario=:PrecoUnitario, CodigoFornecedor=:CodigoFornecedor,Status=:Status');
      SQL.Add('WHERE Codigo = :Codigo');

      ParamByName('Codigo').Value := FCodigo;
      ParamByName('Descricao').Value := FDescricao;
      ParamByName('PrecoUnitario').Value := FPrecoUnitario;
      ParamByName('CodigoFornecedor').Value := FCodigoFornecedor;
      ParamByName('Status').Value := FStatus;
      ExecSQL;
    end;

    qry.Free;
    erro := '';
    result := true;
  except on e: exception do
    begin
      erro := 'Erro ao editar produto: ' + e.Message;
      result := false;
    end;
  end;
end;

function TProduto.ExcluirProduto(out erro: string): boolean;
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
      SQL.Add('DELETE FROM Produtos WHERE Codigo = :Codigo');
      ParamByName('Codigo').Value := FCodigo;
      ExecSQL;

      qry.Free;
      erro := '';
      result := true;
    end;
  except on e: exception do
    begin
      erro := 'Erro ao excluir produto: ' + e.Message;
      result := false;
    end;
  end;
end;

end.

