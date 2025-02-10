import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import "./Login.css"; // Asegúrate de que el archivo .css se llame login.css

const LoginPage = () => {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState(null);
  const navigate = useNavigate();

  const handleLogin = async (e) => {
    e.preventDefault();

    // Aquí es donde harías la validación contra tu base de datos (API)
    const userCredentials = { username, password };

    // Simulando una API de login
    const response = await fetch("https://miapi.com/login", {
      method: "POST",
      body: JSON.stringify(userCredentials),
      headers: {
        "Content-Type": "application/json",
      },
    });

    if (response.ok) {
      // Suponiendo que la respuesta contiene los datos del usuario
      const data = await response.json();
      localStorage.setItem("user", JSON.stringify(data)); // Guarda el usuario en localStorage
      navigate("/dashboard"); // Redirige al dashboard
    } else {
      setError("Credenciales incorrectas");
    }
  };

  return (
    <div className="login-container">
      <h2>Iniciar sesión</h2>
      {error && <p className="error">{error}</p>}
      <form onSubmit={handleLogin}>
        <input
          type="text"
          placeholder="Usuario"
          value={username}
          onChange={(e) => setUsername(e.target.value)}
        />
        <input
          type="password"
          placeholder="Contraseña"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
        <button type="submit">Iniciar sesión</button>
      </form>
    </div>
  );
};

export default LoginPage;
