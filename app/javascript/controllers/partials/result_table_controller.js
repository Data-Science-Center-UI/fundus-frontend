import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["resultTableRow"];

  connect() {
    function getThresholdRange(value) {
      const ranges = [
        { min: 0.0, max: 50.0, class: "" },
        { min: 51.0, max: 60.0, class: "--low" },
        { min: 61.0, max: 70.0, class: "--medium" },
        { min: 71.0, max: 80.0, class: "--high" },
        { min: 81.0, max: 90.0, class: "--critical" },
        { min: 91.0, max: 100.0, class: "--damage" },
      ];

      const range = ranges.find((range) => value >= range.min && value <= range.max);

      return range ? range.class : "Value out of range";
    }

    this.resultTableRowTargets.forEach((el) => {
        const probability = Math.floor(el.dataset.probability);
        const thresholdRange = probability ? getThresholdRange(probability) : "";

        el.classList.add(`result-table__row${thresholdRange}`);
    });
  }
}
