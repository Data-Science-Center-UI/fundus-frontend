import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menuIcon"];

  connect(){
    this.menuIconTargets.forEach((el) => {
      if(el.href == window.location.href) el.classList.add("sidebar__button-menu--active");
    })
  }
}
