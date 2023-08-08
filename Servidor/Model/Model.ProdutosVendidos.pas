unit Model.ProdutosVendidos;

interface

uses
  System.SysUtils, Data.DB, FireDAC.Comp.Client, Model.Connection;

type
  TProdutosVendidos = class
    private
      FCodigo: Integer;
      FDescricao: string;
      FPrecoUnitario: double;
      FQuantidadeVendida: integer;
      FValorTotal: double;
      FCodigoCliente: Integer;
      FCodigoProduto: Integer;

    public
      Constructor Create;
      Destructor Destroy; override;

      property Codigo: Integer read FCodigo write FCodigo;
      property Descricao: string read FDescricao write FDescricao;
      property PrecoUnitario: double read FPrecoUnitario write FPrecoUnitario;
      property QuantidadeVendida: integer read FQuantidadeVendida write FQuantidadeVendida;
      property ValorTotal: double read FValorTotal write FValorTotal;
      property CodigoCliente: Integer read FCodigoCliente write FCodigoCliente;
      property CodigoProduto: Integer read FCodigoProduto write FCodigoProduto;

      function ListarProdutosVendidos(order_by: string; out erro: string): TFDQuery;
      function InserirProdutosVendidos(out erro: string): boolean;
      function EditarProdutosVendidos(out erro: string): boolean;
      function ExcluirProdutosVendidos(out erro: string): boolean;
  end;

implementation

{ TCliente }

constructor TProdutosVendidos.Create;
begin
  Model.Connection.Conecta;
end;

destructor TProdutosVendidos.Destroy;
begin
  Model.Connection.Desconecta;
end;

function TProdutosVendidos.ListarProdutosVendidos(order_by: string; out erro: string): TFDQuery;
var
  qry: TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := Model.Connection.FConnection;

    with qry do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM ProdutosVendidos WHERE 1 = 1');

      if FCodigoCliente > 0 then
      begin
        SQL.Add('AND CodigoCliente = :CodigoCliente');
        ParamByName('CodigoCliente').Value := FCodigoCliente;
      end;

      if order_by.IsEmpty then
        SQL.Add('ORDER BY Descricao')
      else
        SQL.Add('ORDER BY ' + order_by);

      Open;
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

function TProdutosVendidos.InserirProdutosVendidos(out erro: string): boolean;
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
      SQL.Add('INSERT INTO ProdutosVendidos(Descricao, PrecoUnitario, QuantidadeVendida, ValorTotal, CodigoCliente, CodigoProduto)');
      SQL.Add('VALUES(:Descricao, :PrecoUnitario, :QuantidadeVendida, :ValorTotal, :CodigoCliente, :CodigoProduto)');

      ParamByName('Descricao').Value := FDescricao;
      ParamByName('PrecoUnitario').Value := FPrecoUnitario;
      ParamByName('QuantidadeVendida').Value := FQuantidadeVendida;
      ParamByName('ValorTotal').Value := FValorTotal;
      ParamByName('CodigoCliente').Value := FCodigoCliente;
      ParamByName('CodigoProduto').Value := FCodigoProduto;
      ExecSQL;

      //Recuepro o Codigo inserido...
      Params.Clear;
      SQL.Clear;
      SQL.Add('SELECT MAX(Codigo) AS Codigo FROM ProdutosVendidos');
      Active := true;

      FCodigo := FieldByName('Codigo').AsInteger;
    end;

    qry.Free;
    erro := '';
    result := true;
  except on e: exception do
    begin
      erro := 'Erro ao inserir produto vendido: ' + e.Message;
      result := false;
    end;
  end;
end;

function TProdutosVendidos.EditarProdutosVendidos(out erro: string): boolean;
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
      SQL.Add('UPDATE ProdutosVendidos SET Descricao=:Descricao, PrecoUnitario=:PrecoUnitario, ' +
              'QuantidadeVendida=:QuantidadeVendida, ValorTotal=:ValorTotal, CodigoCliente=:CodigoCliente, CodigoProduto=:CodigoProduto');
      SQL.Add('WHERE Codigo = :Codigo');

      ParamByName('Codigo').Value := FCodigo;
      ParamByName('Descricao').Value := FDescricao;
      ParamByName('PrecoUnitario').Value := FPrecoUnitario;
      ParamByName('QuantidadeVendida').Value := FQuantidadeVendida;
      ParamByName('ValorTotal').Value := FValorTotal;
      ParamByName('CodigoCliente').Value := FCodigoCliente;
      ParamByName('CodigoProduto').Value := FCodigoProduto;
      ExecSQL;
    end;

    qry.Free;
    erro := '';
    result := true;
  except on e: exception do
    begin
      erro := 'Erro ao editar produto vendido: ' + e.Message;
      result := false;
    end;
  end;
end;

function TProdutosVendidos.ExcluirProdutosVendidos(out erro: string): boolean;
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
      SQL.Add('DELETE FROM ProdutosVendidos WHERE CodigoCliente = :CodigoCliente');
      ParamByName('CodigoCliente').Value := FCodigoCliente;
      ExecSQL;

      qry.Free;
      erro := '';
      result := true;
    end;
  except on e: exception do
    begin
      erro := 'Erro ao excluir produto vendido: ' + e.Message;
      result := false;
    end;
  end;
end;

end.
