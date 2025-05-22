import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["categorySelector", "dairyFields"]
  
  // Dairy category names instead of IDs
  dairyCategoryNames = ["Dairy", "Cow", "Buffalo", "Goat", "Sheep", "Camel"]
  
  connect() {
    // Initial check when the form loads
    this.toggleDairyFields()
    
    // Add event listener for category changes
    this.categorySelectorTarget.addEventListener("change", this.toggleDairyFields.bind(this))
  }
  
  toggleDairyFields() {
    const selectElement = this.categorySelectorTarget
    
    // Get the selected option
    const selectedOption = selectElement.options[selectElement.selectedIndex]
    
    // Get the text (name) of the selected option
    const selectedCategoryName = selectedOption ? selectedOption.text : ""
    
    // Show dairy fields if the selected category is a dairy animal (check by name)
    if (this.dairyCategoryNames.some(name => selectedCategoryName.includes(name))) {
      this.dairyFieldsTarget.style.display = "block"
    } else {
      this.dairyFieldsTarget.style.display = "none"
    }
  }
} 