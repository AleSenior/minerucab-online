const slides = document.querySelectorAll('input[name="carousel"]');
let currentIndex = 0;

const changeSlide = () => {
  slides[currentIndex].checked = false;
  currentIndex = (currentIndex + 1) % slides.length;
  slides[currentIndex].checked = true;
};

setInterval(changeSlide, 3000);



document.getElementById('login-form').addEventListener('submit', function(event) {
    event.preventDefault();
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
  
    // Aquí puedes agregar la lógica de autenticación
    if (username === 'admin' && password === 'admin') {
      alert('Login successful');
    } else {
      alert('Invalid username or password');
    }
  });