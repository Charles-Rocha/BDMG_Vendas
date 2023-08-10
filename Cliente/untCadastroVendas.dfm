inherited frmCadastroVendas: TfrmCadastroVendas
  Caption = 'Cadastro de vendas'
  ClientHeight = 523
  ExplicitWidth = 644
  ExplicitHeight = 562
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    inherited btnInserir: TBitBtn
      Hint = 'Adiciona uma nova venda'
      ParentShowHint = False
      ShowHint = True
    end
    inherited btnEditar: TBitBtn
      Hint = 'Edita uma venda existente'
      ParentShowHint = False
      ShowHint = True
    end
    inherited btnApagar: TBitBtn
      Hint = 'Apaga uma venda existente'
      ParentShowHint = False
      ShowHint = True
    end
    inherited btnCancelar: TBitBtn
      Hint = 'Cancela uma opera'#231#227'o'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
    end
    inherited btnGravar: TBitBtn
      Hint = 'Grava uma opera'#231#227'o'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
    end
    inherited btnPesquisar: TBitBtn
      Hint = 'Pesquisa vendas existentes'
      ShowHint = True
      TabOrder = 3
      OnClick = btnPesquisarClick
    end
    inherited btnAtualizar: TBitBtn
      Hint = 'Atualizar lista de vendas'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btnAtualizarClick
    end
  end
  inherited pnlDBGrid: TPanel
    Top = 162
    Height = 180
    Align = alTop
    ExplicitTop = 162
    ExplicitHeight = 180
    inherited dbgBaseCadastro: TDBGrid
      Height = 157
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      OnCellClick = dbgBaseCadastroCellClick
      Columns = <
        item
          Expanded = False
          FieldName = 'numerovenda'
          Title.Caption = 'N'#186' Venda'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Title.Caption = 'Nome'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 252
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'datahora'
          Title.Alignment = taCenter
          Title.Caption = 'Data Hora'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 110
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'status'
          Title.Alignment = taCenter
          Title.Caption = 'Status'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 58
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'valortotal'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor total venda'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 110
          Visible = True
        end>
    end
    object stbVendas: TStatusBar
      Left = 2
      Top = 159
      Width = 624
      Height = 19
      Panels = <
        item
          Text = 'Total de registros:'
          Width = 50
        end>
    end
  end
  inherited StatusBar1: TStatusBar
    Top = 504
    Panels = <
      item
        Width = 50
      end>
    Visible = False
    ExplicitTop = 504
  end
  object pnlCampos: TPanel [3]
    Left = 0
    Top = 58
    Width = 628
    Height = 104
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 3
    object lblValorTotalVenda: TLabel
      Left = 182
      Top = 56
      Width = 100
      Height = 13
      Caption = 'Valor total venda:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDataHoraVenda: TLabel
      Left = 8
      Top = 56
      Width = 118
      Height = 13
      Caption = 'Data/Hora da venda:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCliente: TLabel
      Left = 136
      Top = 8
      Width = 42
      Height = 13
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblNumeroVenda: TLabel
      Left = 8
      Top = 8
      Width = 102
      Height = 13
      Caption = 'N'#250'mero da venda:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblStatus: TLabel
      Left = 430
      Top = 56
      Width = 40
      Height = 13
      Caption = 'Status:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtValorTotalVenda: TEdit
      Left = 182
      Top = 72
      Width = 242
      Height = 21
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 1
    end
    object edtNumeroVenda: TEdit
      Left = 8
      Top = 24
      Width = 122
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object dbLookupComboBoxVenda: TDBLookupComboBox
      Left = 136
      Top = 24
      Width = 356
      Height = 21
      DataField = 'codigocliente'
      DataSource = DataSource1
      KeyField = 'codigo'
      ListField = 'nome'
      ListSource = dtsClientes
      TabOrder = 2
      OnCloseUp = dbLookupComboBoxVendaCloseUp
    end
    object cmbStatus: TComboBox
      Left = 430
      Top = 72
      Width = 190
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 3
      Text = 'Pendente'
      Items.Strings = (
        'Pendente'
        'Efetivada')
    end
    object btnAdicionarProdutos: TBitBtn
      Left = 497
      Top = 22
      Width = 124
      Height = 24
      Caption = 'Adicionar produtos'
      Glyph.Data = {
        36060000424D3606000000000000360000002800000020000000100000000100
        1800000000000006000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF0D85182699342896352795342498320D8517FF00FFFF00
        FFFF00FFFF00FFFF00FF6969696969696969696969696969695757576E6E6E6C
        6C6C6B6B6B6C6C6C565656696969696969696969696969696969FF00FFFF00FF
        FF00FFFF00FFFF00FF1B90288BF5B274EA9F6CE59480EEA4199026FF00FFFF00
        FFFF00FFFF00FFFF00FF696969696969696969696969696969636363D5D5D5C6
        C6C6BFBFBFCCCCCC636363696969696969696969696969696969FF00FFFF00FF
        FF00FFFF00FFFF00FF1A8E2670E89848D77541D46D68E28C1A8D24FF00FFFF00
        FFFF00FFFF00FFFF00FF696969696969696969696969696969626262C3C3C3AA
        AAAAA5A5A5BBBBBB606060696969696969696969696969696969FF00FFFF00FF
        FF00FFFF00FFFF00FF1A8E256AE48E40D16A3BCE6564DF851A8E25FF00FFFF00
        FFFF00FFFF00FFFF00FF696969696969696969696969696969616161BDBDBDA2
        A2A29E9E9EB6B6B6616161696969696969696969696969696969FF00FFFF00FF
        FF00FFFF00FFFF00FF1A8B2563DE8437CA5E33C95B5FDB7E1A8B25FF00FFFF00
        FFFF00FFFF00FFFF00FF6969696969696969696969696969695F5F5FB5B5B599
        9999979797B1B1B15F5F5F6969696969696969696969696969690D8517178D22
        188D23198D231A8A242696325BD67A2BC45029C34C57D475259630198A24188D
        23188D23178D220D85175656565F5F5F6060606060605F5F5F6B6B6BADADAD90
        90908E8E8EAAAAAA6B6B6B5E5E5E6060606060605F5F5F5656561F942A58D470
        41C85944CB5E48CD6352CF6D3DC55A29BF4927BF473BC3574ECC6842CA5C40C8
        5941C95A58D4701F942A676767A8A8A89898989B9B9B9E9E9EA4A4A49696968B
        8B8B8A8A8A939393A0A0A09A9A9A979797989898A8A8A867676722922D38C251
        05AE241CB5362EBB4737BF513CC15641C45A40C4593AC05434BE4D2FBC4820B6
        3A06AE2338C25122922D6767679191917171717E7E7E8888888F8F8F92929295
        95959595959090908D8D8D89898980808071717191919167676721912C4DC965
        49C45E52C76850C6654FC5644EC5634EC5644FC5644EC5644FC66450C66552C7
        6749C45E4DC96521912C6666669D9D9D9898989D9D9D9C9C9C9B9B9B9A9A9A9B
        9B9B9B9B9B9B9B9B9B9B9B9C9C9C9D9D9D9898989D9D9D6666661E932A73DD87
        69D67E69D57D69D57D6BD37E64CC765CCA705CCA7064CC766BD37E69D57D69D5
        7D69D67E73DD871E932A666666B7B7B7AFAFAFAFAFAFAFAFAFAEAEAEA7A7A7A3
        A3A3A3A3A3A7A7A7AEAEAEAFAFAFAFAFAFAFAFAFB7B7B76666660C8517168D22
        168C21168C2117892220942C75D6886CCF7E6CCF7E75D68820942C178922168C
        21168C21168D220C85175656565F5F5F5E5E5E5E5E5E5D5D5D686868B4B4B4AC
        ACACACACACB4B4B46868685D5D5D5E5E5E5E5E5E5F5F5F565656FF00FFFF00FF
        FF00FFFF00FFFF00FF1689217CDB8D7DD48C7DD48C7CDB8D168921FF00FFFF00
        FFFF00FFFF00FFFF00FF6969696969696969696969696969695D5D5DB9B9B9B5
        B5B5B5B5B5B9B9B95D5D5D696969696969696969696969696969FF00FFFF00FF
        FF00FFFF00FFFF00FF158B1F84DE948CDA998CDA9984DE94158B1FFF00FFFF00
        FFFF00FFFF00FFFF00FF6969696969696969696969696969695D5D5DBEBEBEBE
        BEBEBEBEBEBEBEBE5D5D5D696969696969696969696969696969FF00FFFF00FF
        FF00FFFF00FFFF00FF148B208FE19FA1E0ACA1E0AC8FE19F148B20FF00FFFF00
        FFFF00FFFF00FFFF00FF6969696969696969696969696969695D5D5DC4C4C4CA
        CACACACACAC4C4C45D5D5D696969696969696969696969696969FF00FFFF00FF
        FF00FFFF00FFFF00FF158D208EE69F9EE3AB9EE3AB8EE69F158D20FF00FFFF00
        FFFF00FFFF00FFFF00FF6969696969696969696969696969695F5F5FC7C7C7CB
        CBCBCBCBCBC7C7C75F5F5F696969696969696969696969696969FF00FFFF00FF
        FF00FFFF00FFFF00FF0C85171D93291F902A1F902A1D93290C8517FF00FFFF00
        FFFF00FFFF00FFFF00FF69696969696969696969696969696956565666666665
        6565656565666666565656696969696969696969696969696969}
      NumGlyphs = 2
      TabOrder = 4
      OnClick = btnAdicionarProdutosClick
    end
    object edtDataHoraVenda: TEdit
      Left = 8
      Top = 72
      Width = 168
      Height = 21
      ReadOnly = True
      TabOrder = 5
    end
  end
  object pnlProdutosVendidos: TPanel [4]
    Left = 0
    Top = 342
    Width = 628
    Height = 162
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 4
    object dbgProdutosVendidos: TDBGrid
      Left = 2
      Top = 32
      Width = 624
      Height = 109
      Align = alClient
      BorderStyle = bsNone
      DataSource = dstProdutosVendidos
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'codigo'
          Title.Caption = 'C'#243'digo'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Title.Caption = 'Descri'#231#227'o'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 276
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'precounitario'
          Title.Alignment = taRightJustify
          Title.Caption = 'Pre'#231'o unit'#225'rio'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 90
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'quantidadevendida'
          Title.Alignment = taCenter
          Title.Caption = 'Quantidade'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 74
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'valortotal'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor Total'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 100
          Visible = True
        end>
    end
    object stbProdutosVendidos: TStatusBar
      Left = 2
      Top = 141
      Width = 624
      Height = 19
      Panels = <
        item
          Text = 'Total de registros:'
          Width = 50
        end>
    end
    object pnlProdutosAdicionadosParaVenda: TPanel
      Left = 2
      Top = 2
      Width = 624
      Height = 30
      Align = alTop
      TabOrder = 2
      object lblProdutosEfetivadaPendente: TLabel
        Left = 8
        Top = 8
        Width = 167
        Height = 14
        Caption = 'Produtos com venda efetivada'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnEfetivarVenda: TBitBtn
        Left = 515
        Top = 2
        Width = 106
        Height = 25
        Caption = 'Efetivar venda'
        Glyph.Data = {
          36060000424D3606000000000000360000002800000020000000100000000100
          1800000000000006000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFA3C0B3369D6E008C4B008B4A008B4A008C4B369D6EA3C0B3FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB8B8B883838369696968
          6868686868696969838383B8B8B8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF44A27700905001A16901AB7601AC7901AC7901AB7601A16900905055A8
          82FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8A8A8A6C6C6C7E7E7E88888889
          89898989898888887E7E7E6C6C6C939393FF00FFFF00FFFF00FFFF00FFFF00FF
          55A88200915202AC7700C38C00D79B00DA9C00DA9C00D79C01C38C01AB760092
          5355A882FF00FFFF00FFFF00FFFF00FF9393936E6E6E8989899C9C9CADADADAF
          AFAFAFAFAFADADAD9D9D9D8888886E6E6E939393FF00FFFF00FFFF00FFAECABE
          0090510FB48300D29800D59800D19200CF9000D09100D39600D69B00D19801AB
          76009050AECBBEFF00FFFF00FFC3C3C36D6D6D939393A9A9A9ABABABA6A6A6A5
          A5A5A6A6A6A9A9A9ACACACA8A8A88888886C6C6CC3C3C3FF00FFFF00FF369D6C
          16AB7810C99600D39700CD8CFFFFFFFFFFFFFFFFFF00CC8C00D19500D59B01C1
          8C01A169369E6EFF00FFFF00FF8282828B8B8BA5A5A5A9A9A9A2A2A2FFFFFFFF
          FFFFFFFFFFA2A2A2A7A7A7ACACAC9B9B9B7E7E7E848484FF00FFFF00FF008A48
          39C49D00D19800CB8CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00CA8C00CF9600D2
          9B01AB76008C4BFF00FFFF00FF666666A9A9A9A8A8A8A1A1A1FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFA1A1A1A7A7A7AAAAAA888888696969FF00FFFF00FF008946
          52D2B000CC92FFFFFFFFFFFFFFFFFF00C484FFFFFFFFFFFFFFFFFF00C88D00D0
          9A00AD79008B4AFF00FFFF00FF656565B9B9B9A4A4A4FFFFFFFFFFFFFFFFFF9B
          9B9BFFFFFFFFFFFFFFFFFFA0A0A0A8A8A88A8A8A686868FF00FFFF00FF008845
          68DDBE00C991FFFFFFFFFFFF00C68C00C89100C58BFFFFFFFFFFFFFFFFFF00CC
          9600AD78008B4AFF00FFFF00FF646464C7C7C7A1A1A1FFFFFFFFFFFF9E9E9EA1
          A1A19D9D9DFFFFFFFFFFFFFFFFFFA5A5A5898989686868FF00FFFF00FF008846
          76E0C600CB9800C59000C69100C89500C99700C89400C38CFFFFFFFFFFFF00C7
          9200AB75008C4BFF00FFFF00FF656565CCCCCCA5A5A59F9F9FA0A0A0A2A2A2A3
          A3A3A2A2A29C9C9CFFFFFFFFFFFFA1A1A1878787696969FF00FFFF00FF41A675
          59C9A449DEBC00C79400C89700C99800C99900C99800C79400C38EFFFFFF00BD
          8A00A06740A878FF00FFFF00FF8C8C8CB1B1B1C3C3C3A1A1A1A3A3A3A4A4A4A4
          A4A4A4A4A4A1A1A19D9D9DFFFFFF9898987D7D7D8D8D8DFF00FFFF00FFCCE8DB
          0A9458ADF8E918D0A700C49500C69700C69800C79800C79800C69700C59612B5
          85008F50CCE8DBFF00FFFF00FFE1E1E1727272EBEBEBAFAFAFA0A0A0A2A2A2A2
          A2A2A2A2A2A2A2A2A2A2A2A1A1A19494946C6C6CE1E1E1FF00FFFF00FFFF00FF
          55B185199C63BCFFF75EE4C900C59A00C39600C49700C59A22CAA22FC1960293
          556ABC96FF00FFFF00FFFF00FFFF00FF9999997C7C7CF5F5F5CDCDCDA2A2A29F
          9F9FA0A0A0A2A2A2ABABABA4A4A4707070A7A7A7FF00FFFF00FFFF00FFFF00FF
          FF00FF6ABB940E965974D5B6A0F4E194EFDC7CE6CC5ED6B52EB58703915255B2
          88FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA5A5A5747474C1C1C1E5E5E5DF
          DFDFD2D2D2BFBFBF9898986E6E6E9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFCCE8DB44A87700874400874300874400894644AA7ACCE8DBFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE0E0E08E8E8E63636363
          63636363636565658F8F8FE1E1E1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnEfetivarVendaClick
      end
    end
  end
  inherited DataSource1: TDataSource
    DataSet = dm.cdsVenda
    Left = 520
    Top = 224
  end
  object dtsClientes: TDataSource
    DataSet = dm.cdsCliente
    Left = 448
    Top = 224
  end
  object dstProdutosVendidos: TDataSource
    DataSet = dm.cdsProdutosVendidos
    Left = 448
    Top = 329
  end
end
