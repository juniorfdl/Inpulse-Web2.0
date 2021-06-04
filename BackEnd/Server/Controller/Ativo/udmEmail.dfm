object dmEmail: TdmEmail
  OldCreateOrder = False
  Height = 283
  Width = 410
  object IdMessage: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    FromList = <
      item
        Address = 'colorsystem.br@ra.com.br'
        Name = 'Ivan'
        Text = 'Ivan <colorsystem.br@ra.com.br>'
        Domain = 'ra.com.br'
        User = 'colorsystem.br'
      end>
    From.Address = 'colorsystem.br@ra.com.br'
    From.Name = 'Ivan'
    From.Text = 'Ivan <colorsystem.br@ra.com.br>'
    From.Domain = 'ra.com.br'
    From.User = 'colorsystem.br'
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 160
    Top = 16
  end
  object IdSMTP: TIdSMTP
    Host = 'smtp.terra.com.br'
    Password = 'd7n3r3'
    SASLMechanisms = <>
    Username = 'colorsystem.br@terra.com.br'
    Left = 200
    Top = 88
  end
  object OpenSSL: TIdSSLIOHandlerSocketOpenSSL
    Destination = 'smtp.terra.com.br:25'
    Host = 'smtp.terra.com.br'
    MaxLineAction = maException
    Port = 25
    DefaultPort = 0
    SSLOptions.Method = sslvSSLv2
    SSLOptions.SSLVersions = [sslvSSLv2]
    SSLOptions.Mode = sslmClient
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 248
    Top = 88
  end
end
