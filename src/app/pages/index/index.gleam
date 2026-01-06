import gleam/io
import gleam/result

import wechat/app
import wechat/object.{type JsObject}

type Block {
  Block(id: String, name: String, open: Bool, pages: List(String))
}

fn init() -> JsObject {
  object.new()
  |> object.set("list", [
    Block(id: "form", name: "表单", open: False, pages: [
      "cell",
      "slideview",
      "form",
      "uploader",
    ]),
    Block(id: "widget", name: "基础组件", open: False, pages: [
      "article",
      "icons",
      "badge",
      "flex",
      "footer",
      "gallery",
      "grid",
      "loadmore",
      "loading",
      "panel",
      "preview",
    ]),
    Block(id: "feedback", name: "操作反馈", open: False, pages: [
      "dialog",
      "msg",
      "half-screen-dialog",
      "actionsheet",
      "toptips",
    ]),
    Block(id: "nav", name: "导航相关", open: False, pages: ["navigation", "tabbar"]),
    Block(id: "search", name: "搜索相关", open: False, pages: ["searchbar"]),
  ])
}

fn on_show() -> Nil {
  let _ =
    app.get_app()
    |> object.get("set_theme")
    |> result.try(object.call(_, ""))
  Nil
}

fn kind_toggle(_e: JsObject) -> Nil {
  io.println("toggle kind")
  Nil
}

pub fn page() -> JsObject {
  object.literal([
    #("kingToggle", kind_toggle),
  ])
  |> object.set("onShow", on_show)
  |> object.set("data", init())
}
