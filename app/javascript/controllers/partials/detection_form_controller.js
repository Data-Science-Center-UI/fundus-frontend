import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["birthDayField", "birthMonthField", "ageField"];

    calculateAge(event) {
        const birth = new Date(event.currentTarget.value, this.birthMonthFieldTarget.value - 1, this.birthDayFieldTarget.value)
        const now = new Date()
        const diff = new Date(now.valueOf() - birth.valueOf())

        this.ageFieldTarget.value = Math.abs(diff.getFullYear() - 1970)
    }
}