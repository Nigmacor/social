var gulp = require('gulp');
var sass = require('gulp-sass');
var browserSync = require('browser-sync').create();
var exec = require('child_process').exec;

//compile scss into css
function style() {
  return gulp.src('account/static/scss/*.scss')
  .pipe(sass().on('error',sass.logError))
  .pipe(gulp.dest('account/static/css'))
  .pipe(browserSync.stream());
}
function watch() {
  browserSync.init({
    notify: true,
    port: 8000,
    proxy: '127.0.0.1:8000'
  });
  
  gulp.watch('./**/*.scss', style)
  gulp.watch('./**/*.html').on('change',browserSync.reload);
  gulp.watch('./**/js/**/*.js').on('change', browserSync.reload);
}

exports.style = style;
exports.watch = watch;
exports.default = watch;