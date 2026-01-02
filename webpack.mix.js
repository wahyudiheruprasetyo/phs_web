const mix = require('laravel-mix');

// Frontend Assets
mix.js('resources/js/app.js', 'public/js')
   .sass('resources/sass/app.scss', 'public/css')
   .version();