import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["categorySelector", "dairyFields"]
  
  // Hardcoded category IDs for dairy animals
  // Replace these with your actual category IDs for dairy animals
  dairyCategoryIds = ["c8e22d4b-b971-4035-a9a7-2df95b5ad6b9"] // Example IDs - update with your real dairy category IDs
  
  connect() {
    // Initial check when the form loads
    this.toggleDairyFields()
    
    // Add event listener for category changes
    this.categorySelectorTarget.addEventListener("change", this.toggleDairyFields.bind(this))
  }
  
  toggleDairyFields() {
    const selectedCategoryId = this.categorySelectorTarget.value
    
    // Show dairy fields if the selected category is a dairy animal
    if (this.dairyCategoryIds.includes(selectedCategoryId)) {
      this.dairyFieldsTarget.style.display = "block"
    } else {
      this.dairyFieldsTarget.style.display = "none"
    }
  }
} 