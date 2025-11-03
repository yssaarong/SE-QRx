document.addEventListener("DOMContentLoaded", function () {
  const signupForm = document.getElementById("signupForm");
  const togglePassword = document.getElementById("togglePassword");
  const toggleConfirm = document.getElementById("toggleConfirm");
  const passwordField = document.getElementById("password");
  const confirmField = document.getElementById("confirmPassword");
  const loader = document.getElementById("loader");
  const signupButton = document.getElementById("signupButton");

  togglePassword.addEventListener("click", () => {
    const type = passwordField.getAttribute("type") === "password" ? "text" : "password";
    passwordField.setAttribute("type", type);
    togglePassword.textContent = type === "password" ? "👁️" : "🙈";
  });

  toggleConfirm.addEventListener("click", () => {
    const type = confirmField.getAttribute("type") === "password" ? "text" : "password";
    confirmField.setAttribute("type", type);
    toggleConfirm.textContent = type === "password" ? "👁️" : "🙈";
  });

  signupForm.addEventListener("submit", (e) => {
    e.preventDefault();
    loader.style.display = "block";
    signupButton.disabled = true;

    const username = document.getElementById("username").value.trim();
    const email = document.getElementById("email").value.trim();
    const password = passwordField.value.trim();
    const confirmPassword = confirmField.value.trim();

    setTimeout(() => {
      loader.style.display = "none";
      signupButton.disabled = false;

      if (!username || !email || !password || !confirmPassword) {
        alert("Please fill in all fields.");
        return;
      }

      if (password !== confirmPassword) {
        alert("Passwords do not match!");
        return;
      }

      if (!/\S+@\S+\.\S+/.test(email)) {
        alert("Please enter a valid email address.");
        return;
      }

      alert(`Account created successfully! Welcome to QRx, ${username}!`);
      signupForm.reset();
      window.location.href = "index.html";
    }, 1200);
  });
});
