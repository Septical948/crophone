import React from "react";
import "./Header.css";

const Header = () => {
  return (
    <nav className="navbar">
      <a href="/">
        <img
          src="https://i.imgur.com/AJvpuLb.png"
          alt="Logo"
          className="logo"
        />
      </a>
    </nav>
  );
};

export default Header;
