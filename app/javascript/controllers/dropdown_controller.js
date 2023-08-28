import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["dropdownButton", "dropdownList", "hiddenDropdown", "package", "hiddenPackage"]


  packageType(event) {
    const packageNumber = Number(event.target.attributes[0].value)
    this.hiddenPackageTarget.value = packageNumber
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
