$(document).on('turbo:load', function() {
  const chatMessages = $('#messages');
  if (chatMessages.length > 0) {
    chatMessages.scrollTop(chatMessages.prop('scrollHeight'));
  }
});

$(document).on('turbo:submit-end', function(event) {
  if (event.detail.form.id === 'new_message') {
    $('#new_message')[0].reset();
  }
});

$(document).on('turbo:before-stream-update', function(event) {
  const messages = $('#messages');
  messages.scrollTop(messages.prop('scrollHeight'));
});