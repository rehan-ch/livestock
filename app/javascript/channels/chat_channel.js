import consumer from "./consumer";

$(document).on('turbo:load', () => {
  const $chatElement = $('#chat-id');
  if ($chatElement.length) {
    const chatId = $chatElement.data('chat-id');
    const productUserId = $chatElement.data('product-user-id');

    const chatChannel = consumer.subscriptions.create(
      { channel: "ChatChannel", chat_id: chatId, product_user_id: productUserId },
      {
        received(data) {
          const $messagesContainer = $('#messages');
          $messagesContainer.append(data.message);

          // Scroll to the bottom of the messages container
          $messagesContainer.scrollTop($messagesContainer.prop('scrollHeight'));

          // Clear the message form
          const $messageForm = $('#message_form');
          if ($messageForm.length) {
            $messageForm[0].reset();
          }
        }
      }
    );

    const $messageForm = $('#message_form');
    if ($messageForm.length) {
      $messageForm.on('submit', function(event) {
        event.preventDefault();
        const $textarea = $(this).find('textarea');
        chatChannel.speak($textarea.val());
        $textarea.val('');
      });
    }
  }
});
