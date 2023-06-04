import "./config/i18n";
import "./controllers";
import "@hotwired/turbo-rails";
import * as bootstrap from "bootstrap";

window.process = { env: {} };

// Bootstrap tooltips

var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
  return new bootstrap.Tooltip(tooltipTriggerEl)
});
