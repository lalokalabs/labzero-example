import { defineConfig, loadEnv } from 'vite';
import { resolve, join } from 'path';

export default defineConfig({
  base: "/static/",
  build: {
    manifest: "manifest.json",
    outDir: resolve("./static"),
    rollupOptions: {
      input: {
        'app-css': 'src/myapp/fe/css/app.css',
        'main-js': 'src/myapp/fe/js/main.js'
      }
    }
  }
})
