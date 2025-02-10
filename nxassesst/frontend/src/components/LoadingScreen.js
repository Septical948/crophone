import React, { useEffect, useState } from 'react';
import './LoadingScreen.css';  // Importamos el archivo CSS para los estilos

const LoadingScreen = () => {
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Simula una carga de 3 segundos antes de cambiar la pantalla
    setTimeout(() => {
      setLoading(false);
    }, 3000); // 3000ms = 3 segundos
  }, []);

  if (!loading) {
    return <div>¡La aplicación está lista!</div>; // O puedes redirigir a otro componente
  }

  return (
    <div className="loading-screen">
      <div className="logo-container">
        <img src="/assets/Netxora.png" alt="Logo" className="logo" />
      </div>
      <div className="spinner"></div>
    </div>
  );
};

export default LoadingScreen;
