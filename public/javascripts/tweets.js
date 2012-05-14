$(document).ready(function () {
  setupRefresh();
});

function setupRefresh() {
  setTimeout(refreshPage, 5000); // milliseconds
}

function refreshPage() {
  window.location = location.href;
}