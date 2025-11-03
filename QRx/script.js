document.addEventListener("DOMContentLoaded", function () {
  const loginForm = document.getElementById("loginForm");
  const togglePassword = document.getElementById("togglePassword");
  const passwordField = document.getElementById("password");
  const loader = document.getElementById("loader");
  const loginButton = document.getElementById("loginButton");
  const languageSelect = document.getElementById("language");

  passwordField.addEventListener("keypress", (e) => {
    if (e.key === "Enter") {
      loginButton.click();
    }
  });

  togglePassword.addEventListener("click", () => {
    const type = passwordField.getAttribute("type") === "password" ? "text" : "password";
    passwordField.setAttribute("type", type);
    togglePassword.textContent = type === "password" ? "👁️" : "🙈";
    
    togglePassword.classList.add("fade");
    setTimeout(() => togglePassword.classList.remove("fade"), 200);
  });

  loginForm.addEventListener("submit", (e) => {
    e.preventDefault();
    loader.style.display = "block";
    loginButton.disabled = true;

    setTimeout(() => {
      loader.style.display = "none";
      loginButton.disabled = false;

      const username = document.getElementById("username").value.trim();
      const password = passwordField.value.trim();

      if (username === "admin" && password === "1234") {
        alert(`Login successful! Welcome to QRx, ${username}!`);
      } else {
        alert("Invalid username or password. Try again.");
      }
    }, 1200);
  });

  const translations = {
    ceb: {
      title: "QRx",
      subtitle: "Susiha ang imong tambal aron malikayan ang peke!",
      login: "Sulod",
      signup: "Wala pa kay account? Pagrehistro dinhi.",
    },
    tl: {
      title: "QRx",
      subtitle: "I-verify ang gamot mo upang maiwasan ang peke!",
      login: "Mag-login",
      signup: "Wala ka pang account? Mag-sign up dito.",
    },
  };

  languageSelect.addEventListener("change", () => {
    const lang = languageSelect.value;
    if (translations[lang]) {
      document.querySelector(".title").textContent = translations[lang].title;
      document.querySelector(".subtitle").textContent = translations[lang].subtitle;
      document.querySelector("button[type='submit']").textContent = translations[lang].login;
      document.querySelector(".signup-text").innerHTML = translations[lang].signup;
    } else {
      location.reload();
    }
  });
});
