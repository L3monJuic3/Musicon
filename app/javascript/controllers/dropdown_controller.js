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
    console.log(this.dropdownButtonTarget.attributes.id.value)
    if (hiddenDuration) {
      event.preventDefault()
      this.dropdownButtonTarget.attributes.id.value = "input-error"
      // this.dropdownButtonTarget.classList.add("#input-error")
    }

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
