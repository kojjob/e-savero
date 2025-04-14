import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="landing-page"
export default class extends Controller {
  static targets = ["scrollElement"]

  connect() {
    console.log("Landing page controller connected")
    this.addScrollAnimation()
  }

  addScrollAnimation() {
    if (!this.hasScrollElementTarget) return
    
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            entry.target.classList.add('scale-up')
          }
        })
      },
      {
        root: null,
        threshold: 0.1
      }
    )
    
    this.scrollElementTargets.forEach(element => {
      observer.observe(element)
    })
  }
}
