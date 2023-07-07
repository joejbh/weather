import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["content", "caret"]

    toggle() {
        this.contentTarget.hidden = !this.contentTarget.hidden
        this.caretTarget.style.transform = this.contentTarget.hidden ? 'rotate(0deg)' : 'rotate(90deg)'
    }
}
