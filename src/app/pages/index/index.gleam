import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/io
import gleam/list
import gleam/result

import wechat/app
import wechat/object.{type JsObject}
import wechat/page

type Block {
  Block(id: String, name: String, open: Bool, pages: List(String))
}

@external(javascript, "../../../app_ffi.mjs", "generic_decoder")
fn block_from_dynamic(d: Dynamic) -> Result(Block, Block)

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
    |> result.try(object.call(_, "index"))
  Nil
}

fn kind_toggle(e: JsObject) -> Nil {
  let r = {
    use oid <- result.try(object.path_field(
      e,
      "currentTarget.id",
      decode.string,
    ))
    use data <- result.try(page.get_data(0))
    let decoder = decode.new_primitive_decoder("Block", block_from_dynamic)
    use block_list <- result.try(object.field(
      data,
      "list",
      decode.list(decoder),
    ))
    list.try_fold(block_list, [], fn(ls, b) {
      let ns = case b {
        Block(id, _, _, _) if id == oid ->
          list.append(ls, [Block(..b, open: !b.open)])
        Block(_, _, _, _) -> list.append(ls, [Block(..b, open: False)])
      }
      Ok(ns)
    })
  }
  case r {
    Ok(bs) -> {
      let cp = page.current_page()
      let _ = page.set_data(cp, object.literal([#("list", bs)]), fn() { Nil })
      io.println("toggle kind done")
    }
    Error(error) ->
      case error {
        object.WechatError(m) -> io.println("toggle kind error: " <> m)
        _ -> io.println("toggle kind error")
      }
  }
}

pub fn page() -> JsObject {
  object.literal([
    #("kingToggle", kind_toggle),
  ])
  |> object.set("onShow", on_show)
  |> object.set("data", init())
}
