const which = require('which');

exports.whichSyncImpl = function (command) {
  return which.sync(command, {
    nothrow: true,
  });
};

exports.whichAllSyncImpl = function (command) {
  return which.sync(command, {
    nothrow: true,
    all: true,
  });
};
