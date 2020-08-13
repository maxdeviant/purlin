const spawn = require('cross-spawn');

exports.spawnSyncImpl = function (command, args, options) {
  return spawn.sync(command, args, options);
};
