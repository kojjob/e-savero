import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sunIcon", "moonIcon"]

  connect() {
    // Check if dark mode is already enabled (from localStorage or system preference)
    this.checkDarkMode()
    
    // Listen for system preference changes
    this.systemPreferenceMediaQuery = window.matchMedia('(prefers-color-scheme: dark)')
    this.systemPreferenceMediaQuery.addEventListener('change', this.handleSystemPreferenceChange.bind(this))
    
    console.log("Dark mode controller connected")
  }
  
  disconnect() {
    // Clean up event listener when controller is disconnected
    if (this.systemPreferenceMediaQuery) {
      this.systemPreferenceMediaQuery.removeEventListener('change', this.handleSystemPreferenceChange.bind(this))
    }
  }

  checkDarkMode() {
    // Check for saved theme preference or use system preference
    const savedTheme = localStorage.getItem('theme')
    const systemPrefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches
    
    const isDarkMode = savedTheme === 'dark' || (!savedTheme && systemPrefersDark)
    this.updateUI(isDarkMode)
  }

  toggle() {
    // Get the current state
    const isDarkMode = document.documentElement.classList.contains('dark')
    
    // Toggle the dark mode state
    this.updateUI(!isDarkMode)
    
    // Save the preference to localStorage
    localStorage.setItem('theme', !isDarkMode ? 'dark' : 'light')
    
    console.log("Theme toggled:", !isDarkMode ? 'dark' : 'light')
  }
  
  handleSystemPreferenceChange(event) {
    // Only update if no manual preference is saved
    if (!localStorage.getItem('theme')) {
      const isDarkMode = event.matches
      this.updateUI(isDarkMode)
      console.log("System preference changed to:", isDarkMode ? 'dark' : 'light')
    }
  }

  updateUI(isDarkMode) {
    // Update class on HTML element
    if (isDarkMode) {
      document.documentElement.classList.add('dark')
      document.documentElement.classList.remove('light')
      document.documentElement.dataset.theme = 'dark'
    } else {
      document.documentElement.classList.remove('dark')
      document.documentElement.classList.add('light')
      document.documentElement.dataset.theme = 'light'
    }
    
    // Update icons
    if (this.hasSunIconTarget && this.hasMoonIconTarget) {
      this.sunIconTarget.style.display = isDarkMode ? 'block' : 'none'
      this.moonIconTarget.style.display = isDarkMode ? 'none' : 'block'
    }
  }
}