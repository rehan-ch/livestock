import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["parentCategory", "childCategory"]

  connect() {
    this.parentCategoryTarget.addEventListener("change", this.updateChildCategories.bind(this))
  }

  async updateChildCategories() {
    const parentCategoryId = this.parentCategoryTarget.value
    if (!parentCategoryId) {
      this.clearChildCategories()
      return
    }

    try {
      // Determine if we're in admin or dashboard based on the current URL
      const isAdmin = window.location.pathname.includes('/admin/')
      const endpoint = isAdmin ? 
        `/admin/my_ads/filtered_categories?parent_category_id=${parentCategoryId}` :
        `/dashboard/my_ads/filtered_categories?parent_category_id=${parentCategoryId}`

      const response = await fetch(endpoint)
      const categories = await response.json()
      
      this.childCategoryTarget.innerHTML = '<option value="">Select Sub Category</option>'
      categories.forEach(([name, id]) => {
        const option = new Option(name, id)
        this.childCategoryTarget.add(option)
      })
    } catch (error) {
      console.error("Error fetching categories:", error)
    }
  }

  clearChildCategories() {
    this.childCategoryTarget.innerHTML = '<option value="">Select Sub Category</option>'
  }
} 