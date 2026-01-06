import { build, context } from 'esbuild'
import { Ok, Error } from "./gleam.mjs"

import path from 'path';
import less from 'less';
import fs from 'fs/promises';

const wxss = {
  name: 'wxss-plugin',
  setup(build) {
    build.onLoad({ filter: /\.less$/ }, async (args) => {
      // 1. Read the LESS file
      const source = await fs.readFile(args.path, 'utf8');

      // 2. Transform ~ imports (CORRECT regex)
      const finalSource = source.replace(
        /@import\s+['"]~([^'"]+)['"]/g,
        '@import "$1"'
      );

      // 4. Compile with LESS
      const result = await less.render(finalSource, {
        filename: args.path,
        paths: [
          path.resolve('node_modules'),
          path.dirname(args.path),
          process.cwd()
        ],
        javascriptEnabled: false,
        math: 'always'
      });

      // 5. Return as CSS
      return {
        contents: result.css,
        loader: 'css'
      };
    });
  }
};

export function bundle_build(entry, out) {
  return new Promise(resolve => {
      build({
        entryPoints: [entry],
        bundle: true,
        minify: true,
        format: 'esm',
        outfile: out,
      }).then(function(r){
        resolve(new Ok(undefined))
      }).catch(function(e){
        resolve(new Error(JSON.stringify(e)))
      })
  })
}

export function js_build(js, out) {
  return new Promise(resolve => {
      build({
        stdin: {
          contents: js,
          loader: 'js',
        },
        bundle: false,
        minify: false,
        format: 'esm',
        outfile: out,
      }).then(function(r){
        resolve(new Ok(undefined))
      }).catch(function(e){
        resolve(new Error(JSON.stringify(e)))
      })
  })
}

export function copy_build(src, out) {
  return new Promise(resolve => {
      build({
        entryPoints: [src],
        loader: {'.wxml': 'copy', '.json': 'copy'},
        outfile: out,
      }).then(function(r){
        resolve(new Ok(undefined))
      }).catch(function(e){
        resolve(new Error(JSON.stringify(e)))
      })
  })
}

export function less_build(css, out) {
  return new Promise(resolve => {
      build({
        entryPoints: [css],
        plugins: [wxss],
        loader: {'.less': 'css'},
        outfile: out,
      }).then(function(r){
        resolve(new Ok(undefined))
      }).catch(function(e){
        resolve(new Error(JSON.stringify(e)))
      })
  })
}

export function bundle_watch(entry, out) {
  return new Promise(resolve => {
      context({
        entryPoints: [entry],
        bundle: true,
        minify: true,
        format: 'esm',
        outfile: out,
      }).then(function(ctx){
        ctx.watch()
        console.log(`watching bundle ${entry}...`)
      }).then(function(){
        resolve(new Ok(undefined))
      }).catch(function(e){
        resolve(new Error(JSON.stringify(e)))
      })
  })
}

export function js_watch(js, out) {
  return new Promise(resolve => {
      context({
        stdin: {
          contents: js,
          loader: 'js',
        },
        bundle: false,
        minify: false,
        format: 'esm',
        outfile: out,
      }).then(function(ctx){
        ctx.watch()
        console.log("watching js...")
      }).then(function(){
        resolve(new Ok(undefined))
      }).catch(function(e){
        resolve(new Error(JSON.stringify(e)))
      })
  })
}

export function copy_watch(src, out) {
  return new Promise(resolve => {
      context({
        entryPoints: [src],
        loader: {'.wxml': 'copy', '.json': 'copy'},
        outfile: out,
      }).then(function(ctx){
        ctx.watch()
        console.log(`watching json/wxml ${src}...`)
      }).then(function(){
        resolve(new Ok(undefined))
      }).catch(function(e){
        resolve(new Error(JSON.stringify(e)))
      })
  })
}

export function less_watch(css, out) {
  return new Promise(resolve => {
      context({
        entryPoints: [css],
        plugins: [wxss],
        loader: {'.less': 'css'},
        outfile: out,
      }).then(function(ctx){
        ctx.watch()
        console.log(`watching css ${css}...`)
      }).then(function(){
        resolve(new Ok(undefined))
      }).catch(function(e){
        resolve(new Error(JSON.stringify(e)))
      })
  })
}
