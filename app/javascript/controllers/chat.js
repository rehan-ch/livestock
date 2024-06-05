$(document).on('turbo:load', function() {
 $('#chat-button').on('click', function() {
    const productId = $(this).data('product-id');
    const url = '/ads/' + productId + '/chats';
    $.ajax({
      type: 'POST',
      url: url,
      dataType: 'script',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success: function(response) {
        $('body').append(response);
        $('#chatModal').modal('show');
      },
      error: function(xhr, status, error) {
        console.error('Error creating chat:', error);
      }
    });
  });



  $('#message-form').on('submit', function(event) {
    event.preventDefault();
    const chatId = $(this).data('chat-id');
    const productId = $(this).data('product-id');
    const messageContent = $(this).find('input[name="content"]').val();
    $.ajax({
      type: 'POST',
      url: '/ads/' + productId + '/chats/' + chatId + '/messages',
      data: { message: { content: messageContent } },
      dataType: 'json',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success: function(response) {
        $('#message-form').find('input[name="content"]').val('');
        $('#chatModal').modal('show');
      },
      error: function(xhr, status, error) {
        console.error('Error creating message:', xhr.responseText);
      }
    });
  });
});
