#!/bin/bash

# Make sure we have node installed
. $SCRIPTS/plugins/dependencies/node.sh;

# As angular generator requires SASS/Compass check that too
. $SCRIPTS/plugins/dependencies/sass.sh;

mkdir -p $CLIENT;
cd $CLIENT;

npm install -g yo gulp generator-gulp-angular bower;
npm update -g yo gulp generator-gulp-angular bower;
yo gulp-angular;
npm install gulp-ng-constant --save-dev;

# Environments to decoupled angular client
mkdir -p env_configs/local;
echo '{
  "name": "app.config",
  "deps": "",
  "wrap": "",
  "constants": {
    "config": {
      "apiURL": "http://localhost:8000"
    }
  }
}' > env_configs/local/config.json;
echo "var gulp = require('gulp');
var ngConstant = require('gulp-ng-constant');

gulp.task('config:local', function () {
  gulp.src('env_configs/local/config.json')
    .pipe(ngConstant())
    .pipe(gulp.dest('app/scripts'));
});" > gulp/environment.js;
echo "app/scripts/config.js" >> .gitignore;

echo "
gulp.task('tdd', function() {
  var bowerDeps = wiredep({
    directory: 'app/bower_components',
    exclude: ['bootstrap-sass-official'],
    dependencies: true,
    devDependencies: true
  });

  var testFiles = bowerDeps.js.concat([
    'app/scripts/**/*.js',
    'test/unit/**/*.js'
  ]);

  return gulp.src(testFiles)
    .pipe($.karma({
      configFile: 'test/karma.conf.js',
      action: 'watch'
    }))
    .on('error', function(err) {
      // Make sure failed tests cause gulp to exit non-zero
      throw err;
    });
});" >> gulp/unit-tests.js



echo "Client Commands
===============

The client side on this project makes use of [gulp](http://gulp.io/) task runner to automate work.

To run the server:

    gulp serve

To test your code:

    gulp test (for unit tests)
    gulp protractor (for e2e tests)

To build the project (including minification and compilation) to a distributable folder:

    gulp build

See gulpfile.js and/or gulp/ folder for available tasks in this project.
" > README.md
