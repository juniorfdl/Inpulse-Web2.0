object ServerContainer1: TServerContainer1
  OldCreateOrder = False
  Height = 271
  Width = 415
  object DSServer1: TDSServer
    Left = 40
    Top = 19
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    Left = 224
    Top = 27
  end
  object DSServerClassAtivo: TDSServerClass
    OnGetClass = DSServerClassAtivoGetClass
    Server = DSServer1
    Left = 216
    Top = 107
  end
  object DSServerClassCidades: TDSServerClass
    OnGetClass = DSServerClassCidadesGetClass
    Server = DSServer1
    Left = 56
    Top = 139
  end
  object DSServerClassContatos: TDSServerClass
    OnGetClass = DSServerClassContatosGetClass
    Server = DSServer1
    Left = 192
    Top = 187
  end
end
