import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    autoUpcase(event) {
        event.target.value = event.target.value.toUpperCase();
    }
}
