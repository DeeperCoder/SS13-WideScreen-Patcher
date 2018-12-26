object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'SS13 WideScreen Patcher'
  ClientHeight = 312
  ClientWidth = 860
  Color = clAqua
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 291
    Width = 58
    Height = 13
    Caption = #1042#1077#1088#1089#1080#1103': 0.2'
  end
  object Label2: TLabel
    Left = 272
    Top = 72
    Width = 133
    Height = 23
    Caption = #1057#1090#1072#1090#1091#1089' '#1080#1075#1088#1099': '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 504
    Top = 72
    Width = 113
    Height = 23
    Caption = #1053#1077' '#1085#1072#1081#1076#1077#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 272
    Top = 136
    Width = 213
    Height = 23
    Caption = #1040#1082#1090#1091#1072#1083#1100#1085#1086#1089#1090#1100' Byond: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 504
    Top = 136
    Width = 109
    Height = 23
    Caption = 'V 512.1460'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 272
    Top = 232
    Width = 75
    Height = 25
    Caption = #1055#1088#1086#1087#1072#1090#1095#1080#1090#1100
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 504
    Top = 232
    Width = 75
    Height = 25
    Caption = #1042#1099#1081#1090#1080
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 368
    Top = 286
    Width = 121
    Height = 25
    Caption = #1055#1086#1076#1076#1077#1088#1078#1072#1090#1100' '#1072#1074#1090#1086#1088#1072
    TabOrder = 2
    OnClick = Button3Click
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 8
    Top = 8
  end
end
