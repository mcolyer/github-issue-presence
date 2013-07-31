module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    //pkg: grunt.file.readJSON('package.json'),
    coffee: {
      compile : {
        files: {
          'build/page.js' : 'src/page.coffee',
        }
      }
    },

    concat: {
      dist: {
        src: ['lib/jquery-2.0.3.js', 'build/page.js'],
        dest: 'contentscript.js',
      },
    },

    watch: {
      scripts: {
        files: ['src/*'],
        tasks: ['build'],
        options: {
          spawn: false,
        },
      },
    }
  });

  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-concat');

  grunt.registerTask('build', ['coffee', 'concat']);
  grunt.registerTask('default', ['watch']);
};
