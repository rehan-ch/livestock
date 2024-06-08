import consumer from "./consumer"

document.addEventListener('turbo:load', () => {
  const chatElement = document.getElementById('messages')
  if (chatElement) {
    const chatId = chatElement.dataset.chatId

    consumer.subscriptions.create({ channel: "ChatChannel", chat_id: chatId }, {
      received(data) {
        chatElement.insertAdjacentHTML('beforeend', data)
      }
    })
  }
})
