import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["dropdownButton", "dropdownList", "hiddenDropdown"]


  fire(event) {
    const listItem = this.dropdownListTarget
    const button = this.dropdownButtonTarget
    // console.log(listItem)
    // console.log(button)

    const clickedListItem = event.target;
    console.log(clickedListItem);

    // console.log(selectedText)

    button.innerText = clickedListItem.innerText

    // this.hiddenDropdownTarget.value = button.innerText

    const listValue = Number(button.innerText.split(" ")[0])
    // console.log(listValue)
    this.hiddenDropdownTarget.value = listValue

    console.log(this.hiddenDropdownTarget.value)
  }

  connect() {
    console.log("hello from dropdown controller")
  }
}
