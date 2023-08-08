object frmConfigurarBancoDados: TfrmConfigurarBancoDados
  Left = 422
  Top = 222
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Configurar Banco de Dados'
  ClientHeight = 186
  ClientWidth = 378
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 361
    Height = 121
    BevelInner = bvLowered
    Color = clInactiveCaptionText
    TabOrder = 0
    object lblServidor: TLabel
      Left = 8
      Top = 8
      Width = 52
      Height = 13
      Caption = 'Servidor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblBancoDados: TLabel
      Left = 184
      Top = 8
      Width = 93
      Height = 13
      Caption = 'Bancode dados:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblUsuario: TLabel
      Left = 8
      Top = 64
      Width = 48
      Height = 13
      Caption = 'Usuario:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSenha: TLabel
      Left = 184
      Top = 64
      Width = 41
      Height = 13
      Caption = 'Senha:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtServidor: TEdit
      Left = 8
      Top = 24
      Width = 169
      Height = 21
      TabOrder = 0
    end
    object edtBancoDados: TEdit
      Left = 184
      Top = 24
      Width = 169
      Height = 21
      TabOrder = 1
    end
    object edtUsuario: TEdit
      Left = 8
      Top = 80
      Width = 169
      Height = 21
      TabOrder = 2
    end
    object edtSenha: TEdit
      Left = 184
      Top = 80
      Width = 169
      Height = 21
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 8
    Top = 129
    Width = 361
    Height = 48
    BevelInner = bvLowered
    Color = clInactiveCaptionText
    TabOrder = 1
    object btnOk: TButton
      Left = 143
      Top = 12
      Width = 75
      Height = 25
      Caption = 'Salvar'
      Default = True
      TabOrder = 0
      OnClick = btnOkClick
    end
  end
end
