inherited frmCadastroFornecedores: TfrmCadastroFornecedores
  Caption = 'Cadastro de fornecedores'
  ClientHeight = 441
  ExplicitWidth = 644
  ExplicitHeight = 480
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    inherited btnInserir: TBitBtn
      Hint = 'Adiciona um novo fornecedor'
      ParentShowHint = False
      ShowHint = True
    end
    inherited btnEditar: TBitBtn
      Hint = 'Edita um fornecedor existente'
      ParentShowHint = False
      ShowHint = True
    end
    inherited btnApagar: TBitBtn
      Hint = 'Apaga um fornecedor existente'
      ParentShowHint = False
      ShowHint = True
    end
    inherited btnCancelar: TBitBtn
      Hint = 'Cancela uma opera'#231#227'o'
      ParentShowHint = False
      ShowHint = True
      Spacing = 2
      TabOrder = 6
    end
    inherited btnGravar: TBitBtn
      Hint = 'Grava uma opera'#231#227'o'
      ParentShowHint = False
      ShowHint = True
      Spacing = 0
      TabOrder = 5
    end
    inherited btnPesquisar: TBitBtn
      Hint = 'Pesquisa um fornecedor'
      ShowHint = True
      TabOrder = 3
      OnClick = btnPesquisarClick
    end
    inherited btnAtualizar: TBitBtn
      Hint = 'Atualizar lista de fornecedores'
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
          FieldName = 'nomefantasia'
          Title.Caption = 'Nome fantasia'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 190
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'razaosocial'
          Title.Caption = 'Raz'#227'o social'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 190
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'cnpj'
          Title.Alignment = taCenter
          Title.Caption = 'CNPJ'
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
          Width = 50
          Visible = True
        end>
    end
  end
  inherited StatusBar1: TStatusBar
    Top = 422
    Panels = <
      item
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
    object lblRazaoSocial: TLabel
      Left = 8
      Top = 56
      Width = 73
      Height = 13
      Caption = 'Raz'#227'o social:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblStatus: TLabel
      Left = 432
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
    object lblCNPJ: TLabel
      Left = 256
      Top = 56
      Width = 30
      Height = 13
      Caption = 'CNPJ:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblNomeFantasia: TLabel
      Left = 136
      Top = 8
      Width = 84
      Height = 13
      Caption = 'Nome fantasia:'
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
    object edtRazaoSocial: TEdit
      Left = 8
      Top = 72
      Width = 242
      Height = 21
      TabOrder = 2
      OnExit = edtRazaoSocialExit
    end
    object edtNomeFantasia: TEdit
      Left = 136
      Top = 24
      Width = 484
      Height = 21
      TabOrder = 1
      OnExit = edtNomeFantasiaExit
    end
    object edtCodigo: TEdit
      Left = 8
      Top = 24
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object cmbStatus: TComboBox
      Left = 432
      Top = 72
      Width = 188
      Height = 21
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 4
      Text = 'Ativo'
      Items.Strings = (
        'Inativo'
        'Ativo')
    end
    object edtCNPJ: TMaskEdit
      Left = 256
      Top = 72
      Width = 169
      Height = 21
      EditMask = '99.999.999/9999-99;0 '
      MaxLength = 19
      TabOrder = 3
      Text = ''
      OnExit = edtCNPJExit
    end
  end
  inherited DataSource1: TDataSource
    DataSet = dm.cdsFornecedor
    Left = 288
    Top = 272
  end
end
