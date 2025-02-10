const readline = require('readline');
const axios = require('axios');

// Configurar la interfaz para leer desde el CMD
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// Pedir al usuario su nombre de usuario
rl.question('Ingrese su nombre de usuario: ', (username) => {
  // Pedir al usuario su contraseña
  rl.question('Ingrese su contraseña: ', (password) => {
    // Hacer la solicitud a la API para verificar el login
    axios.post('http://localhost:3000/login', { username, password })
      .then(response => {
        if (response.data.success) {
          console.log(`Login exitoso! Bienvenido ${response.data.user.username}`);
        } else {
          console.log('Error: ' + response.data.message);
        }
      })
      .catch(error => {
        console.log('Hubo un problema con la conexión:', error);
      })
      .finally(() => {
        rl.close(); // Cerrar la interfaz de lectura después de la respuesta
      });
  });
});
