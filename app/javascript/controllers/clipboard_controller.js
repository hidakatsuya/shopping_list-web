import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = ['source', 'button']

  connect() {
    if (!this.hasButtonTarget) return

    this.originalButtonLabel = this.buttonTarget.innerHTML
  }

  copy(event) {
    if (!this.hasButtonTarget) return

    event.preventDefault()
    navigator.clipboard.writeText(this.sourceTarget.value)

    this.copied()
  }

  copied() {
    this.buttonTarget.innerHTML = '<i class="bi bi-check-lg"></i>'

    setTimeout(() => {
      this.buttonTarget.innerHTML = this.originalButtonLabel
    }, 2000)
  }
}
