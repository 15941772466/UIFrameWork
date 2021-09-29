local UIConst = {}

UIConst.UI_TYPE = {
     LOGIN_UI = "ui/login/login_ui",
     MAIN_UI = "ui/main/main_ui",
     BAG_UI = "ui/bag/bag_ui",
     PROP_DETAIL_UI = "ui/bag/prop_detail_ui",
}

UIConst.EVENT_TYPE = {
     BAG_DEL_CELL_EVENT = "bagDelCellEvent",
     MAIN_COINS_REFRESH_EVENT = "mainCoinsRefreshEvent"
}

UIConst.UI_NODE = {
     NORMAL = "normal",
     MASK = "normal/mask",
     POPUP = "popup",
     BAG = "normal/bag_ui(Clone)/bag/content"
}

return UIConst