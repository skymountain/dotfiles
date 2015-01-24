#!/usr/bin/env node
'use strict';

var boolOptions = {
  asi         : 'automatic semicolon insertion should be tolerated',
  bitwise     : 'bitwise operators should not be allowed',
  boss        : 'advanced usage of assignments should be allowed',
  browser     : 'the standard browser globals should be predefined',
  couch       : 'CouchDB globals should be predefined',
  curly       : 'curly braces around blocks should be required (even in if/for/while)',
  debug       : 'debugger statements should be allowed',
  devel       : 'logging globals should be predefined (console, alert, etc.)',
  dojo        : 'Dojo Toolkit globals should be predefined',
  eqeqeq      : '=== should be required',
  eqnull      : '== null comparisons should be tolerated',
  es5         : 'ES5 syntax should be allowed',
  evil        : 'eval should be allowed',
  expr        : 'ExpressionStatement should be allowed as Programs',
  forin       : 'for in statements must filter',
  globalstrict: 'global "use strict"; should be allowed (also enables \'strict\')',
  immed       : 'immediate invocations must be wrapped in parens',
  jquery      : 'jQuery globals should be predefined',
  latedef     : 'the use before definition should not be tolerated',
  laxbreak    : 'line breaks should not be checked',
  loopfunc    : 'functions should be allowed to be defined within loops',
  mootools    : 'MooTools globals should be predefined',
  newcap      : 'constructor names must be capitalized',
  noarg       : 'arguments.caller and arguments.callee should be disallowed',
  node        : 'the Node.js environment globals should be predefined',
  noempty     : 'empty blocks should be disallowed',
  nonew       : 'using `new` for side-effects should be disallowed',
  nomen       : 'names should be checked',
  onevar      : 'only one var statement per function should be allowed',
  passfail    : 'the scan should stop on first error',
  plusplus    : 'increment/decrement should not be allowed',
  prototypejs : 'Prototype and Scriptaculous globals should be predefined',
  regexdash   : 'unescaped last dash (-) inside brackets should be tolerated',
  regexp      : 'the . should not be allowed in regexp literals',
  rhino       : 'the Rhino environment globals should be predefined',
  undef       : 'variables should be declared before used',
  scripturl   : 'script-targeted URLs should be tolerated',
  shadow      : 'variable shadowing should be tolerated',
  strict      : 'require the "use strict"; pragma',
  sub         : 'all forms of subscript notation are tolerated',
  supernew    : '`new function () { ... };` and `new Object;` should be tolerated',
  trailing    : 'trailing whitespace rules apply',
  white       : 'strict whitespace rules apply',
  wsh         : 'if the Windows Scripting Host environment globals should be predefined',
  multistr    : 'allow multiline string'
};

function getOptions(argv) {
  var options = {};
  for (var opt in boolOptions) {
    if (argv[opt]) options[opt] = true;
  }
  return options;
}

function getPredefinedVariables(argv) {
  var predefs = argv.predef == null ? [] : argv.predef;
  if (!Array.isArray(predefs)) predefs = [predefs];

  predefs.forEach(function (predef) {
    if (typeof predef !== 'string') {
      console.log('"predef" option must be given a predefined variable name');
      process.exit(1);
    }
  });

  return predefs;
}

function getSource(argv, callback) {
  var fs = require('fs'),
      path = require('path');

  var filename = argv._[0];
  var sourceStreamer;
  if (filename && path.existsSync(filename)) {
    sourceStreamer = fs.createReadStream(filename, { encoding: 'utf8' });
  }
  else {
    sourceStreamer = process.stdin;
    process.stdin.resume();
  }

  var source = '';
  sourceStreamer
    .on('data', function(str) {
      source += str;
    })
    .on('end', function() {
      callback(source, filename);
    });
}

function jshintyfy(source, filename, options, predefs) {
  filename = filename || '<stdin>';
  options.predef = predefs;

  var JSHINT = require('jshint').JSHINT;
  if (JSHINT(source, options, predefs)) return;

  var errors = JSHINT.errors;
  errors.forEach(function (error) {
    if (!error) return;

    console.log(
      filename + ':' +
      error.line + ':' +
      error.character + ':' +
      error.reason
    );
  });
}

function main() {
  var optimist =
    require('optimist')
    .boolean(Object.keys(boolOptions))
    .describe(boolOptions)
    .string('predef')
    .describe('predef', 'specify predefined variable name')
    .boolean('help')
    .describe('help', 'display this information');

  var argv = optimist.argv;
  if (argv.help) {
    optimist.showHelp();
    process.exit(0);
  }

  var options = getOptions(argv),
      predefs = getPredefinedVariables(argv);

  getSource(argv, function(source, filename) {
    jshintyfy(source, filename, options, predefs);
  });
}

main();
