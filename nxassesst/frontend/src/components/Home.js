import React, { useState, useEffect } from 'react';
import './Home.css';
const Home = () => {
  const [loading, setLoading] = useState(true);

  // Usamos useEffect para simular un tiempo de carga antes de mostrar la app
  useEffect(() => {
    setTimeout(() => {
      setLoading(false); // Cambia el estado después de 3 segundos
    }, 3000); // 3000ms = 3 segundos
  }, []);

  return (
    <div className={`home-container ${loading ? 'loading' : 'loaded'}`}>
      {/* Fondo de iluminación */}
      <div className="background-light"></div>

      {/* Logo con animación de aparición */}
      <div className={`logo-container ${loading ? 'logo-appear' : 'logo-loaded'}`}>
        <img src="/path-to-your-logo.png" alt="Logo" className="logo" />
      </div>

      {/* Cargando - Rueda giratoria */}
      {loading && (
        <div className="loading-spinner">
          <div className="spinner"></div>
        </div>
      )}
    </div>
  );
};

export default Home;
