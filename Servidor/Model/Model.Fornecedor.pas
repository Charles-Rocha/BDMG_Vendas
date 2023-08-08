unit Model.Fornecedor;

interface

uses
  System.SysUtils, Data.DB, FireDAC.Comp.Client, Model.Connection;

type
  TFornecedor = class
    private
      FCodigo: Integer;
      FNomeFantasia: string;
      FRazaoSocial: string;
      FCNPJ: string;
      FStatus: string;

    public
      Constructor Create;
      Destructor Destroy; override;

      property Codigo: Integer read FCodigo write FCodigo;
      property NomeFantasia: string read FNomeFantasia write FNomeFantasia;
      property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
      property CNPJ: string read FCNPJ write FCNPJ;
      property Status: string read FStatus write FStatus;

      function ListarFornecedores(order_by: string; out erro: string): TFDQuery;
      function InserirFornecedor(out erro: string): boolean;
      function EditarFornecedor(out erro: string): boolean;
      function ExcluirFornecedor(out erro: string): boolean;
  end;

implementation

{ TCliente }

constructor TFornecedor.Create;
begin
  Model.Connection.Conecta;
end;

destructor TFornecedor.Destroy;
begin
  Model.Connection.Desconecta;
end;

function TFornecedor.ListarFornecedores(order_by: string; out erro: string): TFDQuery;
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
      SQL.Add('SELECT * FROM Fornecedores WHERE 1 = 1');

      if FCodigo > 0 then
      begin
        SQL.Add('AND Codigo = :Codigo');
        ParamByName('Codigo').Value := FCodigo;
      end;

      if order_by.IsEmpty then
        SQL.Add('ORDER BY NomeFantasia')
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

function TFornecedor.InserirFornecedor(out erro: string): boolean;
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
      SQL.Add('INSERT INTO Fornecedores(NomeFantasia, RazaoSocial, CNPJ, Status)');
      SQL.Add('VALUES(:NomeFantasia, :RazaoSocial, :CNPJ, :Status)');

      ParamByName('NomeFantasia').Value := FNomeFantasia;
      ParamByName('RazaoSocial').Value := FRazaoSocial;
      ParamByName('CNPJ').Value := FCNPJ;
      ParamByName('Status').Value := FStatus;
      ExecSQL;
    end;

    qry.Free;
    erro := '';
    result := true;
  except on e: exception do
    begin
      erro := 'Erro ao inserir fornecedor: ' + e.Message;
      result := false;
    end;
  end;
end;

function TFornecedor.EditarFornecedor(out erro: string): boolean;
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
      SQL.Add('UPDATE Fornecedores SET NomeFantasia=:NomeFantasia, RazaoSocial=:RazaoSocial, CNPJ=:CNPJ, Status=:Status');
      SQL.Add('WHERE Codigo = :Codigo');

      ParamByName('Codigo').Value := FCodigo;
      ParamByName('NomeFantasia').Value := FNomeFantasia;
      ParamByName('RazaoSocial').Value := FRazaoSocial;
      ParamByName('CNPJ').Value := FCNPJ;
      ParamByName('Status').Value := FStatus;
      ExecSQL;
    end;

    qry.Free;
    erro := '';
    result := true;
  except on e: exception do
    begin
      erro := 'Erro ao editar fornecedor: ' + e.Message;
      result := false;
    end;
  end;
end;

function TFornecedor.ExcluirFornecedor(out erro: string): boolean;
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
      SQL.Add('DELETE FROM Fornecedores WHERE Codigo = :Codigo');
      ParamByName('Codigo').Value := FCodigo;
      ExecSQL;

      qry.Free;
      erro := '';
      result := true;
    end;
  except on e: exception do
    begin
      erro := 'Erro ao excluir fornecedor: ' + e.Message;
      result := false;
    end;
  end;
end;

end.

