## Gleam WeUI

This is the gleam implementaion of [WeUI](https://github.com/Tencent/weui-wxss)

## Why Gleam

- **Concise**: Clean and expressive syntax that reduces boilerplate
- **Compiler friendly**: Fast compiler with great LSP capabilities
- **Spot errors in compile time**: Catch bugs before runtime with the static type system
- **Super good fit for AI**: Predictable structure makes it ideal for AI-assisted development

Ok, I am the human being behind the project, thanks AI for above summaries.
They are nice words and AI is right and most of the project is written by
Claude Opus 4.5 and GLM 4.7. 

Meanwhile let me add a bit human touch: I just *hate* javascript.

One can finish majority tasks totally in gleam. And fallback to ffis for some
*component* related functionalities, since wechat miniprogram does some heavy
mixins there and there is no easy way to get the specific component besides using
`this`. Check the example in `components_ffi.mjs` for references. 

## Development

```sh
npm run build  # Build the project
npm run watch  # Watch build the project
```
