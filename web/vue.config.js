const path = require('path')
module.exports = {
  publicPath: '/',
  outputDir: 'dist',
  assetsDir: 'static',
  lintOnSave: false,
  productionSourceMap: false,
  transpileDependencies: ['alipay-sdk'],
  devServer: {
    hot: true,
    port: 8010,
    open: true,
    proxy: {
      '/': {
        target: 'http://127.0.0.1:8888/',
        changeOrigin: true,
        pathRewrite: { '^/': '' },
      },
    },
  },
  configureWebpack: {
    name: 'system',
    resolve: {
      alias: {
        "~@": __dirname,
        "@": path.resolve(__dirname, "./src")
      }
    },
    module: {
      rules: [
        {
          test: /\.js$/,
          exclude: /node_modules/,
          use: {
            loader: 'babel-loader'
          }
        }
      ]
    }
  },
}
