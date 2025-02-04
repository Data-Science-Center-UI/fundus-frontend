import { Controller } from "@hotwired/stimulus";

    export default class extends Controller {
        connect() {
            document.addEventListener('turbo:submit-start', (e) => {
                const form = e.detail.formSubmission.formElement

                if (form.matches('.detection-form')) {
                    document.getElementById('detection-result').replaceChildren(this.loaderAnimation())
                }
            });
        }

        // Try to replace this animation in something like Rails Turbo Frames
        // With functionality with Turbo Stream when Form Submitted.
        loaderAnimation() {
            const loader = `
            <div class="result__empty">
                <div class="result__empty__header">
                    <p class="result__empty__header__title">Getting Result</p>
                    <p class="result__empty__header__description">Fundus Image is being processed, please wait.</p>
                </div>
                <lottie-player class="result__empty__animation" src="https://assets1.lottiefiles.com/packages/lf20_abwlaitp.json" background="transparent" speed="1" loop autoplay></lottie-player>
            </div>`

            return new DOMParser().parseFromString(loader, 'text/html').querySelector(".result__empty")
        }
    }