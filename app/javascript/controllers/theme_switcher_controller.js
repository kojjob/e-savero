import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sunIcon", "moonIcon"]
  
  connect() {
    // Initialize the theme based on localStorage or system preference
    this.initializeTheme()
    
    // Make sure the correct icon is shown on initial load
    const isDarkMode = document.documentElement.classList.contains('dark')
    this.updateIconVisibility(isDarkMode)
    
    // Log to verify controller connection
    console.log('Theme switcher controller connected')
  }
  
  initializeTheme() {
    // Check for saved theme preference or use system preference
    const savedTheme = localStorage.getItem('theme')
    const systemDarkMode = window.matchMedia('(prefers-color-scheme: dark)').matches
    
    if (savedTheme === 'dark' || (!savedTheme && systemDarkMode)) {
      this.enableDarkMode()
    } else {
      this.enableLightMode()
    }
  }
  
  toggle(event) {
    // Prevent default button action
    event.preventDefault()
    
    // Toggle between dark and light mode
    if (document.documentElement.classList.contains('dark')) {
      this.enableLightMode()
    } else {
      this.enableDarkMode()
    }
    
    // Log for debugging
    console.log('Theme toggled, current theme:', localStorage.getItem('theme'))
  }
  
  enableDarkMode() {
    // Apply dark mode
    document.documentElement.classList.add('dark')
    document.documentElement.classList.remove('light')
    document.documentElement.setAttribute('data-theme', 'dark')
    localStorage.setItem('theme', 'dark')
    
    // Update icon visibility
    this.updateIconVisibility(true)
  }
  
  enableLightMode() {
    // Remove dark mode
    document.documentElement.classList.remove('dark')
    document.documentElement.classList.add('light')
    document.documentElement.setAttribute('data-theme', 'light')
    localStorage.setItem('theme', 'light')
    
    // Update icon visibility
    this.updateIconVisibility(false)
  }
  
  updateIconVisibility(isDarkMode) {
    // Helper method to update the icons
    if (isDarkMode) {
      this.moonIconTarget.style.display = 'none'
      this.sunIconTarget.style.display = 'block'
    } else {
      this.moonIconTarget.style.display = 'block'
      this.sunIconTarget.style.display = 'none'
    }
  }
}