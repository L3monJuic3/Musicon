import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["dropdownButton",
                    "dropdownList",
                    "hiddenDropdown",
                    "package",
                    "hiddenPackage",
                    "submitButton",
                    "durationField"]

  lessonFormSubmit(event) {

    event.preventDefault()
    // console.log(this.hiddenDropdownTarget)
    const hiddenDuration = !this.hiddenDropdownTarget.value
    const durationButton = this.dropdownButtonTarget

    if (hiddenDuration) {
      event.preventDefault()
      durationButton.attributes.id.value = "input-error"
      const errorMessageText = document.querySelector("#duration-error-message")

      if (!errorMessageText) {
        durationButton.closest("#button-div").insertAdjacentHTML("beforebegin", '<span class="error-red-text" id="duration-error-message">Field cannot be empty</span>')
        durationButton.closest("#button-div").classList.remove("pt-2")
      }

    }
      // this.dropdownButtonTarget.classList.add("#input-error")

  }

  packageType(event) {
    // console.log(Number(event.target.closest("#lesson-package").getAttribute("value")))
    const packageNumber = Number(event.target.closest("#lesson-package").getAttribute("value"))
    this.hiddenPackageTarget.value = packageNumber
    // console.log(this.hiddenPackageTarget.value)

    this.submitButtonTarget.click()

  }

  fire(event) {
    const listItem = this.dropdownListTarget
    const button = this.dropdownButtonTarget
    const clickedListItem = event.target;
    button.innerText = clickedListItem.innerText
    const listValue = Number(button.innerText.split(" ")[0])
    this.hiddenDropdownTarget.value = listValue
    console.log(listValue)
  }

  connect() {
    console.log("hello from dropdown controller")
  }
}
