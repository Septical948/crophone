import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './Login.css';  // Importar el CSS que se aplicará a este componente

const Login = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const navigate = useNavigate();  // Hook para redirigir al dashboard

  // Handler del login
  const handleLogin = (e) => {
    e.preventDefault();
    if (!username || !password) {
      setError('Por favor, ingrese su nombre de usuario y contraseña.');
      return;
    }
    // Validación del login con datos de ejemplo o API
    if (username === 'admin' && password === 'password') {
      // Aquí iría la lógica de validación contra una API o base de datos
      navigate('/dashboard');  // Redirige al dashboard en caso de éxito
    } else {
      setError('Nombre de usuario o contraseña incorrectos.');
    }
  };

  return (
    <div className="login-container">
      <form className="form" onSubmit={handleLogin} autoComplete="off">
        <div className="logo">
          <img src="/assets/logo.png" alt="Logo" />  {/* Asegúrate de que la ruta del logo es correcta */}
        </div>
        <div className="control">
          <h1>Sign In</h1>
        </div>
        {error && <p className="error-message">{error}</p>}
        <div className="control block-cube block-input">
          <input
            type="text"
            name="username"
            placeholder="Username"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
          />
          <div className="bg-top"><div className="bg-inner"></div></div>
          <div className="bg-right"><div className="bg-inner"></div></div>
          <div className="bg"><div className="bg-inner"></div></div>
        </div>
        <div className="control block-cube block-input">
          <input
            type="password"
            name="password"
            placeholder="Password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
          <div className="bg-top"><div className="bg-inner"></div></div>
          <div className="bg-right"><div className="bg-inner"></div></div>
          <div className="bg"><div className="bg-inner"></div></div>
        </div>
        <div className="control block-cube block-input">
          <button className="btn block-cube block-cube-hover" type="submit">
            <div className="bg-top"><div className="bg-inner"></div></div>
            <div className="bg-right"><div className="bg-inner"></div></div>
            <div className="bg"><div className="bg-inner"></div></div>
            <div className="text">Log In</div>
          </button>
        </div>
      </form>
    </div>
  );
};

export default Login;
