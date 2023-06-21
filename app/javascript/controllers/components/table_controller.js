import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    openDestinationFrame(event) {
        const target = event.currentTarget

        document.querySelector(`#${target.dataset.destinationFrame}`).setAttribute('src', target.dataset.destination);
    }
}
