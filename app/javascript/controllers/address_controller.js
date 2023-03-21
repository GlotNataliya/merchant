import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="address"
export default class extends Controller {
  static targets = [ "hideButtons" ]

  onclickHide() {
    this.hideButtonsTarget.classList.add("d-none");
  }

  onclickShow() {
    this.hideButtonsTarget.classList.remove("d-none");
  }
}
