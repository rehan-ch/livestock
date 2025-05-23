import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkAll"]

  connect() {
    this.checkAllTarget.addEventListener('change', this.handleSelectionChange.bind(this))
  }

  handleSelectionChange(event) {
    const selectedValue = event.target.value
    if (!selectedValue) return // Skip if empty option selected

    fetch('/admin/products/toggle_all', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({
        action: selectedValue // 'select' or 'deselect'
      })
    })
    .then(response => response.json())
    .then(data => {
      console.log('Success:', data)
      // Update all checkboxes based on the selection
      const checkboxes = document.querySelectorAll('input[type="checkbox"]')
      checkboxes.forEach(checkbox => {
        checkbox.checked = selectedValue === 'select'
      })
      
      // Reset the dropdown to default option
      event.target.value = ''
    })
    .catch((error) => {
      console.error('Error:', error)
      // Reset the dropdown to default option
      event.target.value = ''
    })
  }
} 