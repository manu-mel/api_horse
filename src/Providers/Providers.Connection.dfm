object ProvidersConnection: TProvidersConnection
  OldCreateOrder = False
  Height = 150
  Width = 215
  object Driver: TFDPhysPgDriverLink
    VendorLib = 'C:\EXCIA\libpq.dll'
    Left = 40
    Top = 16
  end
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=dvdrental'
      'User_Name=postgres'
      'Password=masterkey'
      'DriverID=PG')
    Connected = True
    LoginPrompt = False
    Left = 144
    Top = 96
  end
end
