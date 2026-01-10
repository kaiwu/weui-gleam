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
}

fn timeout_work2(o: JsObject) -> Nil {
  {
    let cp = page.current_page()
    let _ = page.set_data(cp, o, fn() { Nil })
  }
  |> util.drain
}

fn timeout_work1(o: JsObject) -> Nil {
  {
    let cp = page.current_page()
    let t2 = object.literal([#("toast", False), #("hideToast", False)])
    use _ <- promise.await(page.set_data(cp, o, fn() { Nil }))
    promise.resolve(app.set_timeout(300, t2, timeout_work2))
  }
  |> util.drain
}

fn open_toast() -> Nil {
  {
    let cp = page.current_page()
    let t0 = object.literal([#("toast", True)])
    let t1 = object.literal([#("hideToast", True)])
    use _ <- promise.await(page.set_data(cp, t0, fn() { Nil }))
    promise.resolve(app.set_timeout(300, t1, timeout_work1))
  }
  |> util.drain
}

fn timeout_warn_work2(o: JsObject) -> Nil {
  {
    let cp = page.current_page()
    let _ = page.set_data(cp, o, fn() { Nil })
  }
  |> util.drain
}

fn timeout_warn_work1(o: JsObject) -> Nil {
  {
    let cp = page.current_page()
    let t2 = object.literal([#("warnToast", False), #("hidewarnToast", False)])
    use _ <- promise.await(page.set_data(cp, o, fn() { Nil }))
    promise.resolve(app.set_timeout(300, t2, timeout_warn_work2))
  }
  |> util.drain
}

fn open_warn_toast() -> Nil {
  {
    let cp = page.current_page()
    let t0 = object.literal([#("warnToast", True)])
    let t1 = object.literal([#("hidewarnToast", True)])
    use _ <- promise.await(page.set_data(cp, t0, fn() { Nil }))
    promise.resolve(app.set_timeout(3000, t1, timeout_warn_work1))
  }
  |> util.drain
}

fn timeout_text_more_work2(o: JsObject) -> Nil {
  {
    let cp = page.current_page()
    let _ = page.set_data(cp, o, fn() { Nil })
  }
  |> util.drain
}

fn timeout_text_more_work1(o: JsObject) -> Nil {
  {
    let cp = page.current_page()
    let t2 =
      object.literal([#("textMoreToast", False), #("hideTextMoreToast", False)])
    use _ <- promise.await(page.set_data(cp, o, fn() { Nil }))
    promise.resolve(app.set_timeout(300, t2, timeout_text_more_work2))
  }
  |> util.drain
}

fn open_text_more_toast() -> Nil {
  {
    let cp = page.current_page()
    let t0 = object.literal([#("textMoreToast", True)])
    let t1 = object.literal([#("hideTextMoreToast", True)])
    use _ <- promise.await(page.set_data(cp, t0, fn() { Nil }))
    promise.resolve(app.set_timeout(3000, t1, timeout_text_more_work1))
  }
  |> util.drain
}

fn timeout_text_work2(o: JsObject) -> Nil {
  {
    let cp = page.current_page()
    let _ = page.set_data(cp, o, fn() { Nil })
  }
  |> util.drain
}

fn timeout_text_work1(o: JsObject) -> Nil {
  {
    let cp = page.current_page()
    let t2 = object.literal([#("textToast", False), #("hideTextToast", False)])
    use _ <- promise.await(page.set_data(cp, o, fn() { Nil }))
    promise.resolve(app.set_timeout(300, t2, timeout_text_work2))
  }
  |> util.drain
}

fn open_text_toast() -> Nil {
  {
    let cp = page.current_page()
    let t0 = object.literal([#("textToast", True)])
    let t1 = object.literal([#("hideTextToast", True)])
    use _ <- promise.await(page.set_data(cp, t0, fn() { Nil }))
    promise.resolve(app.set_timeout(3000, t1, timeout_text_work1))
  }
  |> util.drain
}

fn timeout_loading_work2(o: JsObject) -> Nil {
  {
    let cp = page.current_page()
    let _ = page.set_data(cp, o, fn() { Nil })
  }
  |> util.drain
}

fn timeout_loading_work1(o: JsObject) -> Nil {
  {
    let cp = page.current_page()
    let t2 = object.literal([#("loading", False), #("hideLoading", False)])
    use _ <- promise.await(page.set_data(cp, o, fn() { Nil }))
    promise.resolve(app.set_timeout(300, t2, timeout_loading_work2))
  }
  |> util.drain
}

fn open_loading() -> Nil {
  {
    let cp = page.current_page()
    let t0 = object.literal([#("loading", True)])
    let t1 = object.literal([#("hideLoading", True)])
    use _ <- promise.await(page.set_data(cp, t0, fn() { Nil }))
    promise.resolve(app.set_timeout(3000, t1, timeout_loading_work1))
  }
  |> util.drain
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
    #("openToast", open_toast),
    #("openWarnToast", open_warn_toast),
    #("openTextMoreToast", open_text_more_toast),
    #("openTextToast", open_text_toast),
    #("openLoading", open_loading),
  ])
  |> object.set("data", init())
}
