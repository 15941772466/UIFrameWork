local UIConst = {}

UIConst.UI_TYPE = {
     LOGIN_UI = "ui/login/login_ui",
     MAIN_UI = "ui/main/main_ui",
     BAG_UI = "ui/bag/bag_ui",
     PROP_DETAIL_UI = "ui/bag/prop_detail_ui",
     ITEM_CELL_UI = "ui/bag/item_cell_ui"
}

UIConst.EVENT_TYPE = {
     LOGIN_EVENT = "loginEvent",
     MAIN_BACK_EVENT = "mainBackEvent",
     BAG_EVENT = "bagEvent",
     BAG_BACK_EVENT = "bagBackEvent",
     PROP_USE_EVENT = "propUseEvent",
     PROP_SELL_EVENT = "propSellEvent",
     PROP_BACK_EVENT = "propBackEvent",
     ITEM_CLICK_EVENT = "itemClickEvent"
}

UIConst.UI_NODE = {
     NORMAL = "normal",
     MASK = "normal/mask",
     POPUP = "popup",
     BAG = "normal/bag_ui(Clone)/bag/content"
}
return UIConst