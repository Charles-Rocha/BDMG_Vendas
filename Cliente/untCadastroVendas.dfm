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
      Caption = 'Adicionar Produtos'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF0D85182699342896352795342498320D8517FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1B90288BF5B274
        EA9F6CE59480EEA4199026FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF1A8E2670E89848D77541D46D68E28C1A8D24FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1A8E256AE48E40
        D16A3BCE6564DF851A8E25FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF1A8B2563DE8437CA5E33C95B5FDB7E1A8B25FF00FFFF00
        FFFF00FFFF00FFFF00FF0D8517178D22188D23198D231A8A242696325BD67A2B
        C45029C34C57D475259630198A24188D23188D23178D220D85171F942A58D470
        41C85944CB5E48CD6352CF6D3DC55A29BF4927BF473BC3574ECC6842CA5C40C8
        5941C95A58D4701F942A22922D38C25105AE241CB5362EBB4737BF513CC15641
        C45A40C4593AC05434BE4D2FBC4820B63A06AE2338C25122922D21912C4DC965
        49C45E52C76850C6654FC5644EC5634EC5644FC5644EC5644FC66450C66552C7
        6749C45E4DC96521912C1E932A73DD8769D67E69D57D69D57D6BD37E64CC765C
        CA705CCA7064CC766BD37E69D57D69D57D69D67E73DD871E932A0C8517168D22
        168C21168C2117892220942C75D6886CCF7E6CCF7E75D68820942C178922168C
        21168C21168D220C8517FF00FFFF00FFFF00FFFF00FFFF00FF1689217CDB8D7D
        D48C7DD48C7CDB8D168921FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF158B1F84DE948CDA998CDA9984DE94158B1FFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF148B208FE19FA1
        E0ACA1E0AC8FE19F148B20FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF158D208EE69F9EE3AB9EE3AB8EE69F158D20FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0C85171D93291F
        902A1F902A1D93290C8517FF00FFFF00FFFF00FFFF00FFFF00FF}
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
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF369D6E008C4B00
          8B4A008B4A008C4B369D6EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF44A27700905001A16901AB7601AC7901AC7901AB7601A16900905055A8
          82FF00FFFF00FFFF00FFFF00FFFF00FF55A88200915202AC7700C38C00D79B00
          DA9C00DA9C00D79C01C38C01AB7600925355A882FF00FFFF00FFFF00FFFF00FF
          0090510FB48300D29800D59800D19200CF9000D09100D39600D69B00D19801AB
          76009050FF00FFFF00FFFF00FF369D6C16AB7810C99600D39700CD8CF5F5F5F5
          F5F5F5F5F500CC8C00D19500D59B01C18C01A169369E6EFF00FFFF00FF008A48
          39C49D00D19800CB8CF5F5F5F5F5F5F5F5F5F5F5F5F5F5F500CA8C00CF9600D2
          9B01AB76008C4BFF00FFFF00FF00894652D2B000CC92F5F5F5F5F5F5F5F5F500
          C484F5F5F5F5F5F5F5F5F500C88D00D09A00AD79008B4AFF00FFFF00FF008845
          68DDBE00C991F5F5F5F5F5F500C68C00C89100C58BF5F5F5F5F5F5F5F5F500CC
          9600AD78008B4AFF00FFFF00FF00884676E0C600CB9800C59000C69100C89500
          C99700C89400C38CF5F5F5F5F5F500C79200AB75008C4BFF00FFFF00FF41A675
          59C9A449DEBC00C79400C89700C99800C99900C99800C79400C38EF5F5F500BD
          8A00A06740A878FF00FFFF00FFFF00FF0A9458ADF8E918D0A700C49500C69700
          C69800C79800C79800C69700C59612B585008F50FF00FFFF00FFFF00FFFF00FF
          55B185199C63BCFFF75EE4C900C59A00C39600C49700C59A22CAA22FC1960293
          556ABC96FF00FFFF00FFFF00FFFF00FFFF00FF6ABB940E965974D5B6A0F4E194
          EFDC7CE6CC5ED6B52EB58703915255B288FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF44A87700874400874300874400894644AA7AFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        Visible = False
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
