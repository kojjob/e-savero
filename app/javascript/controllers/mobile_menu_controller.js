import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "menu", "categorySubmenu", "categoryIcon"]
  
  connect() {
    // Ensure the menu starts hidden
    this.containerTarget.style.display = "none"
    
    // Add overflow hidden to body when menu is open
    this.containerTarget.addEventListener("transitionend", this.handleTransitionEnd.bind(this))
  }
  
  disconnect() {
    // Clean up event listeners
    this.containerTarget.removeEventListener("transitionend", this.handleTransitionEnd.bind(this))
    
    // Make sure to restore body overflow if controller is disconnected while open
    if (this.containerTarget.style.display !== "none") {
      document.body.classList.remove("overflow-hidden")
    }
  }
  
  open() {
    // Show the menu container
    this.containerTarget.style.display = "flex"
    
    // Force a reflow to ensure the transition starts
    this.containerTarget.offsetWidth
    
    // Add overflow hidden to body
    document.body.classList.add("overflow-hidden")
    
    // Apply the transition to slide in
    this.menuTarget.classList.add("translate-x-0")
    this.menuTarget.classList.remove("-translate-x-full")
    
    // Focus handling for accessibility
    setTimeout(() => {
      // Find the first focusable element in the menu
      const focusableElement = this.menuTarget.querySelector('a, button, input, textarea, select, [tabindex]:not([tabindex="-1"])')
      if (focusableElement) {
        focusableElement.focus()
      }
    }, 300) // Match the transition duration
  }
  
  close() {
    // Apply the transition to slide out
    this.menuTarget.classList.remove("translate-x-0")
    this.menuTarget.classList.add("-translate-x-full")
    
    // Remove overflow hidden from body after transition
    // (done in handleTransitionEnd)
  }
  
  handleTransitionEnd(event) {
    // Only hide the container after the slide-out transition is complete
    if (event.target === this.menuTarget && this.menuTarget.classList.contains("-translate-x-full")) {
      this.containerTarget.style.display = "none"
      document.body.classList.remove("overflow-hidden")
    }
  }
  
  toggleCategorySubmenu() {
    const isHidden = this.categorySubmenuTarget.style.display === "none"
    
    if (isHidden) {
      // Show the submenu
      this.categorySubmenuTarget.style.display = "block"
      
      // Rotate the icon
      this.categoryIconTarget.classList.add("rotate-180")
    } else {
      // Hide the submenu
      this.categorySubmenuTarget.style.display = "none"
      
      // Reset the icon
      this.categoryIconTarget.classList.remove("rotate-180")
    }
  }
}