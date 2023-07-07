import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["basicFields", "ipAddress"]

    toggleIpEntry() {
        this.basicFieldsTarget.hidden = !this.basicFieldsTarget.hidden
        this.ipAddressTarget.hidden = !this.ipAddressTarget.hidden
    }
}
