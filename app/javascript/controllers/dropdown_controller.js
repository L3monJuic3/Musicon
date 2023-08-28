import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["dropdownElement"]

  fire() {
    // const selectElement = this.dropdownElementTarget
    // // Delay the modification by 500 milliseconds (adjust as needed)

    // console.log(selectElement.children)
    // selectElement.classList.remove("optional");
    // selectElement.classList.remove("select");
    // selectElement.classList.remove("form-select");
    // console.log(selectElement.children[0].classList.add("event-drop"))
    // // selectElement.children[0].style.fontSize = "20px"
    // selectElement.classList.add("custom-dropdown");

  }

  connect() {
    console.log("hello from dropdown controller")
  }
}
