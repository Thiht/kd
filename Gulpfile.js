var gulp  = require('gulp'),
    jisonCli = require('gulp-jison-cli');

gulp.task('grammar', function() {
	return gulp.src('./src/*.jison')
	           .pipe(jisonCli())
	           .pipe(gulp.dest('./dist/'));
});

gulp.task('default', ['grammar']);
