$(document).on('turbo:load', function() {
  const chatMessages = $('#messages');
  if (chatMessages.length > 0) {
    chatMessages.scrollTop(chatMessages.prop('scrollHeight'));
  }
});

$(document).on('turbo:submit-end', '#new_message_form', function() {
  $(this).trigger('reset');
});
