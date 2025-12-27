import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["group", "field"]

  update(event) {
    this.#switch(event.target.value)
  }

  #switch(type) {
    const [firstGroup, secondGroup] = this.groupTargets
    const [firstField, secondField] = this.fieldTargets

    const isThing = type === "thing"

    this.#setState(firstGroup, firstField, isThing)
    this.#setState(secondGroup, secondField, !isThing)
  }

  #setState(group, field, visible) {
    group.hidden = !visible
    field.disabled = !visible
  }
}
