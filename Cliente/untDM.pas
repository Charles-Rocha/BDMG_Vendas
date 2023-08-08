unit untDM;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, Data.DB, Datasnap.DBClient,
  REST.Response.Adapter;

type
  TDM = class(TDataModule)
    RESTClient1: TRESTClient;
    ReqClienteGet: TRESTRequest;
    RESTResponseCliente: TRESTResponse;
    RESTResponseDtsAdapCliente: TRESTResponseDataSetAdapter;
    cdsCliente: TClientDataSet;
    ReqClientePostPut: TRESTRequest;
    ReqClienteDelete: TRESTRequest;
    cdsClientecodigo: TWideStringField;
    cdsClientenome: TWideStringField;
    cdsClientecpf: TWideStringField;
    cdsClientestatus: TWideStringField;
    cdsClientedatanascimento: TWideStringField;
    ReqFornecedorGet: TRESTRequest;
    RESTResponseFornecedor: TRESTResponse;
    RESTResponseDtsAdapFornecedor: TRESTResponseDataSetAdapter;
    cdsFornecedor: TClientDataSet;
    cdsFornecedorcodigo: TWideStringField;
    cdsFornecedornomefantasia: TWideStringField;
    cdsFornecedorrazaosocial: TWideStringField;
    cdsFornecedorcnpj: TWideStringField;
    cdsFornecedorstatus: TWideStringField;
    ReqFornecedorPostPut: TRESTRequest;
    ReqFornecedorDelete: TRESTRequest;
    ReqProdutoGet: TRESTRequest;
    RESTResponseProduto: TRESTResponse;
    RESTResponseDtsAdapProduto: TRESTResponseDataSetAdapter;
    cdsProduto: TClientDataSet;
    ReqProdutoPostPut: TRESTRequest;
    ReqProdutoDelete: TRESTRequest;
    cdsProdutocodigo: TWideStringField;
    cdsProdutodescricao: TWideStringField;
    cdsProdutoprecounitario: TWideStringField;
    cdsProdutonomefantasia: TWideStringField;
    cdsProdutostatus: TWideStringField;
    cdsProdutocodigofornecedor: TWideStringField;
    ReqVendaGet: TRESTRequest;
    RESTResponseVenda: TRESTResponse;
    RESTResponseDtsAdapVenda: TRESTResponseDataSetAdapter;
    cdsVenda: TClientDataSet;
    ReqVendaPostPut: TRESTRequest;
    ReqVendaDelete: TRESTRequest;
    ReqProdutosVendidosGet: TRESTRequest;
    RESTResponseProdutosVendidos: TRESTResponse;
    RESTResponseDtsAdapProdutosVendidos: TRESTResponseDataSetAdapter;
    cdsProdutosVendidos: TClientDataSet;
    ReqProdutosVendidosPostPut: TRESTRequest;
    ReqProdutosVendidosDelete: TRESTRequest;
    cdsProdutosVendidoscodigo: TWideStringField;
    cdsProdutosVendidosdescricao: TWideStringField;
    cdsProdutosVendidosprecounitario: TWideStringField;
    cdsProdutosVendidosquantidadevendida: TWideStringField;
    cdsProdutosVendidosvalortotal: TWideStringField;
    cdsVendanumerovenda: TWideStringField;
    cdsVendacodigocliente: TWideStringField;
    cdsVendanome: TWideStringField;
    cdsVendadatahora: TWideStringField;
    cdsVendavalortotal: TWideStringField;
    cdsVendastatus: TWideStringField;
    procedure cdsFornecedorstatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure cdsProdutostatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure cdsProdutoprecounitarioGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure cdsClientestatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure cdsVendastatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure cdsVendavalortotalGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure cdsProdutosVendidosprecounitarioGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure cdsProdutosVendidosvalortotalGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.cdsClientestatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if not cdsCliente.IsEmpty then
  begin
    if cdsClientestatus.AsString <> '' then
    begin
      if cdsClientestatus.AsString = 'True' then
        Text := 'Ativo'
      else
        Text := 'Inativo';
    end;
  end;
end;

procedure TDM.cdsFornecedorstatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if not cdsFornecedor.IsEmpty then
  begin
    if cdsFornecedorstatus.AsString <> '' then
    begin
      if cdsFornecedorstatus.AsString = 'True' then
        Text := 'Ativo'
      else
        Text := 'Inativo';
    end;
  end;
end;

procedure TDM.cdsProdutoprecounitarioGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if not cdsProduto.IsEmpty then
  begin
    if cdsProdutoprecounitario.AsString <> '' then
      Text := FormatFloat('#,##0.00', cdsProdutoprecounitario.AsCurrency);
  end;
end;

procedure TDM.cdsProdutostatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if not cdsProduto.IsEmpty then
  begin
    if cdsProdutostatus.AsString <> '' then
    begin
      if cdsProdutostatus.AsString = 'True' then
        Text := 'Ativo'
      else
        Text := 'Inativo';
    end;
  end;
end;

procedure TDM.cdsProdutosVendidosprecounitarioGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if not cdsProdutosVendidos.IsEmpty then
  begin
    if cdsProdutosVendidosprecounitario.AsString <> '' then
      Text := FormatFloat('#,##0.00', cdsProdutosVendidosprecounitario.AsCurrency);
  end;
end;

procedure TDM.cdsProdutosVendidosvalortotalGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if not cdsProdutosVendidos.IsEmpty then
  begin
    if cdsProdutosVendidosvalortotal.AsString <> '' then
      Text := FormatFloat('#,##0.00', cdsProdutosVendidosvalortotal.AsCurrency);
  end;
end;

procedure TDM.cdsVendastatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if not cdsVenda.IsEmpty then
  begin
    if cdsVendastatus.AsString <> '' then
    begin
      if cdsVendastatus.AsString = 'True' then
        Text := 'Efetivada'
      else
        Text := 'Pendente';
    end;
  end;
end;

procedure TDM.cdsVendavalortotalGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if not cdsVenda.IsEmpty then
  begin
    if cdsVendavalortotal.AsString <> '' then
      Text := FormatFloat('#,##0.00', cdsVendavalortotal.AsCurrency);
  end;
end;

end.
