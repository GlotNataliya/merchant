import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="card"
export default class extends Controller {
  static targets = [ "link" ]
  static classes = [ "loading" ]

  toggle() {
    this.linkTarget.innerHTML = "Cart is empty"
    this.element.classList.add(this.loadingClass)
  }
}
