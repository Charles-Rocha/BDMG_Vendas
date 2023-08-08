inherited frmCadastroClientes: TfrmCadastroClientes
  Caption = 'Cadastro de clientes'
  ClientHeight = 441
  ExplicitWidth = 644
  ExplicitHeight = 480
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    inherited btnInserir: TBitBtn
      Hint = 'Adiciona um novo cliente'
      ParentShowHint = False
      ShowHint = True
    end
    inherited btnEditar: TBitBtn
      Hint = 'Edita um cliente existente'
      ParentShowHint = False
      ShowHint = True
    end
    inherited btnApagar: TBitBtn
      Hint = 'Apaga um cliente existente'
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
      Hint = 'Pesquisa clientes existentes'
      TabOrder = 3
      OnClick = btnPesquisarClick
    end
    inherited btnAtualizar: TBitBtn
      Hint = 'Atualizar lista de clientes'
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
          FieldName = 'nome'
          Title.Caption = 'Nome'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 290
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'cpf'
          Title.Alignment = taCenter
          Title.Caption = 'CPF'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 100
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
          Alignment = taCenter
          Expanded = False
          FieldName = 'datanascimento'
          Title.Alignment = taCenter
          Title.Caption = 'Data nascimento'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 100
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
    object lblNome: TLabel
      Left = 136
      Top = 8
      Width = 35
      Height = 13
      Caption = 'Nome:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCPF: TLabel
      Left = 8
      Top = 56
      Width = 23
      Height = 13
      Caption = 'CPF:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblStatus: TLabel
      Left = 182
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
    object lblDataNascimento: TLabel
      Left = 376
      Top = 56
      Width = 116
      Height = 13
      Caption = 'Data de nascimento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtCodigo: TEdit
      Left = 8
      Top = 24
      Width = 122
      Height = 21
      Color = clWhite
      ReadOnly = True
      TabOrder = 0
    end
    object edtNome: TEdit
      Left = 136
      Top = 24
      Width = 484
      Height = 21
      TabOrder = 1
      OnExit = edtNomeExit
    end
    object edtCPF: TMaskEdit
      Left = 8
      Top = 72
      Width = 168
      Height = 21
      EditMask = '!999.999.999-99;0; '
      MaxLength = 14
      TabOrder = 2
      Text = ''
      OnExit = edtCPFExit
    end
    object edtDataNascimento: TMaskEdit
      Left = 376
      Top = 72
      Width = 244
      Height = 21
      EditMask = '!99/99/9999;0; '
      MaxLength = 10
      TabOrder = 4
      Text = ''
      OnExit = edtDataNascimentoExit
    end
    object cmbStatus: TComboBox
      Left = 182
      Top = 72
      Width = 188
      Height = 21
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 3
      Text = 'Ativo'
      Items.Strings = (
        'Inativo'
        'Ativo')
    end
  end
  inherited DataSource1: TDataSource
    DataSet = dm.cdsCliente
    Left = 296
    Top = 72
  end
end
