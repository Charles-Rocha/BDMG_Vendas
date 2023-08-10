inherited frmCadastroProdutos: TfrmCadastroProdutos
  Caption = 'Cadastro de produtos'
  ClientHeight = 441
  ExplicitWidth = 644
  ExplicitHeight = 480
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    inherited btnInserir: TBitBtn
      Hint = 'Insere um novo produto'
      ParentShowHint = False
      ShowHint = True
    end
    inherited btnEditar: TBitBtn
      Hint = 'Edita um produto existente'
      ParentShowHint = False
      ShowHint = True
    end
    inherited btnApagar: TBitBtn
      Hint = 'Apaga um produto existente'
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
      Hint = 'Pesquisa um produto'
      ShowHint = True
      TabOrder = 3
      OnClick = btnPesquisarClick
    end
    inherited btnAtualizar: TBitBtn
      Hint = 'Atualizar lista de produtos'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btnAtualizarClick
    end
  end
  inherited pnlDBGrid: TPanel
    Top = 162
    ExplicitTop = 162
    inherited dbgBaseCadastro: TDBGrid
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      OnCellClick = dbgBaseCadastroCellClick
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
          Width = 270
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nomefantasia'
          Title.Caption = 'Fornecedor'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 130
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
          Width = 50
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
        end>
    end
  end
  inherited StatusBar1: TStatusBar
    Top = 422
    Panels = <
      item
        Text = 'Total de registros:'
        Width = 50
      end>
    ExplicitTop = 422
  end
  object pnlCampos: TPanel [3]
    Left = 0
    Top = 58
    Width = 628
    Height = 104
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 3
    object lblFornecedor: TLabel
      Left = 136
      Top = 56
      Width = 67
      Height = 13
      Caption = 'Fornecedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblStatus: TLabel
      Left = 504
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
    object lblPrecoUnitario: TLabel
      Left = 8
      Top = 56
      Width = 82
      Height = 13
      Caption = 'Pre'#231'o unit'#225'rio:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDescricao: TLabel
      Left = 136
      Top = 8
      Width = 58
      Height = 13
      Caption = 'Descri'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCodigo: TLabel
      Left = 8
      Top = 8
      Width = 41
      Height = 13
      Caption = 'C'#243'digo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtDescricao: TEdit
      Left = 136
      Top = 24
      Width = 484
      Height = 21
      TabOrder = 1
      OnExit = edtDescricaoExit
    end
    object edtCodigo: TEdit
      Left = 8
      Top = 24
      Width = 122
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object cmbStatus: TComboBox
      Left = 504
      Top = 72
      Width = 116
      Height = 21
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 4
      Text = 'Ativo'
      Items.Strings = (
        'Inativo'
        'Ativo')
    end
    object dbLookupComboBoxFornecedor: TDBLookupComboBox
      Left = 136
      Top = 72
      Width = 362
      Height = 21
      DataField = 'codigofornecedor'
      DataSource = DataSource1
      KeyField = 'codigo'
      ListField = 'nomefantasia'
      ListSource = dtsFornecedores
      TabOrder = 3
      OnCloseUp = dbLookupComboBoxFornecedorCloseUp
    end
    object edtPrecoUnitario: TMaskEdit
      Left = 8
      Top = 72
      Width = 122
      Height = 21
      Alignment = taRightJustify
      TabOrder = 2
      Text = ''
      OnChange = edtPrecoUnitarioChange
      OnEnter = edtPrecoUnitarioEnter
      OnExit = edtPrecoUnitarioExit
    end
  end
  inherited DataSource1: TDataSource
    DataSet = dm.cdsProduto
    Left = 560
    Top = 368
  end
  object dtsFornecedores: TDataSource
    DataSet = dm.cdsFornecedor
    Left = 480
    Top = 368
  end
end
