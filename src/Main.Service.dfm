object MainService: TMainService
  OldCreateOrder = False
  OnCreate = ServiceCreate
  DisplayName = '_API'
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 150
  Width = 215
end
