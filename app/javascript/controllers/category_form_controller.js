import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mainCategory", "parentCategory"]

  connect() {
    this.mainCategoryTarget.addEventListener("change", this.updateParentCategories.bind(this))
  }

  async updateParentCategories() {
    const mainCategoryId = this.mainCategoryTarget.value
    if (!mainCategoryId) {
      this.clearParentCategories()
      return
    }

    try {
      // Determine if we're in admin or dashboard based on the current URL
      const isAdmin = window.location.pathname.includes('/admin/')
      const endpoint = isAdmin ? 
        `/admin/categories/filtered_parents?main_category_id=${mainCategoryId}` :
        `/dashboard/my_ads/filtered_categories?main_category_id=${mainCategoryId}`

      const response = await fetch(endpoint)
      const categories = await response.json()
      
      this.parentCategoryTarget.innerHTML = '<option value="">Select Category</option>'
      categories.forEach(([name, id]) => {
        const option = new Option(name, id)
        this.parentCategoryTarget.add(option)
      })
    } catch (error) {
      console.error("Error fetching categories:", error)
    }
  }

  clearParentCategories() {
    this.parentCategoryTarget.innerHTML = '<option value="">Select Category</option>'
  }
} 