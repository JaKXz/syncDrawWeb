/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var Image = require('./image.model');

exports.register = function(socket) {
  Image.schema.post('save', function(doc) {
    onSave(socket, doc);
  });
  Image.schema.post('remove', function(doc) {
    onRemove(socket, doc);
  });
};

function onSave(socket, doc, cb) {
  socket.emit('image:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('image:remove', doc);
}
