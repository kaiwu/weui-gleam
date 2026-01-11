import gleam/javascript/promise

import wechat/app
import wechat/object.{type JsObject}
import wechat/page
import wechat/util

import app/pages/common

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
  ])
  |> object.set("dialog1", False)
  |> object.set("dialog2", False)
  |> object.set("dialog3", False)
  |> object.set("dialog4", False)
  |> object.set("dialog5", False)
  |> object.set("show1", False)
  |> object.set("show2", False)
  |> object.set("show3", False)
  |> object.set("show4", False)
  |> object.set("show5", False)
  |> object.set("wrap", False)
  |> object.set("wrap1", False)
}

fn timeout_work(o: JsObject) -> Nil {
  {
    let cp = page.current_page()
    let _ = page.set_data(cp, o, fn() { Nil })
  }
  |> util.drain
}

fn close() -> Nil {
  {
    let cp = page.current_page()
    let d1 =
      object.new()
      |> object.set("dialog1", False)
      |> object.set("dialog2", False)
      |> object.set("dialog3", False)
      |> object.set("dialog4", False)
      |> object.set("dialog5", False)
    let d2 =
      object.new()
      |> object.set("show1", False)
      |> object.set("show2", False)
      |> object.set("show3", False)
      |> object.set("show4", False)
      |> object.set("show5", False)
    use _ <- promise.await(page.set_data(cp, d1, fn() { Nil }))
    promise.resolve(app.set_timeout(400, d2, timeout_work))
  }
  |> util.drain
}

fn open1() -> Nil {
  {
    let cp = page.current_page()
    let d =
      object.new()
      |> object.set("dialog1", True)
      |> object.set("show1", True)
    Ok(page.set_data(cp, d, fn() { Nil }))
  }
  |> util.drain
}

fn open2() -> Nil {
  {
    let cp = page.current_page()
    let d =
      object.new()
      |> object.set("dialog2", True)
      |> object.set("show2", True)
    Ok(page.set_data(cp, d, fn() { Nil }))
  }
  |> util.drain
}

fn open3() -> Nil {
  Nil
}

fn open4() -> Nil {
  {
    let cp = page.current_page()
    let d =
      object.new()
      |> object.set("dialog4", True)
      |> object.set("show4", True)
    Ok(page.set_data(cp, d, fn() { Nil }))
  }
  |> util.drain
}

fn open5() -> Nil {
  {
    let cp = page.current_page()
    let d =
      object.new()
      |> object.set("dialog5", True)
      |> object.set("show5", True)
    Ok(page.set_data(cp, d, fn() { Nil }))
  }
  |> util.drain
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
    #("close", close),
    #("open1", open1),
    #("open2", open2),
    #("open3", open3),
    #("open4", open4),
    #("open5", open5),
  ])
  |> object.set("data", init())
}
