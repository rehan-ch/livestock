$(document).on('turbo:load', function() {
  const chatMessages = $('#messages');
  if (chatMessages.length > 0) {
    chatMessages.scrollTop(chatMessages.prop('scrollHeight'));
  }
});