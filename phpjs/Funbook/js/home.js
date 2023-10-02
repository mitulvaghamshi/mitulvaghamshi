// list container for user posts
const postList = $("#post-list");

// new post buttons
const postBtn = $("#post-btn").click(addNewThought);
const postImgBtn = $("#post-img-btn").click(addNewImage);

// login register forms screens
const logoutBtn = $("#logout").click(() => {
  fetch("./php/logout.php", { credentials: "include" })
    .then((res) => res.json()).then((res) => {
      if (parseInt(res) === 0) {
        location.href = "./index.html";
      }
    });
});

// get user content when page ready
$(document).ready(() => getUserData());

// get user data from the database
function getUserData() {
  $.post("./php/get-user-data.php", (res) => {
    const data = JSON.parse(res);
    data.forEach((element) => {
      /* if the post is an image */
      if (parseInt(element["type"]) === 1) {
        $.post("./php/get-image.php", { id: element["data"] }, (res) => {
          const imgData = JSON.parse(res);
          createImage(
            imgData["imageUrl"],
            element["likes"],
            element["dislikes"],
          );
        });
      } else { // or the post is a thought
        createThought(element["data"], element["likes"], element["dislikes"]);
      }
    });
  });
}

// create and add new image post element
function createImage(url, likes, dislikes) {
  const postContainer = $("<div></div>").attr("id", "post");
  const postImage = $("<img>").attr({ id: "post-image", src: url });
  $(postContainer)
    .append(postImage)
    .append(createReactions(likes, dislikes));
  $(postList).prepend(postContainer);
}

// add new image post
function addNewImage() {
  const id = Math.floor(Math.random() * 99) + 1; // get a random image
  $.post("./php/get-image.php", { id: id }, (res) => {
    const data = JSON.parse(res);
    createImage(data["imageUrl"], 0, 0);
    $.post("./php/insert-post.php", { type: 1, data: id }); // insert new image post data to user record
  });
}

// create like dislike buttons
function createReactions(likes, dislikes) {
  const reactionContainer = $("<div></div>").attr("id", "reactions");
  const likeButton = $("<button></button>")
    .addClass("reaction-btn")
    .text(`Likes: ${likes}`);
  const dislikeButton = $("<button></button>")
    .addClass("reaction-btn")
    .text(`Disikes: ${dislikes}`);
  $(reactionContainer).append(likeButton);
  $(reactionContainer).append(dislikeButton);
  return reactionContainer;
}

// create and add new thougth post
function createThought(text, likes, dislikes) {
  const postContainer = $("<div></div>").attr("id", "post");
  const postText = $("<h2></h2>").attr({
    id: "thought",
    class: "input-field",
  }).text(text);
  $(postContainer).append(postText);
  $(postContainer).append(createReactions(likes, dislikes));
  $(postList).prepend(postContainer);
}

// add new thought post
function addNewThought() {
  const textArea = $("#new-post");
  const value = $(textArea).val();
  if (value !== "") {
    createThought(value, 0, 0);
    $(textArea).val("");
    $.post("./php/insert-post.php", { type: 0, data: value }); // add record into userdata
  } else {
    $(textArea).focus();
  }
}
