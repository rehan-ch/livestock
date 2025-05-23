import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkAll", "minPriceRange", "maxPriceRange", "minPriceDisplay", "maxPriceDisplay", "minPriceInput", "maxPriceInput"]

  connect() {
    if (this.hasCheckAllTarget) {
      this.checkAllTarget.addEventListener('change', this.handleSelectionChange.bind(this))
    }
    if (this.hasMinPriceRangeTarget && this.hasMaxPriceRangeTarget) {
      this.updateRangeConstraints()
    }
  }

  updatePrice(event) {
    const isMin = event.target === this.minPriceRangeTarget
    const value = parseInt(event.target.value)
    if (isMin) {
      const maxValue = parseInt(this.maxPriceRangeTarget.value)
      if (value > maxValue) {
        event.target.value = maxValue
        return
      }
      this.minPriceDisplayTarget.textContent = `Rs ${value}`
      this.minPriceInputTarget.value = value
    } else {
      const minValue = parseInt(this.minPriceRangeTarget.value)
      if (value < minValue) {
        event.target.value = minValue
        return
      }
      this.maxPriceDisplayTarget.textContent = `Rs ${value}`
      this.maxPriceInputTarget.value = value
    }
  }

  updateRangeConstraints() {
    const minValue = parseInt(this.minPriceRangeTarget.value)
    const maxValue = parseInt(this.maxPriceRangeTarget.value)
    
    // Ensure min doesn't exceed max
    if (minValue > maxValue) {
      this.minPriceRangeTarget.value = maxValue
      this.minPriceDisplayTarget.textContent = `Rs ${maxValue}`
      this.minPriceInputTarget.value = maxValue
    }
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