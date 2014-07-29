require('coffee-script/register')

gulp = require('gulp')
coffee = require('gulp-coffee')
bump = require('gulp-bump')
rimraf = require('rimraf')


argv = require('yargs')
  .alias('b', 'bump')
  .default('bump', 'patch')
  .describe('bump', 'bump [major|minor|patch|prerelease] version')  
  .argv

paths =   
  manifest: ['./bower.json', 'package.json']
  coffee: ['./src/*.coffee']
  dist: './dist'

gulp.task 'bump', ->  
  gulp.src paths.manifest
    .pipe bump { type: argv.bump }
    .pipe gulp.dest('.')  

gulp.task 'clean', (done) ->
  rimraf paths.dist, done

gulp.task 'coffee', ->
  gulp.src paths.coffee
    .pipe(coffee())
    .pipe gulp.dest paths.dist

gulp.task 'build', ['clean', 'coffee']
gulp.task 'default', ['build']

gulp.task 'watch', ['build'], ->
  gulp.watch paths.coffee, ['coffee']
