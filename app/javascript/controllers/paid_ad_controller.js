import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["quantity", "adType", "totalAmount"]

  calculateTotal() {
    const quantity = parseInt(this.quantityTarget.value) || 0
    const adType = this.adTypeTarget.value
    const generalPrice = parseInt(this.adTypeTarget.dataset.generalPrice)
    const featuredPrice = parseInt(this.adTypeTarget.dataset.featuredPrice)
    
    const pricePerAd = adType === 'featured' ? featuredPrice : generalPrice
    const total = quantity * pricePerAd

    this.totalAmountTarget.value = `${total.toLocaleString()} PKR`
  }
} 