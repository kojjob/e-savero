import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]
  static values = { 
    open: Boolean,
    placement: { type: String, default: "bottom-right" },
    closeOnClickOutside: { type: Boolean, default: true },
    closeOnEscape: { type: Boolean, default: true },
    closeOnSelection: { type: Boolean, default: false },
    hoverMode: { type: Boolean, default: false }
  }
  
  connect() {
    // Set up initial state
    this.menuTarget.classList.add("hidden")
    
    // Handle hover mode if enabled
    if (this.hoverModeValue) {
      this.element.addEventListener("mouseenter", this.show.bind(this))
      this.element.addEventListener("mouseleave", this.hide.bind(this))
    }
    
    // Add keyboard event listener for Escape key
    if (this.closeOnEscapeValue) {
      document.addEventListener("keydown", this.handleKeyDown.bind(this))
    }
    
    // Apply placement class
    this.applyPlacement()
  }
  
  disconnect() {
    // Clean up event listeners
    if (this.closeOnEscapeValue) {
      document.removeEventListener("keydown", this.handleKeyDown.bind(this))
    }
    if (this.hoverModeValue) {
      this.element.removeEventListener("mouseenter", this.show.bind(this))
      this.element.removeEventListener("mouseleave", this.hide.bind(this))
    }
  }
  
  toggle(event) {
    event.stopPropagation()
    this.menuTarget.classList.contains("hidden") ? this.show() : this.hide()
  }
  
  show() {
    this.menuTarget.classList.remove("hidden")
    this.openValue = true
    
    // Dispatch event for other components to react
    this.dispatch("shown", { detail: { id: this.element.id } })
  }
  
  hide(event = null) {
    // Skip if event exists and it's within the dropdown
    if (event && this.element.contains(event.target) && !this.closeOnSelectionValue) {
      return
    }
    
    this.menuTarget.classList.add("hidden")
    this.openValue = false
    
    // Dispatch event for other components to react
    this.dispatch("hidden", { detail: { id: this.element.id } })
  }
  
  handleClickOutside(event) {
    if (this.closeOnClickOutsideValue && !this.element.contains(event.target)) {
      this.hide()
    }
  }
  
  handleKeyDown(event) {
    if (event.key === "Escape" && !this.menuTarget.classList.contains("hidden")) {
      this.hide()
    }
  }
  
  select(event) {
    if (this.closeOnSelectionValue) {
      this.hide()
    }
    
    // Dispatch selected event with the selected value
    const value = event.currentTarget.dataset.value || event.currentTarget.innerText
    this.dispatch("selected", { detail: { value, id: this.element.id } })
  }
  
  placementValueChanged() {
    this.applyPlacement()
  }
  
  applyPlacement() {
    // Remove any existing placement classes
    const placementClasses = [
      "origin-top-right", "origin-top-left", "origin-bottom-right", "origin-bottom-left",
      "right-0", "left-0", "top-full", "bottom-full", "mb-2", "mt-2", "absolute"
    ]
    
    placementClasses.forEach(cls => {
      this.menuTarget.classList.remove(cls)
    })
    
    // Make sure the menu is absolutely positioned
    this.menuTarget.classList.add("absolute", "z-50")
    
    // Apply new placement classes
    switch (this.placementValue) {
      case "top-right":
        this.menuTarget.classList.add("origin-bottom-right", "right-0", "bottom-full", "mb-2")
        break
      case "top-left":
        this.menuTarget.classList.add("origin-bottom-left", "left-0", "bottom-full", "mb-2")
        break  
      case "bottom-left":
        this.menuTarget.classList.add("origin-top-left", "left-0", "top-full", "mt-2")
        break
      case "bottom-right":
      default:
        this.menuTarget.classList.add("origin-top-right", "right-0", "top-full", "mt-2")
        break
    }
  }
}