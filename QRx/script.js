
document.addEventListener("DOMContentLoaded", function () {
  const loginForm = document.getElementById("loginForm");

  loginForm.addEventListener("submit", function (event) {
    event.preventDefault(); // Prevents page refresh

    const username = document.getElementById("username").value.trim();
    const password = document.getElementById("password").value.trim();

    if (username === "admin" && password === "1234") {
      alert("Login successful! Welcome, " + username + "!");
    } else {
      alert("Invalid username or password. Try again.");
    }
  });
});
