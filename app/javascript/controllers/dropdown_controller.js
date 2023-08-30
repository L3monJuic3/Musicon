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

    const hiddenDuration = this.hiddenDropdownTarget.value
    const durationButton = this.dropdownButtonTarget
    const errorMessageText = document.querySelector("#duration-error-message")

    if (!hiddenDuration) {
      event.preventDefault()
      durationButton.attributes.id.value = "input-error"
    }

    if (!errorMessageText) {
      event.preventDefault()
      durationButton.closest("#button-div").insertAdjacentHTML("beforebegin", '<span class="error-red-text" id="duration-error-message">Field cannot be empty</span>')
      durationButton.closest("#button-div").classList.remove("pt-2")

    }
  }

  packageType(event) {
    const packageDiv = event.target.closest("#lesson-package");

    if (packageDiv) {
      const packageNumber = Number(packageDiv.getAttribute("value"));
      this.hiddenPackageTarget.value = packageNumber;
      console.log(this.hiddenPackageTarget.value)
      this.submitButtonTarget.click();
    } else {
      const singlePackage = Number(event.target.closest("div").getAttribute("value"));
      this.hiddenPackageTarget.value = singlePackage;
      this.submitButtonTarget.click();
    }
    // const packageDiv = event.target.closest("#lesson-package")
    // // console.log(packageDiv.getAttribute("value"))
    // let packageValue = this.hiddenPackageTarget.value
    // console.log(packageDiv)
    // if (packageDiv){
    //   const packageNumber = Number(packageDiv.getAttribute("value"))
    //   packageValue = packageNumber
    //   console.log(typeof packageValue)
    //   // const package = parseInt(packageNumber, 10)
    //   // console.log(typeof package)
    //   // Check duration dropdown box
    //   this.submitButtonTarget.click()
    // } else {
    //   const singlePackage = Number(event.target.closest("div").getAttribute("value"))

    //   this.hiddenPackageTarget.value = singlePackage
    //   this.submitButtonTarget.click()
    // }


  }

  fire(event) {
    const listItem = this.dropdownListTarget
    const button = this.dropdownButtonTarget
    const clickedListItem = event.target;
    button.innerText = clickedListItem.innerText
    const listValue = Number(button.innerText.split(" ")[0])
    this.hiddenDropdownTarget.value = listValue

  }

  connect() {
    console.log("hello from dropdown controller")
  }
}
