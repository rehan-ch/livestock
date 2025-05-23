import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener('change', this.handleStatusChange.bind(this))
  }

  handleStatusChange(event) {
    const selectedStatus = event.target.value
    window.location.href = `/admin/my_ads?status=${selectedStatus}`
  }
} 