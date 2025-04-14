import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropdown"]
  static values = { controllerName: { type: String, default: "header-dropdown" } }
  
  connect() {
    // Initialize the controller
    document.addEventListener("click", this.handleDocumentClick.bind(this))
    document.addEventListener("keydown", this.handleKeyDown.bind(this))
    
    // Find all header-dropdown controllers and add them to targets
    const dropdowns = document.querySelectorAll('[data-controller="header-dropdown"]')
    dropdowns.forEach(dropdown => {
      if (!this.dropdownTargets.includes(dropdown)) {
        this.element.querySelector('[data-dropdown-interactions-target="dropdown"]') || 
        this.element.appendChild(Object.assign(document.createElement('div'), {
          dataset: { dropdownInteractionsTarget: 'dropdown' },
          style: 'display: none;'
        }))
      }
    })
    
    // Listen for dropdown events
    document.addEventListener("header-dropdown:shown", this.handleDropdownShown.bind(this))
  }
  
  disconnect() {
    // Clean up event listeners
    document.removeEventListener("click", this.handleDocumentClick.bind(this))
    document.removeEventListener("keydown", this.handleKeyDown.bind(this))
    document.removeEventListener("header-dropdown:shown", this.handleDropdownShown.bind(this))
  }
  
  handleDocumentClick(event) {
    // Global handler for closing dropdowns when clicking outside
    this.dropdownTargets.forEach(dropdown => {
      const controller = this.application.getControllerForElementAndIdentifier(dropdown, this.controllerNameValue)
      if (controller && !controller.element.contains(event.target)) {
        controller.hide()
      }
    })
  }
  
  handleKeyDown(event) {
    // Global handler for keyboard navigation
    if (event.key === "Tab") {
      // Handle tab navigation between dropdown items
    } else if (event.key === "ArrowDown" || event.key === "ArrowUp") {
      // Handle arrow navigation within an open dropdown
      const openDropdown = this.findOpenDropdown()
      if (openDropdown) {
        event.preventDefault()
        this.navigateDropdown(openDropdown, event.key === "ArrowDown" ? 1 : -1)
      }
    }
  }
  
  handleDropdownShown(event) {
    // When a dropdown is shown, close other dropdowns
    const shownDropdownId = event.detail.id
    
    this.dropdownTargets.forEach(dropdown => {
      if (dropdown.id !== shownDropdownId) {
        const controller = this.application.getControllerForElementAndIdentifier(dropdown, this.controllerNameValue)
        if (controller && !controller.menuTarget.classList.contains("hidden")) {
          controller.hide()
        }
      }
    })
  }
  
  findOpenDropdown() {
    // Find the currently open dropdown
    for (const dropdown of this.dropdownTargets) {
      const controller = this.application.getControllerForElementAndIdentifier(dropdown, this.controllerNameValue)
      if (controller && !controller.menuTarget.classList.contains("hidden")) {
        return controller
      }
    }
    return null
  }
  
  navigateDropdown(controller, direction) {
    // Navigate through focusable elements in the dropdown
    const focusableElements = Array.from(
      controller.menuTarget.querySelectorAll('a[href], button, [tabindex]:not([tabindex="-1"])')
    )
    
    if (focusableElements.length === 0) return
    
    const currentIndex = focusableElements.findIndex(el => document.activeElement === el)
    let nextIndex
    
    if (currentIndex === -1) {
      // Nothing focused yet, focus the first or last item
      nextIndex = direction > 0 ? 0 : focusableElements.length - 1
    } else {
      // Calculate the next index with wrapping
      nextIndex = (currentIndex + direction + focusableElements.length) % focusableElements.length
    }
    
    focusableElements[nextIndex].focus()
  }
}