object dm: Tdm
  OldCreateOrder = False
  Height = 471
  Width = 793
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    BaseURL = 'http://localhost:9000'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 32
    Top = 16
  end
  object ReqClienteGet: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Kind = pkREQUESTBODY
        name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'cliente'
    Response = RESTResponseCliente
    SynchronizedEvents = False
    Left = 32
    Top = 104
  end
  object RESTResponseCliente: TRESTResponse
    ContentType = 'application/json'
    Left = 128
    Top = 104
  end
  object RESTResponseDtsAdapCliente: TRESTResponseDataSetAdapter
    Active = True
    Dataset = cdsCliente
    FieldDefs = <>
    Response = RESTResponseCliente
    Left = 72
    Top = 152
  end
  object cdsCliente: TClientDataSet
    PersistDataPacket.Data = {
      320100009619E0BD010000001800000005000100000003000000C30006636F64
      69676F02004A000000010005574944544802000200FE01046E6F6D6502004A00
      0000010005574944544802000200FE010363706602004A000000010005574944
      544802000200FE010673746174757302004A0000000100055749445448020002
      00FE010E646174616E617363696D656E746F02004A0000000100055749445448
      02000200FE0101000A4348414E47455F4C4F4704008200030000000100000000
      000000040000000400000400330031002C0043006800610072006C0065007300
      2000640061002000530069006C0076006100200052006F006300680061001600
      3000370032003300390034003100350037003200340008005400720075006500
      1400310032002F00300037002F003100390037003600}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'codigo'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'nome'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'cpf'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'status'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'datanascimento'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 184
    Top = 152
    object cdsClientecodigo: TWideStringField
      FieldName = 'codigo'
      Size = 255
    end
    object cdsClientenome: TWideStringField
      FieldName = 'nome'
      Size = 255
    end
    object cdsClientecpf: TWideStringField
      FieldName = 'cpf'
      EditMask = '!999.999.999-99;0; '
      Size = 255
    end
    object cdsClientestatus: TWideStringField
      FieldName = 'status'
      OnGetText = cdsClientestatusGetText
      Size = 255
    end
    object cdsClientedatanascimento: TWideStringField
      FieldName = 'datanascimento'
      Size = 255
    end
  end
  object ReqClientePostPut: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <
      item
        Kind = pkREQUESTBODY
        name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'cliente'
    Response = RESTResponseCliente
    SynchronizedEvents = False
    Left = 40
    Top = 200
  end
  object ReqClienteDelete: TRESTRequest
    Client = RESTClient1
    Method = rmDELETE
    Params = <
      item
        Kind = pkREQUESTBODY
        name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'cliente'
    Response = RESTResponseCliente
    SynchronizedEvents = False
    Left = 136
    Top = 200
  end
  object ReqFornecedorGet: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Kind = pkREQUESTBODY
        name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'fornecedor'
    Response = RESTResponseFornecedor
    SynchronizedEvents = False
    Left = 296
    Top = 104
  end
  object RESTResponseFornecedor: TRESTResponse
    ContentType = 'application/json'
    Left = 416
    Top = 104
  end
  object RESTResponseDtsAdapFornecedor: TRESTResponseDataSetAdapter
    Active = True
    Dataset = cdsFornecedor
    FieldDefs = <>
    Response = RESTResponseFornecedor
    Left = 336
    Top = 152
  end
  object cdsFornecedor: TClientDataSet
    PersistDataPacket.Data = {
      350400009619E0BD010000001800000005000600000003000000050106636F64
      69676F02004A000000010005574944544802000200FE010C6E6F6D6566616E74
      6173696102004A000000010005574944544802000200FE010B72617A616F736F
      6369616C02004A000000010005574944544802000200FE0104636E706A02004A
      000000010005574944544802000200FE010673746174757302004A0000000100
      05574944544802000200FE0101000A4348414E47455F4C4F4704008200120000
      0001000000000000000400000002000000000000000400000003000000000000
      0004000000040000000000000004000000050000000000000004000000060000
      0000000000040000000400000400310034002800460061007300200053006800
      6F007000200049006E0066006F0072006D00E100740069006300610032004600
      610073002000530068006F007000200049006E0066006F0072006D00E1007400
      69006300610020004C005400440041001C003000320034003900310035003300
      360030003000300031003800320008005400720075006500040000020038002C
      004B006100620075006D00200045006C00650074007200F4006E00690063006F
      007300200053002E0041002E0032004B006100620075006D00200043006F006D
      00E9007200630069006F00200045006C00650074007200F4006E00690063006F
      001C003000350035003700300037003100340030003000300031003500390008
      005400720075006500040000020039001A004D00650072006300610064006F00
      20004C00690076007200650024004D00650072006300610064006F0020004C00
      690076007200650020004C005400440041001C00350034003900380037003200
      340031003000300030003100300033000A00460061006C007300650004000004
      003100300030004D00650072006300610064006F0020004C0069007600720065
      00200045006C00650074007200F4006E00690063006F0024004D006500720063
      00610064006F0020004C00690076007200650020004C005400440041001C0036
      0032003400380033003400380033003000300030003100380030000800540072
      0075006500040000040031003100240050006900630068006100750020004900
      6E0066006F0072006D00E10074006900630061002E0050006900630068006100
      7500200049006E0066006F0072006D00E100740069006300610020004C005400
      440041001C003000390033003700360034003900350030003000300031003200
      32000800540072007500650004000004003100350026005A0069006E007A0061
      0072006100200049006E0066006F0072006D00E100740069006300610030005A
      0069006E007A00610072006100200049006E0066006F0072006D00E100740069
      006300610020004C005400440041001C00380031003400300038003300330032
      003000300030003100300031000A00460061006C0073006500}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'codigo'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'nomefantasia'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'razaosocial'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'cnpj'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'status'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 464
    Top = 152
    object cdsFornecedorcodigo: TWideStringField
      FieldName = 'codigo'
      Size = 255
    end
    object cdsFornecedornomefantasia: TWideStringField
      FieldName = 'nomefantasia'
      Size = 255
    end
    object cdsFornecedorrazaosocial: TWideStringField
      FieldName = 'razaosocial'
      Size = 255
    end
    object cdsFornecedorcnpj: TWideStringField
      FieldName = 'cnpj'
      EditMask = '99.999.999/9999-99;0 '
      Size = 255
    end
    object cdsFornecedorstatus: TWideStringField
      FieldName = 'status'
      OnGetText = cdsFornecedorstatusGetText
      Size = 255
    end
  end
  object ReqFornecedorPostPut: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <
      item
        Kind = pkREQUESTBODY
        name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'fornecedor'
    Response = RESTResponseFornecedor
    SynchronizedEvents = False
    Left = 296
    Top = 208
  end
  object ReqFornecedorDelete: TRESTRequest
    Client = RESTClient1
    Method = rmDELETE
    Params = <
      item
        Kind = pkREQUESTBODY
        name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'fornecedor'
    Response = RESTResponseFornecedor
    SynchronizedEvents = False
    Left = 416
    Top = 208
  end
  object ReqProdutoGet: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Kind = pkREQUESTBODY
        name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'produto'
    Response = RESTResponseProduto
    SynchronizedEvents = False
    Left = 600
    Top = 104
  end
  object RESTResponseProduto: TRESTResponse
    ContentType = 'application/json'
    Left = 704
    Top = 104
  end
  object RESTResponseDtsAdapProduto: TRESTResponseDataSetAdapter
    Active = True
    Dataset = cdsProduto
    FieldDefs = <>
    Response = RESTResponseProduto
    Left = 600
    Top = 152
  end
  object cdsProduto: TClientDataSet
    PersistDataPacket.Data = {
      150200009619E0BD010000001800000006000200000003000000010106636F64
      69676F02004A000000010005574944544802000200FE01096465736372696361
      6F02004A000000010005574944544802000200FE010D707265636F756E697461
      72696F02004A000000010005574944544802000200FE0110636F6469676F666F
      726E656365646F7202004A000000010005574944544802000200FE010C6E6F6D
      6566616E746173696102004A000000010005574944544802000200FE01067374
      6174757302004A000000010005574944544802000200FE0101000A4348414E47
      455F4C4F47040082000600000001000000000000000400000002000000000000
      00040000000400000400310036003E0041006400610070007400610064006F00
      7200200044005600490020004D006100630068006F0020007800200056004700
      410020004600EA006D00650061000800350035002C003900020038002C004B00
      6100620075006D00200045006C00650074007200F4006E00690063006F007300
      200053002E0041002E0008005400720075006500040000040031003700300043
      006100640065006900720061002000470061006D006500720020005400680075
      006E006400650072002000580033000C003800390039002C0039003900020038
      002C004B006100620075006D00200045006C00650074007200F4006E00690063
      006F007300200053002E0041002E0008005400720075006500}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'codigo'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'descricao'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'precounitario'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'codigofornecedor'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'nomefantasia'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'status'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 712
    Top = 152
    object cdsProdutocodigo: TWideStringField
      FieldName = 'codigo'
      Size = 255
    end
    object cdsProdutodescricao: TWideStringField
      FieldName = 'descricao'
      Size = 255
    end
    object cdsProdutoprecounitario: TWideStringField
      FieldName = 'precounitario'
      OnGetText = cdsProdutoprecounitarioGetText
      Size = 255
    end
    object cdsProdutocodigofornecedor: TWideStringField
      FieldName = 'codigofornecedor'
      Size = 255
    end
    object cdsProdutonomefantasia: TWideStringField
      FieldName = 'nomefantasia'
      Size = 255
    end
    object cdsProdutostatus: TWideStringField
      FieldName = 'status'
      OnGetText = cdsProdutostatusGetText
      Size = 255
    end
  end
  object ReqProdutoPostPut: TRESTRequest
    AcceptEncoding = 'UTF-8'
    Client = RESTClient1
    Method = rmPOST
    Params = <
      item
        Kind = pkREQUESTBODY
        name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'produto'
    Response = RESTResponseProduto
    SynchronizedEvents = False
    Left = 600
    Top = 208
  end
  object ReqProdutoDelete: TRESTRequest
    Client = RESTClient1
    Method = rmDELETE
    Params = <
      item
        Kind = pkREQUESTBODY
        name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'produto'
    Response = RESTResponseProduto
    SynchronizedEvents = False
    Left = 704
    Top = 208
  end
  object ReqVendaGet: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Kind = pkREQUESTBODY
        name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'venda'
    Response = RESTResponseVenda
    SynchronizedEvents = False
    Left = 48
    Top = 272
  end
  object RESTResponseVenda: TRESTResponse
    ContentType = 'application/json'
    Left = 144
    Top = 272
  end
  object RESTResponseDtsAdapVenda: TRESTResponseDataSetAdapter
    Active = True
    Dataset = cdsVenda
    FieldDefs = <>
    Response = RESTResponseVenda
    Left = 64
    Top = 336
  end
  object cdsVenda: TClientDataSet
    PersistDataPacket.Data = {
      680100009619E0BD010000001800000006000100000003000000EB000B6E756D
      65726F76656E646102004A000000010005574944544802000200FE010D636F64
      69676F636C69656E746502004A000000010005574944544802000200FE01046E
      6F6D6502004A000000010005574944544802000200FE010864617461686F7261
      02004A000000010005574944544802000200FE010A76616C6F72746F74616C02
      004A000000010005574944544802000200FE010673746174757302004A000000
      010005574944544802000200FE0101000A4348414E47455F4C4F470400820003
      000000010000000000000004000000040000020033000400330031002C004300
      6800610072006C00650073002000640061002000530069006C00760061002000
      52006F006300680061002600300038002F00300038002F003200300032003300
      2000300031003A00310039003A00330031000C003800390039002C0039003900
      0A00460061006C0073006500}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'numerovenda'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'codigocliente'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'nome'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'datahora'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'valortotal'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'status'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 168
    Top = 336
    object cdsVendanumerovenda: TWideStringField
      FieldName = 'numerovenda'
      Size = 255
    end
    object cdsVendacodigocliente: TWideStringField
      FieldName = 'codigocliente'
      Size = 255
    end
    object cdsVendanome: TWideStringField
      FieldName = 'nome'
      Size = 255
    end
    object cdsVendadatahora: TWideStringField
      FieldName = 'datahora'
      Size = 255
    end
    object cdsVendavalortotal: TWideStringField
      FieldName = 'valortotal'
      OnGetText = cdsVendavalortotalGetText
      Size = 255
    end
    object cdsVendastatus: TWideStringField
      FieldName = 'status'
      OnGetText = cdsVendastatusGetText
      Size = 255
    end
  end
  object ReqVendaPostPut: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <
      item
        Kind = pkREQUESTBODY
        name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'venda'
    Response = RESTResponseVenda
    SynchronizedEvents = False
    Left = 48
    Top = 400
  end
  object ReqVendaDelete: TRESTRequest
    Client = RESTClient1
    Method = rmDELETE
    Params = <
      item
        Kind = pkREQUESTBODY
        name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'venda'
    Response = RESTResponseVenda
    SynchronizedEvents = False
    Left = 144
    Top = 400
  end
  object ReqProdutosVendidosGet: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Kind = pkREQUESTBODY
        name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'produtosvendidos'
    Response = RESTResponseProdutosVendidos
    SynchronizedEvents = False
    Left = 304
    Top = 272
  end
  object RESTResponseProdutosVendidos: TRESTResponse
    ContentType = 'application/json'
    Left = 456
    Top = 272
  end
  object RESTResponseDtsAdapProdutosVendidos: TRESTResponseDataSetAdapter
    Active = True
    Dataset = cdsProdutosVendidos
    FieldDefs = <>
    Response = RESTResponseProdutosVendidos
    Left = 304
    Top = 336
  end
  object cdsProdutosVendidos: TClientDataSet
    PersistDataPacket.Data = {
      780100009619E0BD0100000018000000070001000000030000001D0106636F64
      69676F02004A000000010005574944544802000200FE01096465736372696361
      6F02004A000000010005574944544802000200FE010D707265636F756E697461
      72696F02004A000000010005574944544802000200FE01117175616E74696461
      646576656E6469646102004A000000010005574944544802000200FE010A7661
      6C6F72746F74616C02004A000000010005574944544802000200FE010D636F64
      69676F636C69656E746502004A000000010005574944544802000200FE010D63
      6F6469676F70726F6475746F02004A000000010005574944544802000200FE01
      01000A4348414E47455F4C4F4704008200030000000100000000000000040000
      0004002804003700320030004300610064006500690072006100200047006100
      6D006500720020005400680075006E006400650072002000580033000C003800
      390039002C0039003900020031000C003800390039002C0039003900}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'codigo'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'descricao'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'precounitario'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'quantidadevendida'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'valortotal'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'codigocliente'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'codigoproduto'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 472
    Top = 336
    object cdsProdutosVendidoscodigo: TWideStringField
      FieldName = 'codigo'
      Size = 255
    end
    object cdsProdutosVendidosdescricao: TWideStringField
      FieldName = 'descricao'
      Size = 255
    end
    object cdsProdutosVendidosprecounitario: TWideStringField
      FieldName = 'precounitario'
      OnGetText = cdsProdutosVendidosprecounitarioGetText
      Size = 255
    end
    object cdsProdutosVendidosquantidadevendida: TWideStringField
      FieldName = 'quantidadevendida'
      Size = 255
    end
    object cdsProdutosVendidosvalortotal: TWideStringField
      FieldName = 'valortotal'
      OnGetText = cdsProdutosVendidosvalortotalGetText
      Size = 255
    end
  end
  object ReqProdutosVendidosPostPut: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <
      item
        Kind = pkREQUESTBODY
        name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'produtosvendidos'
    Response = RESTResponseProdutosVendidos
    SynchronizedEvents = False
    Left = 304
    Top = 400
  end
  object ReqProdutosVendidosDelete: TRESTRequest
    Client = RESTClient1
    Method = rmDELETE
    Params = <
      item
        Kind = pkREQUESTBODY
        name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'produtosvendidos'
    Response = RESTResponseProdutosVendidos
    SynchronizedEvents = False
    Left = 456
    Top = 400
  end
end
