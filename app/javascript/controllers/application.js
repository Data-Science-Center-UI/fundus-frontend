import { Application } from '@hotwired/stimulus'
import Popover from "stimulus-popover"
import Notification from 'stimulus-notification'

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

// Stimulus Components
application.register('popover', Popover)
application.register('notification', Notification)

export { application }
