import consumer from "./consumer"

$(document).on('turbo:load', function() {
  const chatElement = $('#messages');
  if (chatElement.length) {
    const chatId = chatElement.data('chatId');

    consumer.subscriptions.create({ channel: "ChatChannel", chat_id: chatId }, {
      received(data) {
        chatElement.append(data);
        chatElement.scrollTop(chatElement[0].scrollHeight);
        $('#new_message')[0].reset();
      }
    });
  }
});
