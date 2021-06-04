object DMServer: TDMServer
  OldCreateOrder = False
  OnCreate = ServerMethodDataModuleCreate
  Encoding = esUtf8
  Height = 330
  Width = 416
  object DWServerEvents1: TDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crPost]
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'set'
            Encoded = True
          end>
        JsonMode = jmPureJSON
        Name = 'registrar'
        OnReplyEvent = DWServerEvents1EventsRegistrarReplyEvent
      end
      item
        Routes = [crPost]
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'set'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'state'
        OnReplyEvent = DWServerEvents1EventsstateReplyEvent
      end
      item
        Routes = [crPost]
        DWParams = <>
        JsonMode = jmDataware
        Name = 'Ligar'
        OnReplyEvent = DWServerEvents1EventsLigarReplyEvent
      end
      item
        Routes = [crPost]
        DWParams = <>
        JsonMode = jmDataware
        Name = 'Desligar'
        OnReplyEvent = DWServerEvents1EventsDesligarReplyEvent
      end
      item
        Routes = [crPost]
        DWParams = <>
        JsonMode = jmDataware
        Name = 'Transferir'
        OnReplyEvent = DWServerEvents1EventsTransferirReplyEvent
      end
      item
        Routes = [crPost]
        DWParams = <>
        JsonMode = jmDataware
        Name = 'EnviarDTMF'
        OnReplyEvent = DWServerEvents1EventsEnviarDTMFReplyEvent
      end>
    ContextName = 'SIP'
    Left = 80
    Top = 103
  end
end
