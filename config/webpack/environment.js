const { environment } = require('@rails/webpacker');
const { VueLoaderPlugin } = require('vue-loader');
const vue = require('./loaders/vue');
const { merge } = require('webpack-merge');

const sassLoader = environment.loaders.get('sass');
const cssLoader = environment.loaders.get('css');

sassLoader.use.map(function(loader) {
  if (loader.loader === 'css-loader') {
    loader.options = merge(loader.options, { sourceMap: false });
  }
});

cssLoader.use.map(function(loader) {
  if (loader.loader === 'css-loader') {
    loader.options = merge(loader.options, { sourceMap: false });
  }
});

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin());
environment.loaders.prepend('vue', vue);
module.exports = environment;
