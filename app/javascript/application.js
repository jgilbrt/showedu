// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./controllers"
import Rails from "@rails/ujs"

Rails.start()

  function toggleCommentBox(id) {
    const box = document.getElementById(`comment-box-${id}`);
    if (box.style.display === "none" || box.style.display === "") {
      box.style.display = "block";
    } else {
      box.style.display = "none";
    }
  }
