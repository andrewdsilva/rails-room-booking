// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "./controllers";
import "@hotwired/turbo-rails";
import * as bootstrap from "bootstrap";

window.process = { env: {} };

// Bootstrap tooltips

var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
  return new bootstrap.Tooltip(tooltipTriggerEl)
});
